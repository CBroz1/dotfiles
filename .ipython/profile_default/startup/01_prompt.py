"""Custom IPython prompt showing vi mode and DataJoint connection status."""

from IPython.terminal.prompts import Prompts, Token


class MyPrompt(Prompts):
    def in_prompt_tokens(self):
        try:
            vi_raw = self.vi_mode().strip("[]")
            vi = f"{vi_raw[:1].upper()} " if vi_raw else ""
        except Exception:
            vi = ""

        db = self.shell.user_ns.get("DATABASE", "").upper()

        return [
            (Token.Name.Class, vi),  # purple — vi mode indicator
            (Token.OutPrompt, db),  # pink  — database prefix
            (Token.Prompt, "["),  # green
            (Token.PromptNum, str(self.shell.execution_count)),
            (Token.Prompt, "]: "),
        ]


ip = get_ipython()  # noqa: F821 — injected by IPython
ip.prompts = MyPrompt(ip)
