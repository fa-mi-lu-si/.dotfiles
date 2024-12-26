from datetime import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.rgb import to_color
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)

opts = get_options()

CHARGING_ICON = " 󰚥 "
UNPLUGGED_ICONS = {
    10: " 󰂃 ",
    20: " 󰁻 ",
    30: " 󰁼 ",
    40: " 󰁽 ",
    50: " 󰁾 ",
    60: " 󰁿 ",
    70: " 󰂀 ",
    80: " 󰂁 ",
    90: " 󰂂 ",
    100: " 󱟢 ",
}

# icons for common activities
TERMINAL_ICON = "  "
YAZI_ICON = "  "
TEXT_ICON = " 󰦨 "
REFRESH_TIME = 1

def _get_active_process_name_cell() -> dict:
    cell = {"icon": TERMINAL_ICON, "icon_bg_color": opts.color4, "text": ""}
    boss = get_boss()

    # Error 1: No boss instance found.
    if not boss:
        cell["text"] = "Err 1"
        return cell

    active_window = boss.active_window
    # Error 2: No active window found
    if not active_window:
        cell["text"] = "Err 2"
        return cell
    # Error 3: No process is associated with the active window.
    if not active_window.child:
        cell["text"] = "Err 3"
        return cell

    foreground_processes = active_window.child.foreground_processes
    # Error 4: No foreground process found.
    if not foreground_processes or not foreground_processes[0]["cmdline"]:
        cell["text"] = "..."
        return cell
    long_process_name = foreground_processes[0]["cmdline"][0]
    cell["text"] = long_process_name.rsplit("/", 1)[-1]

    if cell["text"] == "yazi":
        cell["icon"] = YAZI_ICON
    elif cell["text"] == "hx":
        cell["icon"] = TEXT_ICON

    return cell


def _get_battery_cell() -> dict:
    cell = {"icon": "", "icon_bg_color": opts.color7, "text": ""}

    try:
        with open("/sys/class/power_supply/BAT1/status", "r") as f:
            status = f.read()
        with open("/sys/class/power_supply/BAT1/capacity", "r") as f:
            percent = int(f.read())

        if status == "Charging\n":
            cell["icon"] = CHARGING_ICON
        else:
            cell["icon"] = UNPLUGGED_ICONS[
                min(UNPLUGGED_ICONS.keys(), key=lambda x: abs(percent - x))
            ]
        cell["text"] = str(percent) + "%"

    except FileNotFoundError:
        cell["text"] = "Err"

    return cell


def _create_cells() -> list[dict]:
    return [_get_battery_cell(), _get_active_process_name_cell()]


def _draw_right_status(screen: Screen, is_last: bool, draw_data: DrawData) -> int:
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)

    cells = _create_cells()
    right_status_length = 0
    for c in cells:
        right_status_length += 3 + len(c["icon"]) + len(c["text"])

    screen.cursor.x = screen.columns - right_status_length

    default_bg = as_rgb(int(draw_data.default_bg))
    tab_fg = as_rgb(int(draw_data.inactive_fg))

    screen.cursor.bg = default_bg
    for c in cells:
        icon_bg_color = as_rgb(color_as_int(c["icon_bg_color"]))
        screen.cursor.fg = icon_bg_color

        screen.cursor.bg = icon_bg_color
        screen.cursor.fg = 1
        screen.draw(c["icon"])

        screen.cursor.bg = as_rgb(color_as_int(opts.tab_bar_background))
        screen.cursor.fg = tab_fg
        screen.draw(f" {c['text']} ")

    return screen.cursor.x


def _redraw_tab_bar(_) -> None:
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


timer_id = None


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    _draw_right_status(screen, is_last, draw_data)
    return screen.cursor.x
