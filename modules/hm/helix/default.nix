{...}: {
  imports = [
    ./languages.nix
    ./keymap.nix
  ];
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        soft-wrap.wrap-indicator = "󰌑";
        scroll-lines = 1;

        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "disable";
        };

        cursor-shape = {
          normal = "bar";
          select = "bar";
          insert = "bar";
        };
      };
    };
  };
}
