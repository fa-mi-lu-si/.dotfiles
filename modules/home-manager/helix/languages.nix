{
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

      {
        name = "markdown";
        auto-format = true;
        formatter = {
          command = "dprint";
          args = ["fmt" "--stdin" "md"];
        };
      }
    ];

    language-server = {
      nixd = {
        command = lib.getExe pkgs.nixd;
        config.nixd = rec {
          formatting.command = ["${lib.getExe pkgs.alejandra}"];
          options.nixos.expr = "(builtins.getFlake \"/home/samy/.dotfiles\").nixosConfigurations.samy-nixos.options";
          options.home-manager.expr = options.nixos.expr + ".home-manager.users.type.getSubOptions []";
        };
      };
    };
  };

  # project specific language servers should be in devshells
  programs.helix.extraPackages = with pkgs; [
    markdown-oxide
    dprint
    dprint-plugins.dprint-plugin-markdown
  ];
}
