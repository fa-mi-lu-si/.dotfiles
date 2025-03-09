from __future__ import annotations
from typing import Callable, Any

import os
import pwd
import time
import logging
from subprocess import run

from newm.layout import Layout
from newm.helper import BacklightManager, WobRunner, PaCtl

from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)

anim_time = .2
logger = logging.getLogger(__name__)

pywm = {
    'enable_xwayland': True,
    'xcursor_theme': 'Bibata-Modern-Ice',
    'xcursor_size': 24,

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

backlight_manager = BacklightManager(anim_time=1.)

def on_startup():
    os.system("eww daemon")
    os.system("systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    os.system("hash dbus-update-activation-environment 2>/dev/null && \
        dbus-update-activation-environment --systemd DISPLAY \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

def on_reconfigure():
    os.system("notify-send newm \"Reloaded config\" &")

def synchronous_update() -> None:
    backlight_manager.update()

def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    return [
        ("L-Left", lambda: layout.move(-1, 0)),
        ("L-Down", lambda: layout.move(0, 1)),
        ("L-Up", lambda: layout.move(0, -1)),
        ("L-Right", lambda: layout.move(1, 0)),
        
        ("A-Tab", lambda: layout.move_in_stack(1)),
        
        ("L-minus", lambda: layout.basic_scale(1)),
        ("L-equal", lambda: layout.basic_scale(-1)),
        ("L-S-minus", lambda: layout.basic_scale(1)),
        ("L-S-equal", lambda: layout.basic_scale(-1)),

        ("L-S-Left", lambda: layout.move_focused_view(-1, 0)),
        ("L-S-Down", lambda: layout.move_focused_view(0, 1)),
        ("L-S-Up", lambda: layout.move_focused_view(0, -1)),
        ("L-S-Right", lambda: layout.move_focused_view(1, 0)),

        ("L-A-Left", lambda: layout.resize_focused_view(-1, 0)),
        ("L-A-Down", lambda: layout.resize_focused_view(0, 1)),
        ("L-A-Up", lambda: layout.resize_focused_view(0, -1)),
        ("L-A-Right", lambda: layout.resize_focused_view(1, 0)),

        ("L-S-t", lambda: os.system("kitty &")),
        ("L-t", lambda: os.system("wezterm &")),
        ("L-c", lambda: os.system("code &")),
        ("L-f", lambda: os.system("nautilus &")),
        ("L-b", lambda: os.system("zen &")),
        ("L-o", lambda: os.system("obsidian &")),
        ("L-S-o", lambda: os.system("wezterm start --cwd ~/Vault hx .")),
        ("L-space", lambda: os.system("fuzzel &")),

        ("L-q", lambda: layout.close_focused_view()),
        ("L-S-q", lambda: layout.terminate()),

        # ("L-p", lambda: layout.ensure_locked(dim=True)),
        ("L-C", lambda: layout.update_config()),

        ("L-u", lambda: layout.toggle_fullscreen()),
        ("L-g", lambda: layout.toggle_focused_view_floating()),

        ("L-", lambda: layout.toggle_overview()),

        ("XF86AudioRaiseVolume", lambda: os.system("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ &")),
        ("XF86AudioLowerVolume", lambda: os.system("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%- &")),
        ("XF86AudioMute", lambda: os.system("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle &")),
        ("XF86AudioPlay", lambda: os.system("playerctl play-pause &")),
        ("XF86AudioPause", lambda: os.system("playerctl play-pause &")),
        ("XF86AudioNext", lambda: os.system("playerctl next &")),
        ("XF86MonBrightnessUp", lambda: backlight_manager.set(backlight_manager.get() + 0.01)),
        ("XF86MonBrightnessDown", lambda: backlight_manager.set(backlight_manager.get() - 0.01)),
    ]

energy = {
    # 'idle_callback': backlight_manager.callback
    'idle_times': []
}

lock_on_wakeup = False

panels = {
    'launcher': {
        'cmd': "kitty"
    },
    # 'bar': {
    #     'cmd': 'eww open sidebar',
    #     'visible_normal': False
    # }
}

gestures = {
    'c': {
        'enabled': False
    },
    'pyevdev': {
        'enabled': True
    }
}
