{
  description =
    "NixOS configuration and home-manager configurations for mac and debian gnu/linux";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    #nix languag server
    rnix-lsp = {
      url = "github:nix-community/rnix-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ##sql language server
    #sqls = {
      #url = "github:lighttiger2505/sqls";
      #flake = false;
    #};

    # nvim latest plugins
    heirline-nvim = {
      url = "github:rebelot/heirline.nvim";
      flake = false;
    };
    lsp_lines-nvim = {
      url = "git+https://git.sr.ht/~whynothugo/lsp_lines.nvim?ref=main";
      flake = false;
    };

    null-ls-nvim = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };

    #sqls-nvim = {
      #url = "github:nanotee/sqls.nvim";
      #flake = false;
    #};

    dressing-nvim = {
      url = "github:stevearc/dressing.nvim";
      flake = false;
    };

    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };

    friendly-snippets-vim = {
      url = "github:rafamadriz/friendly-snippets";
      flake = false;
    };

    lspkind-nvim = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };

    onedark-nvim = {
      url = "github:navarasu/onedark.nvim";
      flake = false;
    };

    tokyonight-nvim = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };

    copilot-cmp = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };

    copilot-lua = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };

    chatgpt-nvim = {
      url = "github:jackMort/ChatGPT.nvim";
      flake = false;
    };

  };
  outputs = { self, home-manager, nixpkgs, neovim-nightly-overlay, ... }@inputs:
    let
      #pkgs = nixpkgs.legacyPackages.x86_64-linux;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      defaultUser = "slaser79";
      vimPluginsOverlay = final: prev: {
        vimPlugins = prev.vimPlugins // {
          inherit (self.packages.${prev.system})
            heirline-nvim lsp_lines-nvim null-ls-nvim dressing-nvim nvim-cmp
            lspkind-nvim onedark-nvim tokyonight-nvim
            friendly-snippets-vim chatgpt-nvim;
        };
      };

      #sqls-overlay = _: prev: {
        #sqls = prev.buildGoModule rec {
          #pname = "sqls";
          #version = "0.2.22";

          #doCheck = false;
          #src = inputs.sqls;
          #buildinputs = with pkgs; [ oracle-instantclient odpic ];
          #nativeBuildInputs = with pkgs; [ makeWrapper ];

          #overrideModAttrs = oldAttrs: {
            #impureEnvVars = oldAttrs.impureEnvVars ++ [ "HTTPS_PROXY" ];
          #};
          #vendorSha256 = "sha256-sowzyhvNr7Ek3ex4BP415HhHSKnqPHy5EbnECDVZOGw=";

          #ldflags = [
            #"-s"
            #"-w"
            #"-X main.version=${version}"
            #"-X main.revision=${src.rev}"
          #];

          #meta = with pkgs.lib; {
            #homepage = "https://github.com/lighttiger2505/sqls";
            #description = "SQL language server written in Go";
            #license = licenses.mit;
            #maintainers = [ maintainers.marsam ];
          #};

          #postInstall = ''
            #if [ -f $out/bin/sqls ]; then
              #wrapProgram $out/bin/sqls\
                #--set LD_LIBRARY_PATH ${
                  #pkgs.lib.makeLibraryPath [ pkgs.oracle-instantclient.lib ]
                #}
            #fi
          #'';

        #};
      #};

      overlays = [
        #neovim-nightly-overlay.overlay
        vimPluginsOverlay
        #sqls-overlay
      ];

      homeManagerConfFor = config: { ... }: { imports = [ config ]; };
      wsl2UbuntuSystemFor = user:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            (homeManagerConfFor ./hosts/sflaptop-wsl2-ubuntu/home.nix)
            {
              nixpkgs.overlays = overlays;
              home = {
                username = "${user}";
                homeDirectory = "/home/${user}";
                stateVersion = "21.05";
              };
            }
          ];

        };
      defaultWslUbuntu = wsl2UbuntuSystemFor defaultUser;
    in
    {
      nixpkgs = pkgs;
      packages.x86_64-linux =
        let
          # This is required to create a proper derivation to reference in the overlay for nixpkgs 
          mkVimPlugins = pnames:
            builtins.listToAttrs (builtins.map
              (pname:
                pkgs.lib.nameValuePair pname (pkgs.vimUtils.buildVimPluginFrom2Nix {
                  inherit pname;
                  src = inputs.${pname};
                  version = inputs.${pname}.shortRev;
                }))
              pnames);
        in
        mkVimPlugins [
          "heirline-nvim"
          "lsp_lines-nvim"
          "null-ls-nvim"
          #"sqls-nvim"
          "dressing-nvim"
          "nvim-cmp"
          "lspkind-nvim"
          "onedark-nvim"
          "tokyonight-nvim"
          "friendly-snippets-vim"
          "copilot-cmp"
          "copilot-lua"
          "chatgpt-nvim"
        ];
      wsl2ubuntuDefaultUser = defaultWslUbuntu.activationPackage;
      wsl2ubuntug49771 = (wsl2UbuntuSystemFor "g49771").activationPackage;
      defaultPackage.x86_64-linux = defaultWslUbuntu.activationPackage;
      homeConfigurations.${defaultUser} = defaultWslUbuntu;
    };
}
