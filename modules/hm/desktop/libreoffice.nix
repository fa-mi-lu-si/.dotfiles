{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-stable
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.en-gb-large
  ];
}
