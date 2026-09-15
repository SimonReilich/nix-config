{
  config,
  pkgs,
  lib,
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
in
{
  config = mkIf (!config.system.headless) (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        ghostty
        nautilus-python
      ];

      xdg.terminal-exec = {
        enable = true;
        settings = {
          default = [ "com.mitchellh.ghostty.desktop" ];
        };
      };
    }
  ]);
}
