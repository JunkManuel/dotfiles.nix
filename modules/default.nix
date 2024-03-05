{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "23.11";
    imports = [
        ./gui

        ./cli
        
        ./userconf

        ./packages
    ];
}
