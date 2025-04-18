{ ... }:
{
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      completions.algorithm = "fuzzy";
    };
    extraConfig = ''
      source ${builtins.toString ./assets/init.nu}
      is
      clear
      if (($env.ISTERM? | default "0") != "1") { exit }
    '';
    extraEnv = ''
      $env.PROMPT_COMMAND_RIGHT = ""
      $env.PROMPT_INDICATOR = " "
    '';
    shellAliases = {
      a = "nix-alien";
      rebuild = "nh os switch /etc/nixos -- --impure --accept-flake-config";
      frccode = "distrobox enter -n ubuntu -r -- bash /home/dgnr/wpilib/2025/frccode/frccode2025";
    };
  };
}
