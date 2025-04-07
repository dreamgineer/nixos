{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nix-index stuff
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    wpilib.url = "github:frc4451/frc-nix";
    thorium.url = "git+file:///etc/nixos/programs/thorium/";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-index-database,
      wpilib,
      thorium,
      ...
    }:
    {
      # replace 'nyx' with your hostname here.
      nixosConfigurations.nyx = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit self system; };
        modules = [
          ./configuration.nix

          # comma & nix-index
          nix-index-database.nixosModules.nix-index
          { programs.nix-index-database.comma.enable = true; } # Add WPILib packages
          (
            {
              pkgs,
              ...
            }:
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
        ];
      };
    };
}
