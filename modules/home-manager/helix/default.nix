{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./languages.nix
    ./keymap.nix
  ];
  programs.helix = {
    enable = true;
    package = inputs.helix.packages."${pkgs.system}".default;
    defaultEditor = true;
    settings = {
      editor = {
        line-number = "relative";
        indent-guides.render = false;
        mouse = true;
        bufferline = "multiple";
        color-modes = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "workspace-diagnostics"
            "selections"
            "register"
            "file-encoding"
          ];
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "disable";
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
