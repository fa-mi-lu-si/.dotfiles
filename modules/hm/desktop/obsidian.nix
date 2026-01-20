{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    obsidian
  ];

  home.file."Vault/.obsidian/plugins/obsidian-style-settings/data.json".text = with config.lib.stylix.colors.withHashtag; ''
    {
      "minimal-style@@base@@dark": "${base00}",
      "minimal-style@@bg1@@light": "${base00}",
      "minimal-style@@ax1@@dark": "${base0D}",
      "minimal-style@@ax2@@dark": "${base0D}",
      "minimal-style@@tx1@@dark": "${base05}",
      "minimal-style@@tx2@@dark": "${base04}",
      "minimal-style@@tx3@@dark": "${base04}",
      "minimal-style@@graph-line@@dark": "${base03}",
      "minimal-style@@graph-node@@dark": "${base04}",
      "minimal-style@@ui1@@dark": "${base00}",

      "minimal-style@@color-green@@dark": "${base0B}",
      "minimal-style@@color-yellow@@dark": "${base0A}",
      "minimal-style@@color-purple@@dark": "${base0E}",
      "minimal-style@@color-blue@@dark": "${base0D}",
      "minimal-style@@color-cyan@@dark": "${base0C}",
      "minimal-style@@color-orange@@dark": "${base09}",

      "minimal-advanced@@styled-scrollbars": true,
      "minimal-advanced@@cursor": "default"
    }
  '';
}
