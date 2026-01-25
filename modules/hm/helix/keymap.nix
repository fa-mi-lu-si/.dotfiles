{...}: {
  programs.helix.settings.editor.jump-label-alphabet = "setnriaodh";
  programs.helix.settings.keys = {
    normal = {
      esc = ["collapse_selection" "keep_primary_selection"];
      ret = "goto_word";
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
      space.q = ":quit";
      space.w.d = [":vsplit" "goto_definition"];
      space.e = [
        ":sh rm -f /tmp/unique-file"
        ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
        '':insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty''
        ":open %sh{cat /tmp/unique-file}"
        ":redraw"
        ":set mouse false"
        ":set mouse true"
      ];
      X = ["extend_line_up" "extend_to_line_bounds"];
      A-r = ":reload";
    };

    insert = {
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-pageup = ":buffer-previous";
      C-pagedown = ":buffer-next";
    };
  };
}
