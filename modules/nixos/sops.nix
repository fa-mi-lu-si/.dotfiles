{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/samy/.config/sops/age/keys.txt";
  sops.secrets.example_key = {};
  sops.secrets.human_rights = {
    owner = config.users.users.samy.name;
  };
}
