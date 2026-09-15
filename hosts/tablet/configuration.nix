{ pkgs, hardware, lib, ... }:

{
  imports = [
    ./system
    ../computer/config.nix
    ../../nixos
    ../../secrets
    ./hardware.nix
  ];

  networking.hostName = "tablet";

  boot.kernelPatches = [
    # {
    #   name = "rust-1.91-fix";
    #   patch = ./patches/rust-fix.patch;
    # }
  ];

  environment.systemPackages = with pkgs; [
    sbctl
    libwacom-surface
    linux-firmware
    mkcert
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  stylix.image = ./wallpaper.png;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  hardware.microsoft-surface.kernelVersion = "stable";

  programs.coolercontrol.enable = false;
}
