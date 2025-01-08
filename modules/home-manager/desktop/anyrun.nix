{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.3;};
      width = {fraction = 0.3;};
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "top";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;
      plugins = let
        anyrun_pkgs = inputs.anyrun.packages.${pkgs.system};
      in [
        anyrun_pkgs.applications
        anyrun_pkgs.rink
        anyrun_pkgs.websearch
        # anyrun_pkgs.symbols
        anyrun_pkgs.shell
      ];
    };
  };
}
