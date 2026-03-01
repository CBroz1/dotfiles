"""Quit alias: exit IPython by typing 'off' or 'off()'."""

from IPython import get_ipython


class _Quitter:
    """Exit IPython when evaluated (off) or called (off()).

    Mirrors the behaviour of Python's built-in quit/exit objects so that
    merely typing the name triggers the exit, without needing parentheses.
    """

    def __repr__(self):
        self()
        return ""

    def __call__(self, _=""):
        get_ipython().ask_exit()


off = _Quitter()
