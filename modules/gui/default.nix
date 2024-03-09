{ inputs, pkgs, config, ... }:

{
    # home.stateVersion = "23.11";
    imports = [
        ./librewolf
        ./firefox
        ./hyprland
        ./foot
        ./rofi
        ./dunst
        ./eww
        ./wallust
    ];
}
