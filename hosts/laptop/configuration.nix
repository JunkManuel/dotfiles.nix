{ config, pkgs, inputs, ... }:

{
    # Remove unecessary preinstalled packages
    environment.defaultPackages = [ ];
    services.xserver.desktopManager.xterm.enable = false;

    programs.zsh.enable = true;
    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    virtualisation.docker.enable = true;

    # Laptop-specific packages (the other ones are installed in `packages.nix`)
    environment.systemPackages = with pkgs; [
        acpi tlp git
    ];

    # Install fonts
    fonts = {
        packages = with pkgs; [
            jetbrains-mono
            roboto
            openmoji-color
            (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

        fontconfig = {
            hinting.autohint = true;
            defaultFonts = {
              emoji = [ "OpenMoji Color" ];
            };
        };
    };


    # Wayland stuff: enable XDG integration, allow sway to use brillo
    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
            # gtkUsePortal = true;
            config.common.default = "*";
        };
    };

    # Nix settings, auto cleanup and enable flakes
    nix = {
        settings = {
            auto-optimise-store = true;
            allowed-users = [ "kiramanolo" ];

            substituters = ["https://hyprland.cachix.org"];
            trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="]; 
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    # Boot settings: clean /tmp/, latest kernel and enable bootloader
    boot = {
        tmp.cleanOnBoot = true;
        loader = {
            efi = {
                canTouchEfiVariables = true;
            };
            grub = {
                # Inserted (/boot) device
                device = "nodev";
                efiSupport = true;
                # Insert access to Arch Linux grub
                extraEntries = ''
                menuentry "Arch" --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-ae39e45f-1d9d-41b1-bbe2-f8bcc3a68b38' {
    		        search --set=arch --fs-uuid 545E-0E53
    		        configfile "($arch)/grub/grub.arch.cfg"
                }
                '';
                # Import a Grub theme just cause
                theme = pkgs.stdenv.mkDerivation {
    		        pname = "distro-grub-themes";
    		        version = "3.1";
    		        src = pkgs.fetchFromGitHub {
                        owner = "AdisonCavani";
                        repo = "distro-grub-themes";
                        rev = "v3.1";
                        hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    		        };
    		        installPhase = "cp -r customize/nixos $out";
                };
            };
        };
    };

    # Set up locales (timezone and keyboard layout)
    time.timeZone = "Europe/Madrid";
    i18n.defaultLocale = "es_ES.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        keyMap = "es";
    };

    # Set up user and enable sudo
    users.users.kiramanolo = {
        isNormalUser = true;
        extraGroups = [ "input" "wheel" "docker" ];
        shell = pkgs.zsh;
    };

    # Set up networking and secure it
    networking = {
        wireless.iwd.enable = false;
        networkmanager.enable = true;
        firewall = {
            enable = true;
            # allowedTCPPorts = [  ];
            # allowedUDPPorts = [  ];
            allowPing = false;
        };
    };

    # Set environment variables
    environment.variables = {
        NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
        NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";

        XDG_DATA_HOME = "$HOME/.local/share";
        PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";

        GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
        GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";

        # ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";

        EDITOR = "nvim";
        VISUAL = "nvim";
        DIRENV_LOG_FORMAT = "";

        MOZ_ENABLE_WAYLAND = "1";
        ANKI_WAYLAND = "1";
        DISABLE_QT5_COMPAT = "0";
    };

    # Security 
    security = {
        sudo = { 
            enable = true;
            extraRules = [
            {
                groups = [ "wheel" ];
                commands = [
                    {
                        command = "/run/current-system/sw/bin/nixos-rebuild";
                        options = [ "NOPASSWD" ];
                    }
                ];
            }
            ];
        };
        doas = {
            enable = false;
            extraRules = [{
                users = [ "kiramanolo" ];
                keepEnv = true;
                persist = true;
            }];
        };

        # Extra security
        protectKernelImage = true;
    };

    # Sound
    sound = {
        enable = true;
    };

    hardware.pulseaudio.enable = false;

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
    };
    
    # Disable bluetooth, enable pulseaudio, enable opengl (for Wayland)
    hardware = {
        bluetooth.enable = false;
        opengl = {
            enable = true;
            driSupport = true;
        };
    };

    # Do not touch
    system.stateVersion = "23.11";
}

