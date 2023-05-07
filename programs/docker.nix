{ config, lib, pkgs, ... }:

with lib;
{
  options.modules.docker = {
    enable = mkOption { type = types.bool; default = false; };
  };

  config = mkIf config.modules.docker.enable {
    home.packages = [
      pkgs.docker
      pkgs.docker-compose
      pkgs.daemonize 
    ];

    home.file.".local/bin/service-docker" = {
      executable = true;
      text = ''
        #!/bin/sh
        # service-docker    Docker daemon management for WSL distros. Uses `wsl.exe` for privelege escalation. Ensure environment variables set before
        case "$1" in
          start)
            wsl.exe -u root -d ${config.globals.WslDistro} -e nohup ${config.globals.nixProfile}/bin/daemonize ${config.globals.nixProfile}/bin/dockerd &> /dev/null
            ;;

          stop)
            wsl.exe -u root -d Alpine -e killall dockerd &> /dev/null
            ;;

          restart)
            ./$0 stop && ./$0 start
            ;;

          status)
            pidof dockerd &> /dev/null && echo "docker daemon running" || echo "docker daemon not running"
            ;;

          *)
            echo "Usage:"
            echo "  $1 (start | stop | restart | status)"
            ;;
        esac
      '';
    };


    # TODO: fix this when next using NixOS
    # virtualisation.docker = mkIf config.globals.isNixos {
    #   enable = true;
    #   enableOnBoot = true;
    # };
  };
}
