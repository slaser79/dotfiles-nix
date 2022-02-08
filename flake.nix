{
  description = "NixOS configuration and home-manager configurations for mac and debian gnu/linux";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/?rev=0432195a4b8d68faaa7d3d4b355260a3120aeeae";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    coc-sh-src = {
      flake = false;
      url = github:josa42/coc-sh;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    heirline-nvim = {
      url = "github:rebelot/heirline.nvim";
      flake = false;
    };
    filetype-nvim = {
      url = "github:nathom/filetype.nvim";
      flake = false;
    };
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lsp_lines-nvim = {
      url = "git+https://git.sr.ht/~whynothugo/lsp_lines.nvim?ref=main";
      flake = false;
    };

    null-ls-nvim = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    #sql language server

    sqls = {
      url = "github:lighttiger2505/sqls";
      flake = false;
    };


  };
  outputs = { self, home-manager, nixpkgs, coc-sh-src, neovim-nightly-overlay, ... }@inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      defaultUser = "shingi79";
      vimPluginsOverlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          inherit (self.packages.${prev.system})
            filetype-nvim
            heirline-nvim
            lsp_lines-nvim
            null-ls-nvim;
        };
      };

      overlays = [
        neovim-nightly-overlay.overlay
        vimPluginsOverlay
      ];
      homeManagerConfFor = config: { ... }: {
        nixpkgs.overlays = overlays;
        imports = [ config ];
      };
      wsl2UbuntuSystemFor = user: home-manager.lib.homeManagerConfiguration {
        configuration = homeManagerConfFor ./hosts/xps-wsl2-ubuntu/home.nix;
        system = "x86_64-linux";
        homeDirectory = "/home/${user}";
        username = "${user}";
        stateVersion = "21.05";
      };
      defaultWslUbuntu = wsl2UbuntuSystemFor defaultUser;
    in
    {
      packages.x86_64-linux =
        let
          # This is required to create a proper derivation to reference in the overlay for nixpkgs 
          mkVimPlugins = pnames:
            builtins.listToAttrs (
              builtins.map
                (pname: pkgs.lib.nameValuePair pname
                  (pkgs.vimUtils.buildVimPluginFrom2Nix {
                    inherit pname;
                    src = inputs.${pname};
                    version = inputs.${pname}.shortRev;
                  }))
                pnames);
        in
        mkVimPlugins [ "heirline-nvim" "filetype-nvim" "lsp_lines-nvim" "null-ls-nvim" ];
      wsl2ubuntuDefaultUser = defaultWslUbuntu.activationPackage;
      wsl2ubuntug49771 = (wsl2UbuntuSystemFor "g49771").activationPackage;
      defaultPackage.x86_64-linux = defaultWslUbuntu.activationPackage;
      sqls =

        pkgs.buildGoModule
          rec {
            pname = "sqls";
            version = "0.2.22";

            src = inputs.sqls;


            vendorSha256 = "sha256-fo5g6anMcKqdzLG8KCJ/T4uTOp1Z5Du4EtCHYkLgUpo=";

            ldflags = [ "-s" "-w" "-X main.version=${version}" "-X main.revision=${src.rev}" ];

            meta = with pkgs.lib; {
              homepage = "https://github.com/lighttiger2505/sqls";
              description = "SQL language server written in Go";
              license = licenses.mit;
              maintainers = [ maintainers.marsam ];
            };

          };
    };
}
