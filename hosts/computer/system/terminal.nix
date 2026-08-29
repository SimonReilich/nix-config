{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ghostty
    nautilus-python 
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "com.mitchellh.ghostty.desktop" ];
    };
  };
}
