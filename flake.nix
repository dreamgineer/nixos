{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nix-index stuff
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    wpilib.url = "github:frc4451/frc-nix";
    thorium.url = "path:./programs/thorium/";
    nix-alien.url = "github:thiagokokada/nix-alien";

    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # only needed if you use as a package set:
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-index-database,
      wpilib,
      thorium,
      home-manager,
      nixpkgs-wayland,
      winapps,
      ...
    }:
    {
      # use it as an overlay
      nixpkgs.overlays = [ nixpkgs-wayland.overlay ];

      # replace 'nyx' with your hostname here.
      nixosConfigurations.nyx = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit self system winapps; };
        modules = [
          ./configuration.nix
          ./modules
          (
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [ cachix ];
            }
          )

          # comma & nix-index
          nix-index-database.nixosModules.nix-index
          { programs.nix-index-database.comma.enable = true; }

          # Add WPILib packages
          (
            { ... }:
            {
              environment.systemPackages = [
                wpilib.packages.${system}.glass
                wpilib.packages.${system}.advantagescope
                wpilib.packages.${system}.vscode-wpilib
                thorium.packages.${system}.default
              ];
            }
          )

          # nix-alien
          (
            { self, pkgs, ... }:
            {
              nixpkgs.overlays = [
                self.inputs.nix-alien.overlays.default
              ];
              environment.systemPackages = with pkgs; [
                nix-alien
              ];
              # Optional, needed for `nix-alien-ld`
              programs.nix-ld.enable = true;
            }
          )

          # GoDNS systemd service
          ./programs/godns/service.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.dgnr = import ./modules/home;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  nixConfig = {
    # add binary caches
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
  };
}
