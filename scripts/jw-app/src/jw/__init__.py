import argparse
import shutil
import subprocess
import sys
from pathlib import Path

from simple_term_menu import TerminalMenu

CREATE = "create new..."
DELETE = "delete workspace..."
CUSTOM_REV = "custom..."
MAIN_ORIGIN = "main@origin"


def _jj(args: list[str], *, cwd: Path | None = None, ignore_working_copy: bool = False) -> str:
    cmd = ["jj", "--no-pager", "--color=never"]
    if ignore_working_copy:
        cmd.append("--ignore-working-copy")
    cmd.extend(args)
    proc = subprocess.run(cmd, cwd=cwd, text=True, capture_output=True)
    if proc.returncode != 0:
        message = (proc.stderr or proc.stdout).strip()
        raise SystemExit(message or f"jj failed ({proc.returncode})")
    return proc.stdout


def workspace_names() -> list[str]:
    out = _jj(
        ["workspace", "list", "-T", 'name ++ "\n"'],
        ignore_working_copy=True,
    )
    names = [line.strip() for line in out.splitlines() if line.strip()]
    if "default" in names:
        return ["default", *[name for name in names if name != "default"]]
    return names


def workspace_root(name: str) -> Path:
    return Path(
        _jj(
            ["workspace", "root", "--name", name],
            ignore_working_copy=True,
        ).strip()
    )


def _prompt(label: str) -> str | None:
    with open("/dev/tty", encoding="utf-8") as tty_in, open("/dev/tty", "w", encoding="utf-8") as tty_out:
        tty_out.write(label)
        tty_out.flush()
        line = tty_in.readline()
    if not line:
        return None
    value = line.strip()
    return value or None


def local_bookmarks() -> list[str]:
    out = _jj(
        ["bookmark", "list", "-T", 'if(!remote, name ++ "\n", "")'],
        ignore_working_copy=True,
    )
    return sorted({line.strip() for line in out.splitlines() if line.strip()})


def _choose_revision() -> str | None:
    bookmarks = [name for name in local_bookmarks() if name not in {CUSTOM_REV, MAIN_ORIGIN}]
    entries = [CUSTOM_REV, MAIN_ORIGIN, *bookmarks]
    menu = TerminalMenu(entries, title="Revision")
    index = menu.show()
    if index is None:
        return None
    if entries[index] == CUSTOM_REV:
        return _prompt("Revision: ")
    return entries[index]


def _commit_ids(revision: str) -> list[str]:
    out = _jj(["log", "-r", revision, "--no-graph", "-T", 'commit_id ++ "\n"'])
    ids = [line.strip() for line in out.splitlines() if line.strip()]
    if not ids:
        raise SystemExit(f"Revision not found: {revision}")
    return ids


def _validate_name(name: str, existing: set[str]) -> str | None:
    if (
        name in {".", ".."}
        or "/" in name
        or "\\" in name
        or "\x00" in name
        or name.startswith("-")
    ):
        return "Invalid workspace name"
    if name in existing:
        return f"Workspace already exists: {name}"
    return None


def create_workspace(name: str, revision: str) -> Path:
    default_root = workspace_root("default")
    dest = default_root.parent / name
    if dest.exists():
        raise SystemExit(f"Destination already exists: {dest}")
    cmd = ["jj", "--no-pager", "--color=never", "workspace", "add", "--name", name]
    for rev in _commit_ids(revision):
        cmd.extend(["-r", rev])
    cmd.append(str(dest))
    proc = subprocess.run(cmd, cwd=default_root)
    if proc.returncode != 0:
        raise SystemExit(proc.returncode)
    return dest


def _create_from_prompt(existing: list[str]) -> Path | None:
    known = set(existing)
    while True:
        name = _prompt("Workspace name: ")
        if name is None:
            return None
        error = _validate_name(name, known)
        if error:
            print(error, file=sys.stderr)
            continue
        revision = _choose_revision()
        if revision is None:
            return None
        return create_workspace(name, revision)


def _confirm(title: str) -> bool:
    menu = TerminalMenu(["No", "Yes"], title=title)
    return menu.show() == 1


def _deletable_names(names: list[str]) -> list[str]:
    return [name for name in names if name != "default"]


def _forget_and_delete(name: str, names: list[str]) -> None:
    root = workspace_root(name).resolve()
    if root == Path(root.anchor):
        raise SystemExit(f"Refusing to delete {root}")
    cwd = workspace_root("default") if "default" in names else None
    _jj(["workspace", "forget", name], cwd=cwd)
    if not root.exists():
        return
    try:
        shutil.rmtree(root)
    except OSError as exc:
        raise SystemExit(f"Workspace forgotten, but failed to delete {root}: {exc}") from exc


def _delete_from_menu(names: list[str]) -> None:
    deletable = _deletable_names(names)
    if not deletable:
        print("No workspaces to delete", file=sys.stderr)
        return
    while True:
        menu = TerminalMenu(deletable, title="Delete workspace")
        index = menu.show()
        if index is None:
            return
        name = deletable[index]
        root = workspace_root(name)
        title = f"Delete jj workspace '{name}' and its folder?\n{root}"
        if not _confirm(title):
            continue
        _forget_and_delete(name, names)
        return


def choose(names: list[str]) -> Path | None:
    while True:
        menu = TerminalMenu([CREATE, DELETE, *names], title="Workspaces")
        index = menu.show()
        if index is None:
            return None
        if index == 0:
            return _create_from_prompt(names)
        if index == 1:
            _delete_from_menu(names)
            names = workspace_names()
            continue
        return workspace_root(names[index - 2])


def main() -> None:
    parser = argparse.ArgumentParser(prog="jw")
    parser.add_argument("--result", required=True)
    args = parser.parse_args()
    names = workspace_names()
    if not names:
        raise SystemExit("No workspaces found")
    dest = choose(names)
    if dest is not None:
        Path(args.result).write_text(f"{dest}\n", encoding="utf-8")
