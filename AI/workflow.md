# AI setup

Make sure to note that several useful agents are available in `.opencode/agents` and that you should use them to 
delegate tasks to them.

# Workspace setup

The task you are about to start requires you to work on a jj workspace.
Before starting, confirm that you are in the right jj workspace.
You'll use the name of the jj workspace as the name of the bookmark you'll update too after each commit.

# Using jj throughout the session

Throughout this session, after each user interaction, be sure to check the state of 
the workspace and update it if it's staled, to make sure you take into account the 
modifications that the user might have done to the code in the meantime.
Also, after each interaction that triggers a code change, or after each described task if you take your instructions 
from a file, you should commit the code, move the bookmark to the current commit and refresh the workspace so that the 
user can see the changes you made.

You are not allowed to disable commit signing. If signing does not work, warn the user and halt the work.

# Task wrap up

When you are done with a task:

- [ ] commit the code
- [ ] move the jj bookmark to the current commit

A task can be either a direct user instruction, or a task described in an instruction file (see below).

# Working from an instruction file

If you are working for an instruction markdown file, you should follow the instructions in the file.
The file is divided into tasks. Each task should be considered a separate unit of work which will require its wrap up 
(commit, jj bookmark update).
When a task is done, you should modify the instruction file so that
- in the title of the task, the task is prefixed with "DONE - "
- You should add a line just below the title of the task that says "DONE - <jj commit>" where <jj commit> is the commit 
reference of the commit you made to complete the task.
- in the task description, any instructions that was using a list (`- [ ] `) should be replaced with a list with checked items (`- [x] `)

# Leaving TODO

When part of a task is not done due to instructions to leave it to the user as a todo, the relevant places in the 
code should be marked with `TODO - gba - <task name> - <short description>` as a comment.

# Acceptance criteria

- [ ] Make sure that the architecture principles are respected.
- [ ] Make sure all the new code you created in `back` is tested. There should generally be at least one test per 
public method.
- [ ] Make sure all the tests pass (the new and the old ones)
