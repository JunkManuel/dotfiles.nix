{  lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.nvim;
    # Source my theme
    # jabuti-nvim = pkgs.vimUtils.buildVimPlugin {
    #     name = "jabuti-nvim";
    #     src = pkgs.fetchFromGitHub {
    #         owner = "jabuti-theme";
    #         repo = "jabuti-nvim";
    #         rev = "17f1b94cbf1871a89cdc264e4a8a2b3b4f7c76d2";
    #         sha256 = "sha256-iPjwx/rTd98LUPK1MUfqKXZhQ5NmKx/rN8RX1PIuDFA=";
    #     };
    # };
in {
    options.modules.nvim = { enable = mkEnableOption "nvim"; };
    config = mkIf cfg.enable {

        home.file.".config/nvim/settings.lua".source = ./init.lua;
        home.file.".config/nvim/lua" = {
            source = ./lua;
            recursive = true;
        };
        
        home.packages = with pkgs; [
            rnix-lsp nixfmt # Nix
            lua-language-server stylua # Lua
            python3Packages.jedi-language-server # python
            nodePackages.vim-language-server # vimscript

            dockerfile-language-server-nodejs # Dockerfiles
            docker-compose-language-service # docker-composes
        ];

        programs.zsh = {
            initExtra = ''
                export EDITOR="nvim"
                export VISUAL="nvim"
            '';

            shellAliases = {
                v = "nvim -i NONE";
                nvim = "nvim -i NONE";
            };
        };

        programs.neovim = {
            enable = true;
            plugins = with pkgs.vimPlugins; [ 
                vim-nix
                plenary-nvim
                # {
                #     plugin = zk-nvim;
                #     config = "require('zk').setup()";
                # }
                # {
                #     plugin = jabuti-nvim;
                #     config = "colorscheme jabuti";
                # }
                # {
                #     --use vim.loader.enable()
                #     plugin = impatient-nvim;
                #     config = "lua require('impatient')";
                # }
                {
                    plugin = kanagawa-nvim;
                    config = "luafile ~/.config/nvim/lua/kanagawa.lua";
                }
                {
                    plugin = comment-nvim;
                    config = "luafile ~/.config/nvim/lua/commenter.lua";
                }
                {
                    plugin = lualine-nvim;
                    config = "lua require('lualine').setup()";
                }
                {
                    plugin = telescope-nvim;
                    config = "lua require('telescope').setup()";
                }
                {
                    plugin = indent-blankline-nvim;
                    config = "lua require('ibl').setup()";
                }
                {
                    plugin = nvim-lspconfig;
                    config = ''
                        luafile ~/.config/nvim/lua/lsp.lua
                        luafile ~/.config/nvim/lua/lsp-ui.lua
                        luafile ~/.config/nvim/lua/lsp-keybindings.lua
                        '';
                }
                # {
                #     plugin = nvim-treesitter;
                #     config = ''
                #     lua << EOF
                #     require('nvim-treesitter.configs').setup {
                #         highlight = {
                #             enable = true,
                #             additional_vim_regex_highlighting = false,
                #         },
                #     }
                #     EOF
                #     '';
                # }
            ];

            extraConfig = ''
                luafile ~/.config/nvim/settings.lua
                '';
        };
    };
}
