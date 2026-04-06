"""IPython utility setup: drop_all_schemas helper and spyglass autoreload.

Runs only when a DataJoint database connection was established by 00_connect.py.
"""

from importlib import util as importlib_util


def _make_drop_all_schemas(database):
    """Return a drop_all_schemas function if conditions permit, else None.

    Skipped when: no database is connected, the database name starts with
    'pro' (production guard), or datajoint_utilities is not installed.
    """
    if not database or database[:3].lower() == "pro":
        return None
    if importlib_util.find_spec("datajoint_utilities") is None:
        return None

    from datajoint_utilities.dj_search.lists import drop_schemas

    def drop_all_schemas(prefix="", dry_run=True, force_drop=True):
        drop_schemas(prefix, dry_run=dry_run, force_drop=force_drop)

    return drop_all_schemas


# DATABASE is set in 00_connect.py (shared IPython startup namespace)
_database = get_ipython().user_ns.get("DATABASE", "")  # noqa: F821

if _database:
    drop_all_schemas = _make_drop_all_schemas(_database)

    if importlib_util.find_spec("spyglass") is not None:
        _ip = get_ipython()  # noqa: F821
        _ip.run_line_magic("load_ext", "autoreload")
        _ip.run_line_magic("autoreload", "2")
