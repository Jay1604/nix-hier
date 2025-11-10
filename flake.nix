{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    tidaLuna.url = "github:Inrixia/TidaLuna";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-easyroam.url = "github:0x5a4/nix-easyroam";

    sops-nix.url = "github:Mic92/sops-nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, sops-nix, home-manager, nix-easyroam, nixvim, ... } @ inputs: 
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    nixvimModuleFor = pkgs: {
      inherit pkgs;
      module = import ./mod/nixvim { inherit pkgs inputs; };
    };
  in
  {
    packages.${system}.nixvim = nixvim.legacyPackages.${system}.makeNixvimWithModule (
      nixvimModuleFor nixpkgs.legacyPackages.${system}
    );

    nixosConfigurations = {
      orca = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit (self) inputs outputs;};
        inherit system;
        modules = [
          ./hosts/orca/configuration.nix
          inputs.home-manager.nixosModules.default
          sops-nix.nixosModules.sops
          nix-easyroam.nixosModules.nix-easyroam
        ];
      };
      narwal = nixpkgs.lib.nixosSystem {
	      specialArgs = {inherit (self) inputs outputs;};
        inherit system;
	      modules = [
	        ./hosts/narwal/configuration.nix
          inputs.home-manager.nixosModules.default
	        sops-nix.nixosModules.sops
	      ];
      };
    };
  };
}
