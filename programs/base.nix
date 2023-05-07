{ config, lib, pkgs, ... }:

with lib;
{
  options.globals = {
    isWsl      = mkOption { type = types.bool; default = builtins.getEnv "WSL_DISTRO_NAME" != ""; };
    WslDistro  = mkOption { type = types.str; default = "Alpine"; };

    isNixos    = mkOption { type = types.bool; default = builtins.pathExists /etc/NIXOS; };

    username   = mkOption { type = types.str; default = "slaser79"; };
    nixProfile = mkOption { type = types.str; default =  "/home/${config.globals.username}/.nix-profile"; };
    localBin   = mkOption { type = types.str; default =  "/home/${config.globals.username}/.local/bin"; };
  };

}
