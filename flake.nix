{
    description = "NixOS conifguration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur = {
            url = "github:nix-community/NUR";
        };
    };

    outputs = { home-manager, nixpkgs, nur, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        lib = nixpkgs.lib;

        mkSystem = pkgs: system: hostname:
            pkgs.lib.nixosSystem {
                system = system;
                modules = [
                    { nixpkgs.overlays = [ nur.overlay ]; }
                    { networking.hostName = hostname; }
                    (./. + "/hosts/${hostname}/configuration.nix")
                    (./. + "/hosts/${hostname}/hardware-configuration.nix")

                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useUserPackages = true;
                            useGlobalPkgs = true;
                            extraSpecialArgs = { inherit inputs; };

                            users.kiramanolo = (./. + "/hosts/${hostname}/user.nix");
                        };
                    }
                    (./. + "/hosts/${hostname}/system.nix")
                ];
                specialArgs = { inherit inputs; };
            };
    in {
        nixosConfigurations = {
            laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
        };
  };
}
