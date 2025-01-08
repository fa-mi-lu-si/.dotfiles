{...}: {
  programs.helix.settings.keys = {
    normal = {
      C-e = "command_palette";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-before";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
      space.space = "file_picker";
      space.q = ":quit";
      space.w.d = [":vsplit" "goto_definition"];
      g.o = "symbol_picker";
    };

    insert = {
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-before";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
    };

    select = {
      C-e = "command_palette";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-before";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
      space.space = "file_picker";
      space.q = ":quit";
      space.w.d = [":vsplit" "goto_definition"];
      g.o = "symbol_picker";
    };
  };
}
