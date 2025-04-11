{ pkgs, ... }: {
  boot = {
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = with pkgs; [
        # By default we would install all themes
        nixos-bgrt-plymouth
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=2"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Use XanMod kernel
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader = {
      systemd-boot.enable = true;
      timeout = 0;
    };
    kernel.sysctl = {
      "vm.swappiness" = 20;
    };
    initrd.systemd.enable = true;

    supportedFilesystems = [ "ntfs" ];
  };
}
