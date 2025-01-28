from __future__ import annotations
from typing import Callable, Any

import os
import pwd
import time
import logging

from newm.layout import Layout
from newm.helper import BacklightManager, WobRunner

from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)

logger = logging.getLogger(__name__)

background = {
    'path': os.path.expanduser("~/.config/background"),
    'anim': True
}

outputs = [
    { 'name': 'eDP-1' },
    # { 'name': 'virt-1', 'pos_x': -1280, 'pos_y': 0, 'width': 1280, 'height': 720 }
]

wob_runner = WobRunner("wob -a bottom -M 100")
backlight_manager = BacklightManager(anim_time=1., bar_display=wob_runner)
def synchronous_update() -> None:
    backlight_manager.update()

mod = PYWM_MOD_LOGO
def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    return [
        ("M-Left", lambda: layout.move(-1, 0)),
        ("M-Down", lambda: layout.move(0, 1)),
        ("M-Up", lambda: layout.move(0, -1)),
        ("M-Right", lambda: layout.move(1, 0)),
        ("M-equal", lambda: layout.basic_scale(1)),
        ("M-minus", lambda: layout.basic_scale(-1)),
        ("M-S-T", lambda: layout.move_in_stack(1)),

        ("M-S-Left", lambda: layout.move_focused_view(-1, 0)),
        ("M-S-Down", lambda: layout.move_focused_view(0, 1)),
        ("M-S-Up", lambda: layout.move_focused_view(0, -1)),
        ("M-S-Right", lambda: layout.move_focused_view(1, 0)),

        ("M-A-Left", lambda: layout.resize_focused_view(-1, 0)),
        ("M-A-Down", lambda: layout.resize_focused_view(0, 1)),
        ("M-A-Up", lambda: layout.resize_focused_view(0, -1)),
        ("M-A-Right", lambda: layout.resize_focused_view(1, 0)),

        ("M-t", lambda: os.system("kitty &")),
        ("M-b", lambda: os.system("zen &")),
        ("M-q", lambda: layout.close_focused_view()),

        ("M-p", lambda: layout.ensure_locked(dim=True)),
        ("M-P", lambda: layout.terminate()),
        ("M-C", lambda: layout.update_config()),

        ("M-u", lambda: layout.toggle_fullscreen()),

        ("M-", lambda: layout.toggle_overview()),

        ("XF86MonBrightnessUp", lambda: backlight_manager.set(backlight_manager.get() + 0.1)),
        ("XF86MonBrightnessDown", lambda: backlight_manager.set(backlight_manager.get() - 0.1)),
    ]

bar = {
    'enabled': False,
}

energy = {
    'idle_callback': backlight_manager.callback
}

pywm = {
    'enable_xwayland': True,
    'natural_scroll': True,
}
