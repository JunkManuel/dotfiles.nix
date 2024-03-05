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
            font = "JetBrainsMono 16p";
            location = "center";
            terminal = "\${pkgs.foot}/bin/foot";

            pass = {
                enable = true;
                package = pkgs.rofi-pass-wayland;
            };
        };
    };
}
