{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.helix.languages = {
    grammar = [
    ];

    language = [
      {
        name = "nix";
        language-servers = [
          "nixd"
        ];
        scope = "source.nix";
        injection-regex = "nix";
        auto-format = true;
        file-types = ["nix"];
        comment-token = "#";
      }
    ];

    language-server = {
      nixd = {
        command = lib.getExe pkgs.nixd;
        config.nixd = {
          formatting.command = ["${lib.getExe pkgs.alejandra}"];
        };
      };
    };
  };

  # packages for default language servers
  programs.helix.extraPackages = with pkgs; [
    markdown-oxide
    lua-language-server
  ];
}
