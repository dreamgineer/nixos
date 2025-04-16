{ config, ... }:
{
  programs.waybar.enable = true;
  programs.waybar.settings = [
    {
      layer = "top"; # Waybar at top layer
      "position" = "bottom"; # Waybar at the bottom of your screen
      "reload_style_on_change" = true;
      height = 18; # Waybar height
      # width = 1366; // Waybar width
      # Choose the order of the modules
      modules-left = [
        "hyprland/workspaces"
        "custom/spotify"
      ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "battery"
        "tray"
        "clock"
      ];
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
          "empty" = "";
        };
        persistent-workspaces = {
          "*" = [
            1
            2
            3
            4
            5
          ];
        };
      };
      tray = {
        # icon-size = 21;
        "spacing" = 5;
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
      };
      cpu = {
        format = "{usage}% ";
      };
      memory = {
        format = "{}% ";
      };
      battery = {
        bat = "BAT0";
        states = {
          # good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-good = ""; # An empty format will hide the module
        format-full = "";
        format-icons = [
          "󰁻"
          "󰁼"
          "󰁾"
          "󰂀"
          "󰂂"
          "󰁹"
        ];
      };
      "network" = {
        format-wifi = "";
        format-ethernet = "";
        format-disconnected = "";
        tooltip-format-disconnected = "Error";
        tooltip-format-wifi = "{essid} ({signalStrength}%) ";
        tooltip-format-ethernet = "{ifname} 🖧 ";
        on-click = "kitty nmtui";
      };
      "pulseaudio" = {
        #scroll-step = 1;
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };
      "custom/spotify" = {
        format = " {}";
        max-length = 40;
        interval = 30; # Remove this if your script is endless and write in loop
        exec = "$HOME/.config/waybar/mediaplayer.sh 2> /dev/null"; # Script in resources folder
        exec-if = "pgrep spotify";
      };
    }
  ];
  programs.waybar.style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Ubuntu Nerd Font";
        font-size: 13px;
        min-height: 0;
    }

    window#waybar {
        background: transparent;
        color: white;
    }

    #window {
        font-weight: bold;
        font-family: "Ubuntu";
    }
    /*
    #workspaces {
        padding: 0 5px;
    }
    */

    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: white;
        border-top: 2px solid transparent;
    }

    #workspaces button.active {
        color: #1c76fd;
    }

    #workspaces button.empty {
        color: #555555;
    }

    #workspaces button.empty.active {
        color: #345079;
    }

    #mode {
        background: #64727D;
        border-bottom: 3px solid white;
    }

    #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
        padding: 0 3px;
        margin: 0 2px;
    }

    #clock {
        font-weight: bold;
    }

    #battery {
    }

    #battery icon {
        color: red;
    }

    #battery.charging {
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: black;
        }
    }

    #battery.warning:not(.charging) {
        color: white;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #cpu {
    }

    #memory {
    }

    #network {
    }

    #network.disconnected {
        background: #f53c3c;
    }

    #pulseaudio {
    }

    #pulseaudio.muted {
    }

    #custom-spotify {
        color: rgb(102, 220, 105);
    }

    #tray {
    }
  '';
  home.file."${config.xdg.configHome}/waybar/mediaplayer.sh" = {
    executable = true;
    text = ''
          #!/bin/sh
      player_status=$(playerctl status 2> /dev/null)
      if [ "$player_status" = "Playing" ]; then
          echo "$(playerctl metadata artist) - $(playerctl metadata title)"
      elif [ "$player_status" = "Paused" ]; then
          echo " $(playerctl metadata artist) - $(playerctl metadata title)"
      fi
    '';
  };
}
