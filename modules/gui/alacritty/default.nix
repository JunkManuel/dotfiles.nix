{ pkgs, lib, config, ... }:

with lib;
let 
    cfg = config.modules.alacritty;
    alacritty-conf = (builtins.fromTOML ( builtins.readFile ./alacritty.toml));
in {
    options.modules.alacritty = { enable = mkEnableOption "alacritty"; };
    config = mkIf cfg.enable {
        programs.alacritty = {
            enable = true;
            settings = alacritty-conf;
        };
    };
}
