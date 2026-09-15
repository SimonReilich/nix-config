{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./user
    ../../home
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  terminal.helix = {
    enable = lib.mkDefault true;
    languages = {
      json = true;
      latex = true;
      markdown = true;
      nix = true;
      rust = true;
      toml = true;
      yaml = true;
    };
  };
}
