{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "slaser79";
    userEmail = "slaser79@hotmail.com";
    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      diff.tool = "nvimdiff";
      diff.colorMoved = "zebra";
      difftool.prompt = false;
      difftool.trustExitCode = true;
      merge.tool = "ediff";
      merge.keepBackup = false;
      merge.conflictStyle = "diff3";
      mergetool.keepBackup = false;
      mergetool.trustExitCode = true;
      github.user = "slaser79";
      color.ui = true;
      fetch.prune = true;
      pull.rebase = true;
      push.default = "upstream";
      credential = {
        helper = "store"; 
        "https://github.com".username  = "slaser79"; 
      };
    };
    ignores = [
      "\#*\#"
      ".\#*"
      "*.local"
      "TAGS"
      "tags"
      "*.iml"
      "*.ipr"
      "*.iws"
      ".idea/"
      ".gradle"
      "build/"
      "repos/"
      "*.class"
      "target"
      "target/"
      ".metadata"
      ".cache"
      ".worksheet"
      "*.class"
      ".eunit"
      "deps"
      "*.o"
      "*.beam"
      "*.plt"
      "erl_crash.dump"
      "ebin"
      "rel/example_project"
      ".concrete/DEV_MODE"
      ".rebar"
      "_build/"
      "*~"
      "*.swp"
      "*.swo"
      "__MACOSX/"
      "*.DS_Store"
      ".elasticbeanstalk/*"
      "!.elasticbeanstalk/*.cfg.yml"
      "!.elasticbeanstalk/*.global.yml"
      "ist"
      "dist-*"
      "cabal-dev"
      "*.o"
      "*.hi"
      "*.chi"
      "*.chs.h"
      "*.dyn_o"
      "*.dyn_hi"
      ".hpc"
      ".hsenv"
      ".cabal-sandbox/"
      "cabal.sandbox.config"
      "*.prof"
      "*.aux"
      "*.hp"
      "*.eventlog"
      ".stack-work/"
      "cabal.project.local"
      "cabal.project.local~"
      ".HTF/"
      ".ghc.environment.*"
      "__pycache__/"
      "*.py[cod]"
      "*$py.class"
      "pyrightconfig.json"
      "*.so"
      ".Python"
      "build/"
      "develop-eggs/"
      "dist/"
      "downloads/"
      "eggs/"
      ".eggs/"
      "lib64/"
      "parts/"
      "sdist/"
      "var/"
      "wheels/"
      "share/python-wheels/"
      "*.egg-info/"
      ".installed.cfg"
      "*.egg"
      "MANIFEST"
      "*.manifest"
      "*.spec"
      "pip-log.txt"
      "pip-delete-this-directory.txt"
      "htmlcov/"
      ".tox/"
      ".nox/"
      ".coverage"
      ".coverage.*"
      ".cache"
      "nosetests.xml"
      "coverage.xml"
      "*.cover"
      "*.py,cover"
      ".hypothesis/"
      ".pytest_cache/"
      "cover/"
      "*.mo"
      "*.pot"
      "*.log"
      "local_settings.py"
      "db.sqlite3"
      "db.sqlite3-journal"
      "instance/"
      ".webassets-cache"
      ".scrapy"
      "docs/_build/"
      ".pybuilder/"
      "target/"
      ".ipynb_checkpoints"
      "profile_default/"
      "ipython_config.py"
      "__pypackages__/"
      "celerybeat-schedule"
      "celerybeat.pid"
      "*.sage.py"
      ".env"
      ".venv"
      "env/"
      "venv/"
      "ENV/"
      "env.bak/"
      "venv.bak/"
      ".spyderproject"
      ".spyproject"
      ".ropeproject"
      "/site"
      ".mypy_cache/"
      ".dmypy.json"
      "dmypy.json"
      ".pyre/"
      ".pytype/"
      "cython_debug/"
      ".env_vars"
      ".direnv/"
      ".dir-locals.el"
      ".projectile"
      "elm-stuff"
      "repl-temp-*"
    ];
  };
}
