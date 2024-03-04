{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.librewolf;
in {
    options.modules.librewolf = { enable = mkEnableOption "librewolf"; };

    config = mkIf cfg.enable {
        programs.librewolf = {
            enable = true;
            settings = {
                "webgl.disbled" = false;
                "privacy.resistFigerprinting" = false;
                "privacy.clearOnShutdown.history" = false;
            };
        };
    };
}
