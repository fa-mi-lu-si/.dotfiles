{...}: {
  programs.helix.settings.editor.jump-label-alphabet = "tnseriaodhfuwy";
  programs.helix.settings.keys = {
    normal = {
      esc = ["collapse_selection" "keep_primary_selection"];
      A-r = ":reload";
      A-W = "@miW";
      A-w = "@miw";
      C-e = "command_palette";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-after";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
      space.A-g = ":sh git -C $(dirname $(realpath %{buffer_name})) blame -L %{cursor_line},%{cursor_line} $(realpath %{buffer_name})";
      space.space = "goto_word";
      space.q = ":quit";
      space.w.d = [":vsplit" "goto_definition"];
    };

    insert = {
      A-r = ":reload";
      C-e = "command_palette";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-after";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
    };

    select = {
      A-r = ":reload";
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
