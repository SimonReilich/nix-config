{
  config,
  pkgs,
  lib,
  inputs,
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
          name = "Newsreader";
          package = pkgs.stdenvNoCC.mkDerivation {
            pname = "newsreader";
            version = "1.0";
            src = inputs.newsreader-font;

            installPhase = ''
              runHook preInstall
              install -Dm644 fonts/static/ttf/*.ttf -t $out/share/fonts/truetype/newsreader/
              install -Dm644 fonts/variable/ttf/*.ttf -t $out/share/fonts/truetype/newsreader/
              runHook postInstall
            '';
          };
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
