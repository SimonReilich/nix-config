{ inputs, pkgs, ... }:

{
  imports = [
    ./fastfetch.nix
    ./helix.nix
    ./prompt.nix
  ];

  home.packages = with pkgs; [
    # Development
    nixfmt
    nixfmt-tree
    inputs.popprotosim-neo.packages.x86_64-linux.default

    # Utility
    ffmpeg

    # Customization
    adw-gtk3
  ];
}
