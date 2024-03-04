{ pkgs, lib, config, ... }:

with lib;
let 
    cfg = config.modules.syncthing;
    user = "kiramanolo";
in {
    options.modules.syncthing = { enable = mkEnableOption "syncthing"; };
    config = mkIf cfg.enable {
        # networking.firewall = {
        #     allowedTCPPorts = [ 22000 ];
        #     allowedUDPPorts = [ 22000 21027 ];
        # };
        services.syncthing = {
            enable = true;
            user = user;
            openDefaultPorts = true;
            dataDir = "/home/${user}/stuff/syncthing";
            configDir = "/home/${user}/.config/syncthing";
            overrideDevices = true;
            # overrideFolders = true;
            settings = {
                devices  = { 
                    "PocoPhone" = {
                        id = "Z7PSQDO-4UWTCUL-YQAXDVJ-JQ6RR6Q-A67TEWO-C5HUWR5-ATMKPQV-GRTYFAO";
                    };
                };
                folders = {
                    "mainDatabase" = {
                        path = "/home/${user}/database";
                        ignorePerms = false;

                        devices = [ "PocoPhone" ];
                        id = "h2dee-czndg";
                    };
                };
            };
        };
    };
}
