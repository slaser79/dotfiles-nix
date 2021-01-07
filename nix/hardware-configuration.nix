{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = [ ];
    };
    kernelModules = [
      "kvm-intel"
      "acpi_call"
    ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    kernelParams = [ "acpi_backlight=native" ];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = lib.optionals (!config.hardware.enableRedistributableFirmware) [
      "ath3k"
    ];
  };
  environment.systemPackages = with pkgs; [ alsa-firmware] ;
  services = {
    tlp.enable = lib.mkDefault true;
    xserver.libinput.enable = true;
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2718dc21-5e42-4821-9314-0fc43604bc6f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E5BB-8B46";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/0bb94192-d620-472f-895a-e4024527a1b5"; }
    ];

  networking = {
    networkmanager.enable = true;
    hostName = "t14";
  };
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}