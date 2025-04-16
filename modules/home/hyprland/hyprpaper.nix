{ ... }:
{
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "/etc/nixos/modules/home/hyprland/assets/bg.png" ];
    wallpaper = [ ",/etc/nixos/modules/home/hyprland/assets/bg.png" ];
  };
}
