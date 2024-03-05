{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "23.11";
    imports = [
        ./nvim
        ./zsh
        ./gpg
        ./git
        ./direnv
    ];
}
