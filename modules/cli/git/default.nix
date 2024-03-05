{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName = "KiraManolo.LENOVO-NIX";
            userEmail = "21977499+JunkManuel@users.noreply.github.com";
            extraConfig = {
                init = { defaultBranch = "master"; };
                core = {
                    excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
                };
            };
        };
    };
}
