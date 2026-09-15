{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../nixos
    ../../secrets
    ./hardware.nix
  ];

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  hardware.graphics.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

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

  programs.cooling.enable = true;

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
