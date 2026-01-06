{pkgs, ...}: {
  home.packages = with pkgs; [
    scrcpy
  ];

  xdg.desktopEntries = {
    scrcpy = {
      name = "scrcpy";
      genericName = "Android Remote Control";
      comment = "Display and control your Android device";
      exec = "scrcpy --render-driver=opengl --keyboard=uhid --no-audio";
      icon = "scrcpy";
      terminal = false;
      type = "Application";
      startupNotify = false;
      categories = ["Utility" "RemoteAccess" "Network"];

      actions = {
        "with-audio" = {
          exec = "scrcpy --render-driver=opengl --keyboard=uhid";
          name = "With audio";
        };
      };
    };
  };
}
