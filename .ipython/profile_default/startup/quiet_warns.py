try:
    import warnings

    from numba.core.errors import (
        NumbaDeprecationWarning,
        NumbaPendingDeprecationWarning,
    )

    warnings.simplefilter("ignore", category=NumbaDeprecationWarning)
except ImportError:
    pass
