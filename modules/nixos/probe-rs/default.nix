{pkgs, ...}: {
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "probe-rs udev";
      text = builtins.readFile ./69-probe-rs.rules;
      destination = "/lib/udev/rules.d/69-probe-rs.rules";
    })
  ];
}
