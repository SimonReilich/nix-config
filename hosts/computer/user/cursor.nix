{ pkgs, ... }:

{
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 25;
  };

  home.pointerCursor.enable = true;
}
