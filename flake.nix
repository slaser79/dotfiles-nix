{
  description = "NixOS configuration and home-manager configurations for mac and debian gnu/linux";
  inputs = {
    nixpkgs.url =  "github:NixOS/nixpkgs/?rev=0432195a4b8d68faaa7d3d4b355260a3120aeeae"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { home-manager, nixpkgs, ...}:
    let
      homeManagerConfFor = config: { ... }: {
        nixpkgs.overlays = [ ];
        imports = [ config ];
      };
      wsl2UbuntuSystem = home-manager.lib.homeManagerConfiguration {
        configuration = homeManagerConfFor ./hosts/xps-wsl2-ubuntu/home.nix;
        system = "x86_64-linux";
        homeDirectory = "/home/shingi79";
        username = "shingi79";
        stateVersion = "21.05";
      };
    in {
      wsl2ubuntu = wsl2UbuntuSystem.activationPackage;
      defaultPackage.x86_64-linux = wsl2UbuntuSystem.activationPackage;
    };
}
