{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      airline
      coc-eslint
      coc-prettier
      coc-fzf
      coc-git
      coc-highlight #don't think I need this
      coc-html
      coc-json
      coc-nvim
      coc-python
      #coc-sql
      coc-tsserver
      coc-vimlsp
      coc-yaml
      ctrlp
      dracula-vim
      fugitive
      fzf-vim
      gruvbox
      haskell-vim 
      molokai
      nerdcommenter
      nerdtree
      palenight-vim
      papercolor-theme 
      vim-airline
      vim-airline-themes
      vim-autoformat
      vim-colors-solarized
      vim-devicons
      vim-hoogle
      vim-jsx-pretty
      vim-jsx-typescript
      vim-indent-guides
      vim-markdown
      vim-nix
      vim-surround
      vim-trailing-whitespace 
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-treesitter-textobjects
    ];
    extraConfig = builtins.readFile ./neovimrc;
  };
  home.file."nvim/coc-settings.json".text = builtins.toJSON {
      languageserver = {
        haskell = {
          command = "haskell-language-server-wrapper";
          args    = [ "--lsp"];
          filetypes = [ "hs" "lhs" "haskell" ];
          rootPatterns = [ "*.cabal" "stack.yml" "cabal.project" "package.yaml" "hie.yaml"];
          initializationOptions = {
            languageServerHaskell = {
              hlintOn = true;
            };
          };
        };
        nix = {
          command = "rnix-lsp";
          filetypes = [ "nix" ];
        };
        python = {
          command = "python-language-server";
          filetypes = [ "py" ];
          rootPatterns = [ "pyproject.toml" "setup.py" "setup.cfg" ];
        };
      };
     "eslint.autoFixOnSave" = true;
     "eslint.filetypes" = ["javascript"  "javascriptreact" "typescript"  "typescriptreact"];
     };

}
