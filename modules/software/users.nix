{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dgnr = {
    isNormalUser = true;
    description = "Dreamgineer";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kdeconnect-kde
      gearlever
      appimage-run
      google-chrome
      git
      vesktop
      fastfetch
      nixd
      nixfmt-rfc-style
      element-desktop
      blackbox-terminal
      micro
      gh
      spotube
      inshellisense

      godns
      #  thunderbird
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "dgnr";
}
