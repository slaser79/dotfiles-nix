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
      defaultUser = "shingi79";
      homeManagerConfFor = config: { ... }: {
        nixpkgs.overlays = [ ];
        imports = [ config ];
      };
      wsl2UbuntuSystemFor =user: home-manager.lib.homeManagerConfiguration {
                                    configuration = homeManagerConfFor ./hosts/xps-wsl2-ubuntu/home.nix;
                                    system = "x86_64-linux";
                                    homeDirectory = "/home/${user}";
                                    username = "${user}";
                                    stateVersion = "21.05";
                                  };
      defaultWslUbuntu = wsl2UbuntuSystemFor defaultUser; 
    in {
      wsl2ubuntuDefaultUser = defaultWslUbuntu.activationPackage;
      wsl2ubuntug49771      = (wsl2UbuntuSystemFor "g49771") .activationPackage;
      defaultPackage.x86_64-linux = defaultWslUbuntu.activationPackage;

    };
}
