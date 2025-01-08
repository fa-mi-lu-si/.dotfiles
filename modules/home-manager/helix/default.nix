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
        indent-guides.render = false;
        mouse = true;
        bufferline = "multiple";

        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "error";
        };

        cursor-shape = {
          insert = "bar";
          normal = "bar";
          select = "bar";
        };
      };
    };
  };
}
