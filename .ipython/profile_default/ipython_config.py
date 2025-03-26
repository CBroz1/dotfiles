# Configuration file for ipython.

c = get_config()  # noqa
c.TerminalInteractiveShell.shortcuts = [
    {
        "command": "IPython:auto_suggest.accept_or_jump_to_end",
        "new_keys": ["c-]"],
        "create": True,
    }
]
c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.editor = "vi"
c.TerminalInteractiveShell.emacs_bindings_in_vi_insert_mode = True
c.TerminalInteractiveShell.prompt_includes_vi_mode = True


c.AliasManager.user_aliases = [("ls", "ls -aGg")]

c.InteractiveShell.banner1 = ""
c.TerminalIPythonApp.display_banner = False
c.TerminalIPythonApp.exec_lines = [
    "import platform; v=platform.python_version(); print(f'🌸 python {v} 🌸')",
]
