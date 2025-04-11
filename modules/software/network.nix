{
  networking.hostName = "nyx"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Networking
  services.tailscale.enable = true;
  # "100.100.100.100" "45.90.28.164" "45.90.30.164"
  networking.nameservers = [
    "8.8.8.8"
    "1.1.1.1"
  ];
  networking.search = [
    "tail71b97a.ts.net"
    "dgnr.us"
  ];
  networking.firewall.enable = false;

  hardware.bluetooth.enable = true;

  services.avahi = {
    nssmdns4 = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
