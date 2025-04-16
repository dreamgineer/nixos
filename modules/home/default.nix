{ config, pkgs, ... }:
{
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "dreamgineer";
    userEmail = "me@dgnr.us";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # Don't run this in non-interactive shells
      # home-manager initialization timeout workaround
      [[ $- == *i* ]] || return

      if [ "$TERM_PROGRAM" != "vscode" ]; then
          [ -f ~/.inshellisense/bash/init.sh ] && source ~/.inshellisense/bash/init.sh
          is && clear
          [ "$ISTERM" != "1" ] && exit
      fi
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      a = "nix-alien";
      rebuild = "nh os switch /etc/nixos -- --impure --accept-flake-config";
      frccode = "distrobox enter -n ubuntu -r -- bash /home/dgnr/wpilib/2025/frccode/frccode2025";
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
