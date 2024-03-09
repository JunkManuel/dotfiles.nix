{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.wallust;

in {
    options.modules.wallust = { enable = mkEnableOption "wallust"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [ wallust ];
        home.file = {
            ".config/wallust/wallust.toml".source = ./wallust.toml;
            ".config/wallust/templates" = {
                source = ./templates;
                recursive = true;
            };
        };
    };
}
