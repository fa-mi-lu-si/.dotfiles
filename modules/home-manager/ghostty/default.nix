{...}: {
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    settings = {
      window-theme = "ghostty";
      command = "nu";
      gtk-tabs-location = "hidden";
      gtk-single-instance = true;
      window-padding-x = 18;
      window-padding-y = 18;
      keybind = [
        "ctrl+super+enter=toggle_split_zoom"
        "ctrl+super+f9=toggle_tab_overview"
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_tab"
        "ctrl+super+w=close_surface"

        "ctrl+shift+comma=reload_config"

        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"

        "ctrl+shift+page_down=jump_to_prompt:1"
        "ctrl+shift+page_up=jump_to_prompt:-1"

        "ctrl+super+page_down=next_tab"
        "ctrl+super+page_up=previous_tab"

        "ctrl+super+right=goto_split:right"
        "ctrl+super+left=goto_split:left"
        "ctrl+super+up=goto_split:up"
        "ctrl+super+down=goto_split:down"
        "ctrl+shift+super+right=new_split:right"
        "ctrl+shift+super+left=new_split:left"
        "ctrl+shift+super+up=new_split:up"
        "ctrl+shift+super+down=new_split:down"

        "ctrl+equal=increase_font_size:1"
        "ctrl+minus=decrease_font_size:1"
        "ctrl+zero=reset_font_size"
        "ctrl+plus=increase_font_size:1"
      ];
    };
  };
}
