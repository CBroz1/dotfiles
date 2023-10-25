import os
import sys

from IPython.terminal.prompts import Prompts, Token

CONDA = os.getenv("CONDA_DEFAULT_ENV", "")
DATABASE = ""

if len(sys.argv) > 1 and CONDA.lower() in ["spy", "src"]:
    import datajoint as dj

    DATABASE = sys.argv[1]
    print("Connecting to database: ", DATABASE)
    dj_conf_name = (
        f"dj_local_conf.json_{DATABASE}"
        if DATABASE.lower() not in [0, "none"]
        else "dj_local_conf.json"
    )
    try:
        dj.config.load(dj_conf_name)
        dj.conn()
        DATABASE += " "
    except:  # noqa E722
        print("Failed to connect to database: ", DATABASE)
        DATABASE = ""


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
