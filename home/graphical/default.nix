{ inputs, pkgs, ... }:

{
  imports = [
    ./email.nix
    ./obsidian.nix
    ./vscodium.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    # Editors and Viewers
    apostrophe
    onlyoffice-desktopeditors
    switcheroo
    video-trimmer
    rnote
    inputs.nix-cavalry.packages.x86_64-linux.default

    # Info & Entertainment
    spotify
    wike
    zotero
    nucleus

    # Communication
    discord
    signal-desktop
    zulip
    fractal

    # Creative
    blender
    blockbench
    design
    libresprite

    # Development
    godot
    inputs.automata-suite.packages.x86_64-linux.default

    # Gaming
    cartridges
    inputs.pandora-nix.packages.x86_64-linux.default

    # Utility
    binary
    eyedropper
    gnome-decoder
    gnome-graphs
    gnome-solanum
    hieroglyphic
    delineate
    eloquent
    gnome-network-displays
    morphosis
    emblem
    icon-library

    # Customization
    gnome-control-center
    gnome-tweaks

    # Passwords
    proton-pass
    proton-authenticator
  ];
}
