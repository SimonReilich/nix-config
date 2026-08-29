{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../computer/home.nix
    ./user
    ../../home
  ];

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
