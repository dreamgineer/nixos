{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;
  programs.xwayland.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "sddm-astronaut-theme";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.compositor = "kwin";
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "dgnr";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.plasma6.excludePackages = with pkgs; [ kdePackages.krdp ];

  # Hyprland
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    hyprshot
    nerd-fonts.code-new-roman
    gnome-keyring
    pavucontrol
    brightnessctl
  ];
}
