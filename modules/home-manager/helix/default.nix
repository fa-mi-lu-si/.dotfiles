{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      editor = {
        line-number = "relative";
        indent-guides.render = false;
        mouse = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        whitespace.characters = {
          newline = "↴";
          tab = "⇥";
        };
      };
    };
    extraPackages = with pkgs; [
      markdown-oxide
    ];
  };
}
