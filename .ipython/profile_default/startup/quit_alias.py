from IPython.core.magic import register_line_magic
from IPython import get_ipython

@register_line_magic
def off(line=''):
    """Exit IPython (alias for 'quit')."""
    get_ipython().ask_exit()




