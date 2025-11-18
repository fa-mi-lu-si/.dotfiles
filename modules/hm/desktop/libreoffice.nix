{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-fresh
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.en-gb-large
  ];
}
