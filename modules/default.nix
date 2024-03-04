{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "23.11";
    imports = [
        #gui
        ./librewolf
        ./firefox
        ./hyprland
        ./foot
        ./rofi
        ./dunst
        ./eww

        #cli
        ./nvim
        ./zsh
        ./gpg
        ./git
        ./direnv
        
        #system
        ./openssh
        ./xdg
        ./packages
    ];
}
