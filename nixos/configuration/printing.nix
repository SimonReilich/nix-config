{ config, pkgs, lib, ... }:

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
      # Enable CUPS to print documents.
      services.printing.enable = true;
    }
  ]);
}
