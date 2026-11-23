{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.niri-screen-time.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];
  # TODO: split up browser tasks
  # use sideberry to change window titles depending on active panel
  xdg.configFile."niri-screen-time/subprograms.yaml".text =
    #yaml
    ''
      - alias: "edit dotfiles"
        app_ids:
          - com.mitchellh.ghostty
        title_list:
          - "~/.dotfiles"
          - "~/.config"

      - alias: "YouTube"
        app_ids:
          - librewolf
          - zen-beta
        title_list:
          - "YouTube"

      - alias: "Instagram"
        app_ids:
          - librewolf
          - zen-beta
        title_list:
          - "Instagram"

      - alias: "Emails"
        app_ids:
          - librewolf
          - zen-beta
        title_list:
          - "Outlook"
          - "Gmail"
          - "Inbox"

      - alias: "Notes"
        app_ids:
          - md.obsidian.Obsidian
          - com.mitchellh.ghostty
        title_list:
          - "Obsidian"
          - "Vault"
    '';
}
