{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;


}
