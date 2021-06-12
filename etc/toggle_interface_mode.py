import subprocess
from datetime import datetime


OSASCRIPT = """
    tell application "System Events"
        tell appearance preferences
            set dark mode to {mode}
        end tell
    end tell

    tell application "Terminal"
        set default settings to settings set "{theme}"
    end tell

    tell application "Terminal"
        set current settings of tabs of windows to settings set "{theme}"
    end tell
"""

TERMINAL_THEMES = {
    "Light": "Yorha",
    "Dark": "Dracula"
}

IS_DARK_MODE = {
    "Dark": "true",
    "Light": "false"
}

TIME_FORMAT = "%H:%M"

TOGGLE_TIME = datetime.strptime("20:00",
                                TIME_FORMAT)


def mode() -> str:
    """ get current time """
    time_query = subprocess.run(
        ["date", "+%H:%M"],
        text = True,
        capture_output = True)

    if time_query.returncode != 0:
        raise OSError('Could not get time.')
    else:
        time = time_query.stdout.strip()

    """ determine mode """
    if datetime.strptime(time, TIME_FORMAT) > TOGGLE_TIME:
       return "Dark"
    else:
       return "Light"

def set_interface_style(mode: str):
    # Enable/disable dark mode.
    script = OSASCRIPT.format(
       mode = IS_DARK_MODE[mode],
       theme = TERMINAL_THEMES[mode])
    print(script)

    #result = subprocess.run(
    #    ['osascript', '-e', script],
    #    text = True,
    #    capture_output = True)

    #assert result.returncode == 0, result
    print("ok")


if __name__ == "__main__":
    set_interface_style(mode())
