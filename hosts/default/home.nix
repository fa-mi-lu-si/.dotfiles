{
  # inputs,
  # config,
  # pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/cli
    ../../modules/home-manager/desktop
    ../../modules/home-manager/vscode
    ../../modules/home-manager/helix
    ../../modules/home-manager/kitty
    ../../modules/home-manager/ghostty
    ../../modules/home-manager/hyprland # newm or hyprland
    ../../modules/home-manager/eww
    ../../modules/home-manager/stylix.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "samy";
  home.homeDirectory = "/home/samy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # TODO: move this somewhere else, couple to its nixOS firewall
  services.kdeconnect = {
    enable = true;
    indicator = true; # enable the indicator service
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # home.packages = with pkgs; [];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/samy/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
