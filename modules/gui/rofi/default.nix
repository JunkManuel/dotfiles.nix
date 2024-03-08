{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.rofi;

in {
    options.modules.rofi = { enable = mkEnableOption "rofi"; };
    config = mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland;

            cycle = true;
            font = "JetBrainsMono 16";
            location = "center";
            terminal = "/etc/profiles/per-user/kiramanolo/bin/foot";
            theme = "fancy";

            extraConfig = {
                modes = "window,drun,ssh";
                show-icons = true;

                display-window = " ";
                display-run = " ";
                display-ssh = "󰣀 ";
                display-drun = " ";
                icon-theme = "Moka";
            };

            pass = {
                enable = true;
                package = pkgs.rofi-pass-wayland;
            };
        };
    };
}
