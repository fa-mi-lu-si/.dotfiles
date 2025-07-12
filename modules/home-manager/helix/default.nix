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
        bufferline = "multiple";

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
