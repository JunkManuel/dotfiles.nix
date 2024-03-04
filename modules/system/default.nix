{ inputs, pkgs, config, ... }:

{
    imports = [
        ./syncthing
        ./openssh
    ];
}
