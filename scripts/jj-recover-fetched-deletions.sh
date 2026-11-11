#!/usr/bin/env bash
#
# jj-recover-fetched-deletions.sh
#
# Finds the most recent `jj git fetch` operation, figures out which local
# bookmarks it deleted (because the corresponding branch disappeared on the
# remote), and recreates each of them at their pre-fetch position under a
# `deleted-` prefix.
#
# Usage:
#   ./jj-recover-fetched-deletions.sh            # do it
#   ./jj-recover-fetched-deletions.sh --dry-run  # just show what would happen
#
# Notes / caveats:
#  - Only looks at the single most recent fetch operation. If you want to
#    recover from an older fetch, pass its operation id as $1 (see below).
#  - Relies on `jj op log` / `jj bookmark list` template keywords (`id`,
#    `description`, `name`) which have been stable for a while but could
#    change in future jj releases -- if this breaks, check
#    `jj op log -T` / `jj bookmark list -T` --help output for your version.
#  - This is a reactive recovery tool, not a permanent fix. If you know in
#    advance you want a bookmark to survive remote deletion, prefer
#    `jj bookmark untrack <name>@<remote>`.

set -euo pipefail
set -x

DRY_RUN=0
FETCH_OP="${1:-}"
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
  FETCH_OP="${2:-}"
fi

# --- 1. Locate the fetch operation -----------------------------------------

if [[ -z "$FETCH_OP" ]]; then
  FETCH_OP=$(jj op log --no-graph --limit 100 -T 'id.short() ++ " " ++ description.first_line() ++ "\n"' \
    | awk 'tolower($0) ~ /fetch/ && !found { print $1; found=1 }')
fi

if [[ -z "$FETCH_OP" ]]; then
  echo "Could not find a fetch operation in 'jj op log'." >&2
  exit 1
fi
echo "Fetch operation: $FETCH_OP"

# --- 2. Locate its parent (the state just before the fetch) ----------------

PARENT_OP=$(jj op log --no-graph --limit 100 -T 'id.short() ++ "\n"' | awk -v target="$FETCH_OP" '
  $0 == target { found=1; next }
  found { print; exit }
')

if [[ -z "$PARENT_OP" ]]; then
  echo "Could not determine the operation before the fetch." >&2
  exit 1
fi
echo "Pre-fetch operation: $PARENT_OP"

# --- 3. Diff local bookmarks before vs. after -------------------------------

list_local_bookmarks() {
  # Local bookmarks only: exclude remote-tracking entries like "name@origin"
  jj bookmark list --at-op="$1" -T 'name ++ "\n"' | grep -v '@' | sort -u
}

BEFORE=$(list_local_bookmarks "$PARENT_OP")
AFTER=$(list_local_bookmarks "$FETCH_OP")

DELETED=$(comm -23 <(echo "$BEFORE") <(echo "$AFTER") || true)

if [[ -z "$DELETED" ]]; then
  echo "No local bookmarks were deleted by this fetch."
  exit 0
fi

echo "Bookmarks deleted by this fetch:"
echo "$DELETED" | sed 's/^/  - /'
echo

# --- 4. Recreate each one at its pre-fetch commit, with a prefix -----------

while IFS= read -r name; do
  [[ -z "$name" ]] && continue

  commit=$(jj log --at-op="$PARENT_OP" -r "$name" --no-graph -T 'commit_id ++ "\n"' | head -n1)
  if [[ -z "$commit" ]]; then
    echo "  Skipping '$name': could not resolve its pre-fetch commit." >&2
    continue
  fi

  new_name="deleted-${name}"

  if jj bookmark list -T 'name ++ "\n"' | grep -qx "$new_name"; then
    echo "  Skipping '$name': '$new_name' already exists." >&2
    continue
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "  [dry-run] would create '$new_name' at $commit (was '$name')"
  else
    jj bookmark create "$new_name" -r "$commit"
    echo "  Created '$new_name' at $commit (was '$name')"
  fi
done <<< "$DELETED"
