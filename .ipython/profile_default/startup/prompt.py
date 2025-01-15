import os
import sys
from pathlib import Path

from IPython.terminal.prompts import Prompts, Token

CONDA = os.getenv("CONDA_DEFAULT_ENV", "")
DATABASE = ""
CONNECTED = False

if len(sys.argv) > 1:
    DATABASE = sys.argv[1]

if DATABASE and CONDA.lower() in ["spy", "src", "slc"]:
    import datajoint as dj

    print("Connecting to database: ", DATABASE)
    dj_conf_path = Path(
        f"dj_local_conf.json_{DATABASE}"
        if DATABASE.lower() not in [0, "none"]
        else "dj_local_conf.json"
    )
    if not dj_conf_path.exists():
        dj_conf_path = Path("~/wrk/alt/creds/").expanduser() / dj_conf_path

    try:
        dj.config.load(dj_conf_path)
        dj.conn()
        DATABASE += " "
        CONNECTED = True
    except:  # noqa E722
        print("Failed to connect to  : ", DATABASE)
        DATABASE = ""

if CONNECTED and DATABASE[:4].lower() not in ["prod", "prob", ""]:
    try:
        from datajoint_utilities.dj_search.lists import drop_schemas

        def drop_all_schemas(prefix="", dry_run=True, force_drop=True):
            drop_schemas(prefix, dry_run=dry_run, force_drop=force_drop)

    except ImportError:
        pass


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
