{ ... }:
{
  programs.wofi.enable = true;
  programs.wofi.settings = {
    location = "top";
    allow_markup = true;
    width = 250;
    matching = "multi-contains";
    show = "drun,run";
  };
}
