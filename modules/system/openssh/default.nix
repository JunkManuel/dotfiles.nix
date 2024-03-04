{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.openssh;

in {
    options.modules.openssh = { enable = mkEnableOption "openssh"; };
    config = mkIf cfg.enable {
        programs.ssh = {
            startAgent = true;
        };
    };
}
