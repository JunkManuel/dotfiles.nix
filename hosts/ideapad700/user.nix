{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/default.nix ];

    config.modules = {
        #gui
        librewolf.enable    = true;
        firefox.enable      = true;
        hyprland.enable     = true;
        foot.enable         = false;
        alacritty.enable    = true;
        rofi.enable         = true;
        eww.enable          = true;
        dunst.enable        = true;
        wallust.enable      = true;

        #cli
        zsh.enable          = true;
        nvim.enable         = true;
        direnv.enable       = true;
        git.enable          = true;
        gpg.enable          = true;

        #system
        openssh.enable      = true;
        xdg.enable          = true;
        packages.enable     = true;
    };
} 
