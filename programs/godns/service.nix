{ pkgs, ... }: {
  systemd.services.godns = {
    description = "GoDNS Service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.godns.outPath}/bin/godns -c=/etc/nixos/programs/godns/config.json";
      Restart = "always";
      KillMode = "process";
      RestartSec = "2s";
    };
  };
}
