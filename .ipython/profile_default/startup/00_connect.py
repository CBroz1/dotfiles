"""DataJoint database connection for IPython startup.

Reads the first CLI arg as the database name and attempts to connect using
the first credentials file found in cwd or ~/wrk/alt/creds/.
"""

import sys
from pathlib import Path

try:
    import datajoint as dj

    HAS_DATAJOINT = True
except ImportError:
    dj = None
    HAS_DATAJOINT = False


def get_creds_file(db):
    """Return path to the credentials file for the given database name."""
    suffix = "" if db.lower() in ("", "none") else f"_{db}"
    for creds_dir in [Path("."), Path("~/wrk/alt/creds/").expanduser()]:
        creds_file = creds_dir / f"dj_local_conf.json{suffix}"
        if creds_file.exists():
            return creds_file


def connect_to_database():
    """Connect to DataJoint database named by the first CLI arg.

    Returns the database name with a trailing space (for prompt use), or an
    empty string if no connection was made.
    """
    if len(sys.argv) <= 1 or not HAS_DATAJOINT:
        return ""

    db_name = sys.argv[1]
    dj_conf_path = get_creds_file(db_name)
    print("Credentials file      : ", dj_conf_path)

    try:
        dj.config.load(dj_conf_path)
        dj.conn()
        return db_name + " "
    except Exception as e:
        print("Failed to connect to  : ", db_name)
        print("Error                 : ", e)
        return ""


DATABASE = connect_to_database()
