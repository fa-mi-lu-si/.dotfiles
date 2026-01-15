{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.niri-screen-time.packages."${pkgs.system}".default
  ];
  xdg.configFile."niri-screen-time/subprograms.yaml".text =
    #yaml
    ''
      - app_ids:
          - com.mitchellh.ghostty
        title_list:
          - "~/.dotfiles"
        alias: "edit dotfiles"
      - app_ids:
          - librewolf
          - zen-beta
        title_list:
          - "YouTube"
        alias: "YouTube"
    '';
}
