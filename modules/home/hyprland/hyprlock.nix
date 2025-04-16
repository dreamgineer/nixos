{ config, ... }:
{
  services.hyprlock.enable = true;
  services.hyprlock.settings = {
    "$text_color" = "rgba(FFDAD6FF)";
    "$entry_background_color" = "rgba(41000311)";
    "$entry_border_color" = "rgba(896E6C55)";
    "$entry_color" = "rgba(FFDAD6FF)";
    "$font_family" = "Rubik Light";
    "$font_family_clock" = "Rubik Light";
    "$font_material_symbols" = "Material Symbols Rounded";

    general = {
      immediate_render = true;
      hide_cursor = true;
    };
    auth = {
      "fingerprint:enabled" = true;
    };
    background = {
      color = "rgba(181818FF)";
      # path = {{ SWWW_WALL }}

      path = "/etc/nixos/modules/home/hyprland/assets/bg-blank.png";
      # blur_size = 15
      # blur_passes = 4
    };
    input-field = {
      monitor = "";
      size = "250, 50";
      outline_thickness = 2;
      dots_size = 0.1;
      dots_spacing = 0.3;
      outer_color = "$entry_border_color";
      inner_color = "$entry_background_color";
      font_color = "$entry_color";
      fade_on_empty = true;
      position = "0, 20";
      halign = "center";
      valign = "center";
    };

    label = [
      {
        # Clock
        monitor = "";
        text = "$TIME";
        color = "$text_color";
        font_size = 65;
        font_family = "$font_family_clock";

        position = "0, 300";
        halign = "center";
        valign = "center";
      }
      {
        # Date
        monitor = "";
        text = "cmd[update:5000] date +\"%A, %B %d\"";
        color = "$text_color";
        font_size = 17;
        font_family = "$font_family";

        position = "0, 240";
        halign = "center";
        valign = "center";
      }

      {
        # User
        monitor = "";
        text = "    $USER";
        color = "$text_color";
        shadow_passes = 1;
        shadow_boost = 0.35;
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        font_size = 20;
        font_family = "$font_family";
        position = "0, 50";
        halign = "center";
        valign = "bottom";
      }

      {
        # Status
        monitor = "";
        text = "cmd[update:5000] \${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprlock/status.sh";
        color = "$text_color";
        font_size = 14;
        font_family = "$font_family";

        position = "30, -30";
        halign = "left";
        valign = "top";
      }
    ];
  };
  home.file."${config.xdg.configHome}/hypr/hyprlock/status.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ############ Variables ############
      enable_battery=false
      battery_charging=false

      ####### Check availability ########
      for battery in /sys/class/power_supply/*BAT*; do
        if [[ -f "$battery/uevent" ]]; then
          enable_battery=true
          if [[ $(cat /sys/class/power_supply/*/status | head -1) == "Charging" ]]; then
            battery_charging=true
          fi
          break
        fi
      done

      ############# Output #############
      if [[ $enable_battery == true ]]; then
        if [[ $battery_charging == true ]]; then
          echo -n "(+) "
        fi
        echo -n "$(cat /sys/class/power_supply/*/capacity | head -1)"%
        if [[ $battery_charging == false ]]; then
          echo -n " remaining"
        fi
      fi

      echo ""
    '';
  };
}
