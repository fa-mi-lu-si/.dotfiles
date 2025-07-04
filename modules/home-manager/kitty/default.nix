{...}: {
  programs.kitty = {
    enable = true;
    settings = {
      shell = "nu";
      # shell_integration = "enabled";
      editor = "hx";
      clipboard_control = "read-clipboard read-primary write-clipboard write-primary";

      active_tab_font_style = "bold";
      tab_bar_edge = "top";
      tab_bar_style = "custom";
      tab_powerline_style = "slanted";
      tab_bar_margin_width = 0.0;
      tab_bar_margin_height = "0.0 0.0";
      tab_bar_min_tabs = 2;
      tab_title_template = " {tab.active_oldest_exe}{bell_symbol}{activity_symbol} {f' {num_windows}' if num_windows > 1 else ''} ";
      active_tab_title_template = " {f' ' if (layout_name == 'stack' and num_windows > 1) else ''}{title}{bell_symbol}{activity_symbol} ";
      window_padding_width = "5 10";
      remember_window_size = false;
      hide_window_decorations = true;

      enabled_layouts = "splits:split_axis=auto, tall, fat, grid, horizontal, vertical, stack";

      cursor_trail = 5;
      cursor_shape = "beam";
      cursor_stop_blinking_after = 15.0;

      # colemak dh
      visual_window_select_characters = "tnseriaoq;wyfupl";

      clear_all_shortcuts = true;
    };
    keybindings = {
      "ctrl+shift+t" = "launch --type=tab";
      "ctrl+super+t" = "launch --type=os-window --cwd=current";
      "ctrl+shift+n" = "launch --cwd=current";
      "ctrl+shift+w" = "close_tab";
      "ctrl+super+w" = "close_window_with_confirmation ignore-shell";
      "ctrl+shift+f5" = "load_config_file";
      "ctrl+shift+u" = "kitten unicode_input";
      "ctrl+shift+f1" = "show_kitty_doc overview";
      "ctrl+super+shift+tab" = "swap_with_window";
      "ctrl+super+tab" = "focus_visible_window";

      "ctrl+shift+l" = "next_layout";
      "ctrl+shift+f11" = "toggle_fullscreen";
      "ctrl+super+u" = "toggle_layout stack";

      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      "ctrl+up" = "scroll_to_prompt -1";
      "ctrl+down" = "scroll_to_prompt 1";
      "ctrl+shift+o" = "show_last_visited_command_output";

      "ctrl+super+left" = "neighboring_window left";
      "ctrl+super+right" = "neighboring_window right";
      "ctrl+super+up" = "neighboring_window up";
      "ctrl+super+down" = "neighboring_window down";

      "ctrl+shift+pgdn" = "next_tab";
      "ctrl+shift+pgup" = "previous_tab";
      "ctrl+super+pgdn" = "next_tab";
      "ctrl+super+pgup" = "previous_tab";
      "ctrl+super+shift+pgdn" = "move_tab_forward";
      "ctrl+super+shift+pgup" = "move_tab_backward";

      "ctrl+shift+equal" = "change_font_size all +2.0";
      "ctrl+shift+plus" = "change_font_size all +2.0";
      "ctrl+shift+minus" = "change_font_size all -2.0";
      "ctrl+shift+0" = "change_font_size all 0";
      "ctrl+)" = "change_font_size all 0";
    };

    extraConfig = ''
      map --new-mode resize ctrl+shift+r

      map --mode resize up kitten relative_resize.py up
      map --mode resize left kitten relative_resize.py left
      map --mode resize right kitten relative_resize.py right
      map --mode resize down kitten relative_resize.py down

      map --mode resize esc pop_keyboard_mode
    '';
  };
  stylix.targets.kitty.variant256Colors = true;

  xdg.configFile."kitty/relative_resize.py".source = ./relative_resize.py;
  xdg.configFile."kitty/tab_bar.py".source = ./tab_bar.py;
  xdg.configFile."kitty/open-actions.conf".text = ''
    protocol file
    mime inode/directory
    action send_text all cd "$FILE_PATH"\r

    protocol file
    mime video/*
    action launch mpv --vo=kitty --profile=sw-fast $FILE_PATH

    protocol file
    mime audio/*
    action launch mpv --vo=kitty --profile=sw-fast $FILE_PATH

    protocol file
    mime image/*
    action launch --type=overlay kitten icat --hold -- $FILE_PATH

    protocol file
    mime text/html
    action launch --type=background xdg-open $FILE_PATH

    protocol file
    mime text/*
    action launch $EDITOR $FILE_PATH

    # Some extra which kitty couldnt figure out
    protocol file
    ext nix, nu
    action launch $EDITOR $FILE_PATH
  '';
}
