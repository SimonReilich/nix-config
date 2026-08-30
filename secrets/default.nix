{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkOption
    types
    ;

  cfg = config.secrets;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.secrets.keyFile = mkOption {
    type = types.bool;
    default = false;
    description = "Whether to use an age key file";
  };

  config = {
    sops.defaultSopsFile = ./secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age = mkIf cfg.keyFile {
      keyFile = "/root/.config/sops/age/keys.txt";
    };
  };
}
