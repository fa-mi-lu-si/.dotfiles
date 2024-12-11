{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      shell = "nu";
      # shell_integration = "enabled";
      editor = "micro";
      clipboard_control = "read-clipboard read-primary write-clipboard write-primary";

      active_tab_font_style = "bold";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      window_padding_width = "5 10";
      draw_minimal_borders = false;

      cursor_shape = "beam";
      cursor_stop_blinking_after = 15.0;
      touch_scroll_multiplier = 2;

      # colemak dh
      visual_window_select_characters = "tnseriaoq;wyfupl";

      clear_all_shortcuts = true;
    };
    keybindings = {
      "ctrl+shift+t" = "launch --type=tab";
      "ctrl+shift+n" = "launch --cwd=current";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+r" = "start_resizing_window";
      "ctrl+shift+f5" = "load_config_file";

      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      "ctrl+shift+alt+up" = "scroll_to_prompt -1";
      "ctrl+shift+alt+down" = "scroll_to_prompt 1";

      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+pgdn" = "next_tab";
      "ctrl+shift+pgup" = "previous_tab";
      "ctrl+shift+right" = "no_op";
      "ctrl+shift+left" = "no_op";

      "ctrl+shift+f11" = "toggle_fullscreen";
      "ctrl+super+u" = "toggle_layout stack";

      "ctrl+super+left" = "neighboring_window left";
      "ctrl+super+right" = "neighboring_window right";
      "ctrl+super+up" = "neighboring_window up";
      "ctrl+super+down" = "neighboring_window down";

      "ctrl+super+shift+left" = "move_window left";
      "ctrl+super+shift+right" = "move_window right";
      "ctrl+super+shift+up" = "move_window up";
      "ctrl+super+shift+down" = "move_window down";

      "ctrl+super+pgdn" = "next_tab";
      "ctrl+super+pgup" = "previous_tab";
      "ctrl+super+shift+pgdn" = "move_tab_forward";
      "ctrl+super+shift+pgup" = "move_tab_backward";

      "ctrl+shift+equal" = "change_font_size all +2.0";
      "ctrl+shift+plus" = "change_font_size all +2.0";
      "ctrl+shift+minus" = "change_font_size all -2.0";
      "ctrl+shift+0" = "change_font_size all 0";
      "ctrl+)" = "change_font_size all 0";

      "ctrl+shift+u" = "kitten unicode_input";
      "ctrl+super+shift+tab" = "swap_with_window";
      "ctrl+super+tab" = "focus_visible_window";
    };
  };
}
