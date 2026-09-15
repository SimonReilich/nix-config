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
      stylix.enable = true;
      stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/google-dark.yaml";
      stylix.polarity = "dark";

      stylix.targets.qt.platform = lib.mkForce "qtct";

      stylix.image = ./wallpaper.png;

      stylix.fonts = {
        serif = {
          package = pkgs.lexend;
          name = "Lexend";
        };

        sansSerif = {
          package = pkgs.lexend;
          name = "Lexend";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    }
  ]);
}
