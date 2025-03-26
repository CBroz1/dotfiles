"""Custom IPython prompt with DataJoint connection status.

Probably should be split into separate files for each feature (prompt, connect)

1. Checks first arg, assumes is name of database to connect to.
2. If DataJoint is installed, tries to connect to the database using the first
    credentials file found in the current directory or in ~/wrk/alt/creds/.
3. If DataJoint is installed and connected, and the database is not production
    (starts with 'pro'), and if the datajoint_utilities package is installed,
    defines a func `drop_all_schemas` that drops all schemas in the database.
"""

import sys
from importlib import util as importlib_util
from pathlib import Path

from IPython.terminal.prompts import Prompts, Token


def get_creds_file(db):
    """Get the path to the credentials file for the database."""
    db = "" if db.lower() in [0, "none"] else f"_{db}"
    creds_dirs = [Path("."), Path("~/wrk/alt/creds/").expanduser()]
    for creds_dir in creds_dirs:
        creds_file = creds_dir / f"dj_local_conf.json{db}"
        # print("Testing path          : ", creds_file)
        if creds_file.exists():
            return creds_file


DATABASE = ""
if len(sys.argv) > 1:
    DATABASE = sys.argv[1]
    # print("Database              : ", DATABASE)


CONNECTED = False
HAS_DATAJOINT = importlib_util.find_spec("datajoint") is not None
if DATABASE and HAS_DATAJOINT:
    import datajoint as dj

    dj_conf_path = get_creds_file(DATABASE)
    print("Credentials file      : ", dj_conf_path)

    try:
        dj.config.load(dj_conf_path)
        dj.conn()
        DATABASE += " "
        CONNECTED = True
    except Exception as e:  # noqa E722
        print("Failed to connect to  : ", DATABASE)
        print("Error message         : ", e)
        DATABASE = ""

HAS_DJ_UTILS = importlib_util.find_spec("datajoint_utilities") is not None
if CONNECTED and DATABASE[:3].lower() != "pro" and HAS_DJ_UTILS:
    from datajoint_utilities.dj_search.lists import drop_schemas

    def drop_all_schemas(prefix="", dry_run=True, force_drop=True):
        drop_schemas(prefix, dry_run=dry_run, force_drop=force_drop)


# WON'T WORK WITH PYTHON 3.10
class MyPrompt(Prompts):
    def in_prompt_tokens(self):
        vi = self.vi_mode().strip("[]")[0].upper() + " "
        return [
            (Token.Name.Class, vi),  # purple
            (Token.OutPrompt, DATABASE.upper()),  # pink
            (Token.Prompt, "["),  # green
            (Token.PromptNum, str(self.shell.execution_count)),
            (Token.Prompt, "]: "),
            # -- OPTIONS --
            # (Token.Comment, "Comment"), # Grey italic
            # (Token.Operator, "Operator"), # white
            # (Token.Prompt, "Prompt"), # green
            # (Token.Keyword, "Keyword"), # Dark green
            # (Token.Number, "Number"), # Light green
            # (Token.OutPrompt, "OutPrompt"), # pink
            # (Token.OutPromptNum, "OutPromptNum"), # bold pink
        ]


ip = get_ipython()
ip.prompts = MyPrompt(ip)
