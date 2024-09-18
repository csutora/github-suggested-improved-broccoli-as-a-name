import os, sys
TODO_FILE = os.getenv('TODO_FILE_PATH', 'todo.md') # you can set the TODO_FILE_PATH environment variable in your shell config and the script will use that. i also recommend creating shell aliases, like 'todo' -> 'python /path/to/todo.py' and 'done' -> 'todo do'
def read_todos(): return open(TODO_FILE, 'r').readlines() if os.path.exists(TODO_FILE) else []
def write_todos(todos): open(TODO_FILE, 'w').writelines(todos)
def add_todo(text): write_todos(read_todos() + [f"- [ ] {text.strip()}\n"])
def list_todos(i = 0): print(''.join([f"{(i := i + todo.startswith('- ['))} {todo[2:]}" if todo.startswith('- [') else f"{todo}" for todo in read_todos()]), end='') # including initializations in the function header was a genius idea by my girlfriend to make all this fit
def toggle_todo(todo_number, is_done, todos, i = 0): write_todos([f"- [{'x' if is_done else ' '}] {todo[6:]}" if todo.startswith('- [') and (i := i + 1) == todo_number else todo for todo in todos])
def clear_done(): write_todos([todo for todo in read_todos() if not todo.startswith('- [x]')])
def main(): [([add_todo(arg) for arg in args] if action == 'add' else [toggle_todo(int(arg), action == 'do', read_todos()) for arg in args if arg.isdigit()] if action in ['do', 'undo'] else list_todos() if action == 'list' else clear_done() if action == 'clear' else print('\ni was thinking "i need a simple cli todo app"\nand then "wait i could write that in like 30 lines of python",\nand so i did it in 10 and made it completely unreadable.\nseriously, it\'s ten lines. what did you expect?\n - marton csutora\n\n================================\n\n# usage: todo [action] [args]\n\n# actions:\n- list (default): lists the todos. can handle if the todo file has lines that aren\'t todos,\n  but you\'ll need to edit those with another program. you know, unix philosophy.\n- add: adds all further arguments as todos.\n- do/undo: marks all further arguments as done or not done.\n- clear: clears all todos that are marked as done.\n\n# todo file:\nyou can override the default todo file (todo.md in the current directory)\nvia the TODO_FILE_PATH environment variable.\n\n# usage with piped input: <output from other program> | todo [action]\nhere your options are only add, do, or undo, and add is the default.\nalso, add treats the whole input as one todo in this case.\n\n# recommendation:\nset shell aliases like "todo" -> "python /path/to/todo.py" and "done" -> "todo do"\n\nhave fun doing!\n')  ) for action, args in [(('list' if sys.stdin.isatty() else 'add') if len(sys.argv) < 2 else sys.argv[1], (["you shouldn't see this ever, message me at marton<at>csutora<dot>com if you do"] if len(sys.argv) < 3 else sys.argv[2:]) if sys.stdin.isatty() else ([''.join(sys.stdin.read().strip())] if len(sys.argv) < 2 or sys.argv[1] == 'add' else sys.stdin.read().strip().split() if sys.argv[1] in ['do', 'undo'] else ["this should only ever be visible from the source code, message me if you see this at marton<at>csutora<dot>com"]))]] # this is the most horrendous single line of code i have ever written (it is over 2000 characters long)
if __name__ == '__main__': main()