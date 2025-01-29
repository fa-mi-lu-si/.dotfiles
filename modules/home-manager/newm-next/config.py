from __future__ import annotations
from typing import Callable, Any

import os
import pwd
import time
import logging

from newm.layout import Layout
from newm.helper import BacklightManager, WobRunner, PaCtl

from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)

anim_time = .2
logger = logging.getLogger(__name__)

pywm = {
    'xcursor_theme': 'Bibata-Modern-Ice',
    'xcursor_size': 16,
    'enable_xwayland': True,
    'natural_scroll': True,
    'encourage_csd': False
}

background = {
    'path': os.path.expanduser("~/.config/background"),
    'anim': True
}

outputs = [
    { 'name': 'eDP-1' },
    { 'name': 'virt-1', 'pos_x': -1280, 'pos_y': 0, 'width': 1280, 'height': 720 }
]

wob_runner = WobRunner("wob -a bottom -M 100")
backlight_manager = BacklightManager(anim_time=1., bar_display=wob_runner)

def on_startup():
    os.system("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots")

def synchronous_update() -> None:
    backlight_manager.update()

def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    return [
        ("L-Left", lambda: layout.move(-1, 0)),
        ("L-Down", lambda: layout.move(0, 1)),
        ("L-Up", lambda: layout.move(0, -1)),
        ("L-Right", lambda: layout.move(1, 0)),
        ("L-equals", lambda: layout.basic_scale(1)),
        ("L-minus", lambda: layout.basic_scale(-1)),
        ("L-semicolon", lambda: layout.move_in_stack(1)),

        ("L-S-Left", lambda: layout.move_focused_view(-1, 0)),
        ("L-S-Down", lambda: layout.move_focused_view(0, 1)),
        ("L-S-Up", lambda: layout.move_focused_view(0, -1)),
        ("L-S-Right", lambda: layout.move_focused_view(1, 0)),

        ("L-A-Left", lambda: layout.resize_focused_view(-1, 0)),
        ("L-A-Down", lambda: layout.resize_focused_view(0, 1)),
        ("L-A-Up", lambda: layout.resize_focused_view(0, -1)),
        ("L-A-Right", lambda: layout.resize_focused_view(1, 0)),

        ("L-t", lambda: os.system("kitty &")),
        ("L-b", lambda: os.system("zen &")),
        ("L-space", lambda: os.system("fuzzel &")),
        ("L-q", lambda: layout.close_focused_view()),
        ("L-A-q", lambda: layout.terminate()),

        # ("L-p", lambda: layout.ensure_locked(dim=True)),
        ("L-C", lambda: layout.update_config()),

        ("L-u", lambda: layout.toggle_fullscreen()),

        ("L-", lambda: layout.toggle_overview()),

        ("XF86AudioPlay", lambda: os.system("playerctl play-pause &")),
        ("XF86AudioPause", lambda: os.system("playerctl play-pause &")),
        ("XF86AudioNext", lambda: os.system("playerctl next &")),
        ("XF86MonBrightnessUp", lambda: backlight_manager.set(backlight_manager.get() + 0.1)),
        ("XF86MonBrightnessDown", lambda: backlight_manager.set(backlight_manager.get() - 0.1)),
    ]

energy = {
    'idle_callback': backlight_manager.callback
}

gestures = {
    'c': {
        'enabled': True
    },
    'pyevdev': {
        'enabled': True # TODO: switch to pyevdev gestures
    }
}

gesture_bindings = {
    'launcher' : ("L", "swipe-3"),
    'move_resize': ("L", "move-1", "swipe-2")
}

panels = {
    'lock': {
        'cmd': 'kitty newm-panel-basic lock',
        'w': 0.7,
        'h': 0.6,
        'corner_radius': 50,
    },
    'launcher': {
        'cmd': 'kitty newm-panel-basic launcher',
        'w': 0.7,
        'h': 0.6,
        'corner_radius': 50,
    },
    # 'bar': {
    #     'cmd': 'eww open sidebar'
    # },
}
