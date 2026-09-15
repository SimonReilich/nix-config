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

  cfg = config.programs.coolercontrol;
in
{
  options.programs.coolercontrol = {
    enable = mkEnableOption "Coolercontrol configuration";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = with pkgs; [
        coolercontrol.coolercontrold
        coolercontrol.coolercontrol-gui
      ];

      programs.coolercontrol.enable = true;
    }
  ]);
}
