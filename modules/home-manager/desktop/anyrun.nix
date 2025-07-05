{
  inputs,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    config = {
      closeOnClick = true;
      hidePluginInfo = true;
      x.fraction = 0.5;
      y.fraction = 0.5;
      width.fraction = 0.3;
      height.fraction = 0.3;
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        shell
        websearch
        stdin
        rink
      ];
    };
    extraConfigFiles = {
      "applications.ron".text =
        # ron
        ''
          Config(
            desktop_actions: false,
            max_entries: 5,
            terminal: Some(Terminal(
              command: "ghostty",
              args: "-e {}",
            )),
          )
        '';
      "websearch.ron".text =
        # ron
        ''
          Config(
            prefix: "?",
            engines: [DuckDuckGo]
          )
        '';
    };
  };
}
