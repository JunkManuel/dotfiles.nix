{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/system/default.nix ];

    config.modules = {
        syncthing.enable  = true;
        openssh.enable    = true;
    };
}
