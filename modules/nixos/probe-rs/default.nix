{pkgs, ...}: {
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "probe-rs udev";
      text = builtins.readFile ./69-probe-rs.rules;
    })
  ];
}
