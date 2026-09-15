{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkOption
    types
    ;

  cfg = config.system;
in
{
  imports = [
    ./configuration
    ./programs
    ./services
  ];

  options.system = {
    headless = mkOption {
      type = types.bool;
      default = false;
      description = "Whether gui applications should be installed";
    };

    gnome = mkOption {
      type = types.bool;
      default = true;
      description = "Whether the gnome DE should be used";
    };

    has_touchscreen = mkOption {
      type = types.bool;
      default = true;
      description = "Whether touchscreen related packages should be installed";
    };
  };

  config = {
    nix.settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
