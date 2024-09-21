{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      #(nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars)) # tree-sitter code AST
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-treesitter-context
      #copilot-vim #github copilot
      copilot-lua #github copilot
      chatgpt-nvim #chatgpt
      copilot-cmp #github copilot
      cmp-buffer # nvim-cmp completion buffer source
      cmp-cmdline # nvim-cmp commands completion source
      cmp-nvim-lsp # nvim-cmp completion LSP source
      cmp-nvim-lua # nvim-cmp completion Neovim Lua API source
      cmp-path # nvim-cmp completion Path source
      cmp-under-comparator # nvim-cmp completion sorter
      cmp_luasnip # nvim-cmp completion Luasnip snippets source
      dressing-nvim # Update vim.ui interfaces 
      editorconfig-nvim # `.editorconfig` code style support
      friendly-snippets-vim #for vscode like snippets
      heirline-nvim # Statusline
      indent-blankline-nvim # Indentation highlighting
      kanagawa-nvim # Neovim theme
      lightspeed-nvim # Navigation and range motions
      lsp_lines-nvim # Virtual line LSP diagnostics
      lspkind-nvim # Completion item kind symbols
      luasnip # Completion snippets engine
      nui-nvim # UI components for chatgpt-nvim
      nvim-cmp # Completion
      nvim-colorizer-lua # Colour code colorizer
      nvim-web-devicons # Coloured file icons
      nvim-lspconfig # LSP default configurations

      onedark-vim #LSP Color theme using tree-sitter
      #sqls-nvim
      plenary-nvim # Telescope-nvim dependency
      telescope-fzf-native-nvim # FZF sorter for telescope
      telescope-nvim # Fuzzy finder
      gitsigns-nvim # Git integration
      null-ls-nvim # LSP for formatters and linting
      #Extra from original vim config
      fugitive
      gruvbox
      haskell-vim
      dracula-vim
      molokai
      nerdcommenter
      palenight-vim
      papercolor-theme
      tokyonight-nvim #Color theme optimized for tree-sitter
      vim-surround
      vim-nix
      vim-markdown
      which-key-nvim # Keybinding popup
    ] ++ builtins.map (plugin: { inherit plugin; optional = true; }) [
      # Load optional plugins with `:packadd`
      playground # tree-sitter playground
    ];
    extraPackages = with pkgs; [
      #ccls # C/C++ LSP
      #clang-tools # C/C++ LSP and code formatter
      #cppcheck # C/C++ code linter
      fd # Telescope finder
      nixfmt # Nix code formatter
      nodePackages.bash-language-server
      pyright # Python LSP
      nodePackages.typescript-language-server # Python LSP
      nodePackages."@tailwindcss/language-server" # tailwindcss plugin 
      nodePackages.vscode-langservers-extracted #lsp servers for json, html, css
      # rnix-lsp # Nix LSP No longer maintained
      nil
      statix # Nix code linter
      stylua # Lua code formatter
      sqls #sql language-server
      luajitPackages.luacheck # Lua linter
      sumneko-lua-language-server # Lua LSP
      texlab # LaTeX LSP
      tree-sitter # Incremental parser
      valgrind # Memory debugging
      python3Packages.flake8 # Python linter
      python3Packages.black # Python code formatter
    ];
    extraConfig = ''
      "vim settings
      set relativenumber
      set hlsearch
      set cursorline
      set cursorcolumn
      set nowrap
      "Keyboard shortcuts
      inoremap jk <ESC>
      inoremap <c-s> <Esc>:update<CR>
      noremap <c-s> :update<CR>

      "Keyboard shoutcut move lines up / down
      nnoremap <leader>j :m .+1<CR>==
      nnoremap <leader>k :m .-2<CR>==
      inoremap <C-j> <Esc>:m .+1<CR>==gi
      inoremap <C-k> <Esc>:m .-2<CR>==gi
      vnoremap K :m '<-2<CR>gv=gv
      vnoremap J :m '>+1<CR>gv=gv

      " Home-Manager and NixOS currently do not support a pure Lua config
      " without a generated init.vim containing the runtimepath and packpath,
      " so we explicitly load init.lua 
      lua require('init')
    '';
  };

  # Link the Neovim lua configuration to ~/.config/nvim
  home.file.".config/nvim/lua".source = ./lua;
}

