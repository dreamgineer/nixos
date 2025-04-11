{
  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/D83224E63224CB78";
      fsType = "ntfs";
      options = [
        "nofail"
        "rw"
        "big_writes"
        "lazytime"
      ];
    };
  };
}
