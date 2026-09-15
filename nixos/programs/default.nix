{ config, pkgs, ... }:

{
  imports = [
    ./coolercontrol.nix
    ./git.nix
    ./steam.nix
  ];
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fzf
    jless
    bat
    devenv
  ];
}
