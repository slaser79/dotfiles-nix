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

    sqls-nvim = {
      url = "github:nanotee/sqls.nvim";
      flake = false;
    };



  };
  outputs = { self, home-manager, nixpkgs, coc-sh-src, neovim-nightly-overlay, ... }@inputs:
    let
      #pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };

      defaultUser = "shingi79";
      vimPluginsOverlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          inherit (self.packages.${prev.system})
            filetype-nvim
            heirline-nvim
            lsp_lines-nvim
            null-ls-nvim
            sqls-nvim;
        };
      };

      sqls-overlay = _: prev: {
        sqls = prev.buildGoModule
          rec {
            pname = "sqls";
            version = "0.2.22";

            doCheck = false;
            src = inputs.sqls;
            buildinputs = with pkgs; [ oracle-instantclient odpic];
            nativeBuildInputs = with pkgs; [ makeWrapper];

            overrideModAttrs = oldAttrs: {
              impureEnvVars = oldAttrs.impureEnvVars ++ [ "HTTPS_PROXY" ];
            };
            vendorSha256 = "sha256-sowzyhvNr7Ek3ex4BP415HhHSKnqPHy5EbnECDVZOGw=";

            ldflags = [ "-s" "-w" "-X main.version=${version}" "-X main.revision=${src.rev}" ];

            meta = with pkgs.lib; {
              homepage = "https://github.com/lighttiger2505/sqls";
              description = "SQL language server written in Go";
              license = licenses.mit;
              maintainers = [ maintainers.marsam ];
            };

            postInstall = ''
              if [ -f $out/bin/sqls ]; then
                wrapProgram $out/bin/sqls\
                  --set LD_LIBRARY_PATH ${pkgs.lib.makeLibraryPath [ pkgs.oracle-instantclient.lib ]}
              fi
            '';

          };
      };

      overlays = [
        neovim-nightly-overlay.overlay
        vimPluginsOverlay
        sqls-overlay
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
      nixpkgs = pkgs;
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
        mkVimPlugins [ "heirline-nvim" "filetype-nvim" "lsp_lines-nvim" "null-ls-nvim" "sqls-nvim" ];
      wsl2ubuntuDefaultUser = defaultWslUbuntu.activationPackage;
      wsl2ubuntug49771 = (wsl2UbuntuSystemFor "g49771").activationPackage;
      defaultPackage.x86_64-linux = defaultWslUbuntu.activationPackage;
    };
}
