![github suggested improved broccoli as a name](suggestion.png)

this mess was cleaned up by [tamas turo](https://www.facebook.com/tamas.turo.3/)

# installation

unlike python, you actually have to compile this.

1. **get dependencies** (you need `ghc` and `libgmp`):
```bash
# ubuntu/debian
sudo apt install ghc libgmp-dev

# fedora
sudo dnf install ghc gmp-devel

# macos
brew install ghc

```


2. **compile**:
```bash
ghc -O2 -no-keep-hi-files -no-keep-o-files todo.hs -o todo

```



# usage

`./todo [action] [args]`

### actions

* `list` (default): lists the todos. can handle if the todo file has lines that aren't todos,
but you'll need to edit those with another program.
* `add`: adds all further arguments as todos.
* `do`/`undo`: marks all further arguments as done or not done.
* `clear`: clears all todos that are marked as done.

### todo file

you can override the todo file used (default is `todo.md` in the current directory)
via the `TODO_FILE_PATH` environment variable.

### usage with piped input

`<output from other program> | ./todo [action]`
here your options are only `add`, `do`, or `undo`, and `add` is the default.
also, `add` treats the whole input as one todo in this case.

### recommendation:

set shell aliases like `todo` -> `/path/to/todo` and `done` -> `todo do`

have fun doing!