{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.services.forgejo-runner;
in
{
  options.services.forgejo-runner = {
    enable = mkEnableOption "Forgejo runner configuration";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      sops.secrets.forgejo-runner-token = { };

      virtualisation.docker.enable = true;

      services.forgejo-runner = {
        package = pkgs.forgejo-runner;
        instances.default = {
          enable = true;
          url = "https://codeberg.org/";
          settings.server.connections.default.uuid = "a3cde578-1ed6-494c-bab5-b823ffe86e16";
          # Obtaining the path to the runner token file may differ
          # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
          secrets.server.connections.default.token_url = config.sops.secrets.forgejo-runner-token.path;
          labels = [
            "nix-stable:docker://nixos/nix:latest"
            "nix-unstable:docker://nixos/nix:unstable"
          ];
        };
      };
    }
  ]);
}
