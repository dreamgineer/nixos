{ ... }:
{
  programs.tofi.enable = true;
  programs.tofi.settings = {
    anchor = "bottom";
    height = 18;
    width = "100%";
    prompt-text = " > ";
    font = "monospace";
    font-size = 14;
    outline-width = 0;
    border-wirth = 0;
    background-color = "#000000";
    horizontal = true;
    min-input-width = 120;
    result-spacing = 15;
    padding-top = 0;
    padding-bottom = 0;
    padding-left = 0;
    padding-right = 0;
    drun-launch = true;
  };
}
