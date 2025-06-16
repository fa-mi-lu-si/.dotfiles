{...}: {
  services.swww = {
    enable = true;
  };

  home.sessionVariables = {
    SWWW_TRANSITION = "left";
    SWWW_TRANSITION_DURATION = "1";
  };

  xdg.desktopEntries."swww" = {
    name = "swww";
    exec = "swww img --transition-type left --transition-duration 1 %U";
    comment = "Set the wallpaper";
    mimeType = ["image/jpeg" "image/png" "image/gif" "image/webp"];
    noDisplay = true;
  };
}
