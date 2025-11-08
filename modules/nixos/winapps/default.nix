{
  inputs,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages."${system}".winapps
    inputs.winapps.packages."${system}".winapps-launcher # optional
  ];
  environment.variables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}
