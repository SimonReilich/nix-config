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
  config = mkIf (!config.system.headless && config.system.gnome) (mkMerge [
    {
      # Enable the X11 windowing system.
      services.xserver.enable = true;

      # Enable the GNOME Desktop Environment.
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      fonts.fontDir.enable = true;

      environment.systemPackages = with pkgs.gnomeExtensions; [
        appindicator
        blur-my-shell
        clipboard-history
        gsconnect
        quick-settings-audio-panel
        rounded-window-corners-reborn
        tiling-shell
      ];

      # Open ports in the firewall.
      networking.firewall = {
        enable = true;
        # TCP and UDP Ports for GSConnect
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];
      };

      # Disable preinstalled software
      environment.gnome.excludePackages = with pkgs; [
        epiphany
        simple-scan
        seahorse
        snapshot

        gnome-music
        gnome-maps
        gnome-tour
        gnome-weather
      ];
    }

    (mkIf (config.system.has_touchscreen && !config.system.headless) {
      services.desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.desktop.peripherals.touchpad]
        click-method='default'
      '';

      # Enable touchpad support (enabled default in most desktopManager).
      services.libinput.enable = true;

      environment.systemPackages = with pkgs.gnomeExtensions; [
        touchup
      ];
    })
  ]);
}
