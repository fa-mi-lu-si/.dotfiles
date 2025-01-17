{...}: {
  programs.helix.settings.keys = {
    normal = {
      C-e = "command_palette";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-after";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
      space.space = "goto_word";
      space.q = ":quit";
      space.w.d = [":vsplit" "goto_definition"];
    };

    insert = {
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-after";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
    };

    select = {
      C-e = "command_palette";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-after";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
      space.space = "goto_word";
      space.q = ":quit";
      space.w.d = [":vsplit" "goto_definition"];
    };
  };
}
