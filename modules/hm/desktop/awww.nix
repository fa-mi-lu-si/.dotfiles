{...}: {
  services.awww = {
    enable = true;
  };

  home.sessionVariables = {
    AWWW_TRANSITION = "left";
    AWWW_TRANSITION_DURATION = "1";
  };

  xdg.desktopEntries."awww" = {
    name = "awww";
    exec = "awww img --transition-type left --transition-duration 1 %U";
    comment = "Set the wallpaper";
    mimeType = ["image/jpeg" "image/png" "image/gif" "image/webp"];
    noDisplay = true;
  };
}
