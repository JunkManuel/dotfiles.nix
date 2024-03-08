{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.rofi;

in {
    options.modules.rofi = { enable = mkEnableOption "rofi"; };
    config = mkIf cfg.enable {
        home.file.".config/rofi/themes" = {
            source = ./themes;
            recursive = true;
        };
        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland;

            cycle = true;
            font = "JetBrainsMono 12";
            location = "center";
            terminal = "/etc/profiles/per-user/kiramanolo/bin/foot";
            theme = "/home/kiramanolo/.config/rofi/themes/nova-dark.rasi";

            extraConfig = {
                modes = "window,drun,ssh";
                show-icons = true;

                display-window = "";
                display-run = "";
                display-ssh = "󰣀";
                display-drun = "";
                display-filebrowser = "";
                icon-theme = "Moka";
            };

            pass = {
                enable = true;
                package = pkgs.rofi-pass-wayland;
            };
        };
    };
}
