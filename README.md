![github suggested improved broccoli as a name](suggestion.png)

i was thinking "i need a simple cli todo app"
and then "wait i could write that in like 30 lines of python",
and so i did it in 10 and made it completely unreadable.
seriously. it's ten lines, what did you expect?

# usage
`python3 todo.py [action] [args]`

### actions
- `list` (default): lists the todos. can handle if the todo file has lines that aren't todos,
  but you'll need to edit those with another program. you know, unix philosophy.
- `add`: adds all further arguments as todos.
- `do`/`undo`: marks all further arguments as done or not done.
- `clear`: clears all todos that are marked as done.

### todo file
you can override the todo file used (default is todo.md in the current directory)
via the `TODO_FILE_PATH` environment variable.

### usage with piped input
`<output from other program> | python3 todo.py [action]`
here your options are only `add`, `do`, or `undo`, and `add` is the default.
also, `add` treats the whole input as one todo in this case.

### recommendation:
set shell aliases like `todo` -> `python /path/to/todo.py` and `done` -> `todo do`

<br/>

have fun doing!
