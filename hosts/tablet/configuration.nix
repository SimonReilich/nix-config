{ pkgs, hardware, lib, ... }:

{
  imports = [
    ../../nixos
    ../../secrets
    ./hardware.nix
  ];

  networking.hostName = "tablet";
  networking.networkmanager.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  hardware.microsoft-surface.kernelVersion = "stable";

  sops.age.keyFile = "~/.config/sops/age/keys.txt";

  users.users.simonr = {
    isNormalUser = true;
    home = "/home/simonr";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
    ];
    shell = pkgs.zsh;
  };

  programs.cooling.enable = false;

  system = {
    headless = false;
    gnome = true;
    has_touchscreen = true;
  };

  services = {
    forgejo-runner.enable = false;
    update.enable = false;
  };
}
