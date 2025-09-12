{pkgs, ...}: {
  xdg.enable = true;

  xdg.mime.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web
      "text/html" = ["librewolf.desktop"];
      "x-scheme-handler/http" = ["librewolf.desktop"];
      "x-scheme-handler/https" = ["librewolf.desktop"];

      # terminal
      "x-scheme-handler/terminal" = ["org.wezfurlong.wezterm.desktop"];

      # System
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "inode/mount-point" = ["org.gnome.Nautilus.desktop"];

      # Text
      "text/markdown" = ["Helix.desktop"];
      "text/plain" = ["Helix.desktop"];

      # Documents
      "application/pdf" = ["org.pwmt.zathura.desktop"];

      # Media
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "video/mpeg" = ["io.github.celluloid_player.Celluloid.desktop"];
      "video/mp4" = ["io.github.celluloid_player.Celluloid.desktop"];
      "audio/mp4" = ["io.bassi.Amberol.desktop"];
      "audio/mpeg" = ["io.bassi.Amberol.desktop"];
      "audio/ogg" = ["io.bassi.Amberol.desktop"];
      "audio/aac" = ["io.bassi.Amberol.desktop"];
      "audio/mp3" = ["io.bassi.Amberol.desktop"];
      "audio/x-mp3" = ["io.bassi.Amberol.desktop"];
    };
  };
}
