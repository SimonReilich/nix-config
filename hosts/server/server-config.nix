{ pkgs, modulesPath, ... }:
{
  imports = [
    ./system
    ../../nixos
    ../../secrets

    ./server-hardware.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  secrets.keyFile = true;

  # SSH
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF5CsQlVSAIkJbk+8jj0sppxijKw02U7K21eVTNv36D7 simon.reilich137@gmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/9Vh3mp1SoF9xzbR8BrLaSZEjx26envKfvbLYU/OO9 simon.reilich137@gmail.com"
  ];
}
