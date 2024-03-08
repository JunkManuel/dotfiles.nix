{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
    options.modules.hyprland= { enable = mkEnableOption "hyprland"; };
    config = mkIf cfg.enable {
	    home.packages = with pkgs; [
	        rofi-wayland hyprpaper wlsunset wl-clipboard pywal wallust # hyprland
	    ];
        gtk.iconTheme.package = pkgs.moka-icon-theme;

        home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
        home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    };
}
