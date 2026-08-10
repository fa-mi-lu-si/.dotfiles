{pkgs, ...}: {
  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative # gives the qml language server
  ];
}
