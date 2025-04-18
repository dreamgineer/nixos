{ ... }:
{
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
    extraConfig = ''
      source ${builtins.toString ./assets/init.nu}
    '';
    shellAliases = {
      a = "nix-alien";
      rebuild = "nh os switch /etc/nixos -- --impure --accept-flake-config";
      frccode = "distrobox enter -n ubuntu -r -- bash /home/dgnr/wpilib/2025/frccode/frccode2025";
    };
  };
}
