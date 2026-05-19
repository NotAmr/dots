{
  description = "Modular NixOS system with Hyprland 0.55.2 and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pin Hyprland to v0.55.2 (Lua config era)
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.55.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
  let
    system = "x86_64-linux";   # change to "aarch64-linux" if needed
    username = "rikudo";         # your username
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        # 1. Hyprland NixOS module (provides programs.hyprland)
        hyprland.nixosModules.default

        # 2. Home Manager (system‐wide integration)
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./home.nix;
          };
        }

        # 3. Your main system configuration
        ./configuration.nix

        # 4. Customisable feature toggles (mySystem.*)
        ./modules/custom-options.nix
      ];
    };
  };
}
