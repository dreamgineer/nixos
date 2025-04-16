{ ... }:
{
  programs.fastfetch.enable = true;
  programs.fastfetch.settings = {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    modules = [
      "title"
      "separator"
      "os"
      {
        format = "{/2}{-}{/}{2}{?3} {3}{?}";
        type = "host";
      }
      "kernel"
      "uptime"
      {
        format = "{/4}{-}{/}{4}{?5} [{5}]{?}";
        type = "battery";
      }
      "break"
      "packages"
      "shell"
      "display"
      "terminal"
      "break"
      "cpu"
      {
        key = "GPU";
        type = "gpu";
      }
      "memory"
      "break"
      "colors"
    ];
  };
}
