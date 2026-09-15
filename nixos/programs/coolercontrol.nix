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

  cfg = config.programs.cooling;
in
{
  options.programs.cooling = {
    enable = mkEnableOption "Coolercontrol configuration";
  };

  config = mkIf (!config.system.headless && cfg.enable) (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        coolercontrol.coolercontrold
        coolercontrol.coolercontrol-gui
      ];

      programs.coolercontrol.enable = true;
    }
  ]);
}
