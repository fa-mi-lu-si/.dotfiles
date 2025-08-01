{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    obsidian
  ];

  # Stylix theming for obsidian, just copy the file into Style Settings
  home.file."Vault/.obsidian/plugins/obsidian-style-settings/data.json".text = with config.lib.stylix.colors.withHashtag; ''
    {
      "minimal-style@@base@@dark": "${base00}",
      "minimal-style@@ax1@@dark": "${base0D}",
      "minimal-advanced@@styled-scrollbars": true,
      "minimal-advanced@@cursor": "default"
    }
  '';
}
