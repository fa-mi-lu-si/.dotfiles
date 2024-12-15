{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.helix.settings.keys = {
    # TODO: share some bindings between modes to avoid repetitions
    normal = {
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-replace";
      C-pageup = ":buffer-next";
      C-pagedown = ":buffer-previous";
      space.space = "file_picker";
      space.q = ":quit";
      g.o = "symbol_picker";
    };

    insert = {
      C-s = ":write";
      C-t = ":new";
      C-w = ":buffer-close";
      C-c = ":clipboard-yank";
      C-v = ":clipboard-paste-replace";
      C-pageup = ":buffer-next";
      C-pagedown = ":buffer-previous";
    };
  };
}
