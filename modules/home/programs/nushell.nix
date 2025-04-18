{ ... }:
{
  programs.nushell = {
    enable = true;
    extraLogin = ''
      if ( '~/.inshellisense/nu/init.nu' | path exists ) { source ~/.inshellisense/nu/init.nu }
    '';
    extraConfig = ''
      show_banner = false
    '';
    shellAliases = {
      a = "nix-alien";
      rebuild = "nh os switch /etc/nixos -- --impure --accept-flake-config";
      frccode = "distrobox enter -n ubuntu -r -- bash /home/dgnr/wpilib/2025/frccode/frccode2025";
    };
  };
}
