{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.openssh;

in {
    options.modules.openssh = { enable = mkEnableOption "openssh"; };
    config = mkIf cfg.enable {
        programs.ssh = {
            enable = true;
            addKeysToAgent = "yes";
            extraConfig = ''
                Host gitJunkManuel
                    Hostname            github.com
                    IdentityFile        ~/.ssh/id_ed25519_githubMain
                    IdentitiesOnly      yes
                Host kiramanolo.ddns.net
                    Hostname            kiramanolo.ddns.net
                    IdentityFile        ~/.ssh/id_ed25519_oracle
                    IdentitiesOnly      yes
                '';
        };
    };
}
