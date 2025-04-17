{ ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ (builtins.toString ./assets/bg.png) ];
    wallpaper = [ ",${builtins.toString ./assets/bg.png}" ];
  };
}
