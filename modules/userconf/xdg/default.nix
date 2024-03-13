{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xdg;

in {
    options.modules.xdg = { enable = mkEnableOption "xdg"; };
    config = mkIf cfg.enable {
        xdg.userDirs = {
            enable = true;
            documents = "$HOME/stuff/other/";
            download = "$HOME/stuff/other/";
            videos = "$HOME/stuff/other/";
            music = "$HOME/stuff/music/";
            pictures = "$HOME/stuff/pictures/";
            desktop = "$HOME/stuff/other/";
            publicShare = "$HOME/stuff/other/";
            templates = "$HOME/stuff/other/";
        };
        xdg.desktopEntries = {
            "org.codeberg.dnkl.foot" = {
                name = "Foot";
                noDisplay = true;
            };
            "org.codeberg.dnkl.foot-server" = {
                name = "Foot Server";
                noDisplay = true;
            };
            "hakuneko-desktop" = {
                categories = [ "Network" "FileTransfer" ];
                genericName = "Manga & Anime Downloader";
                name = "Hakuneko";
                exec = "hakuneko --no-sandbox";
                icon = "hakuneko-desktop";
                type = "Application";
            };
        };
    };
}
