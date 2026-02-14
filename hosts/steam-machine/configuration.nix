{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    inputs.disko.nixosModules.default
    inputs.jovian.nixosModules.default

    ./disko.nix
    ./persistent.nix
    ./hardware-configuration.nix
  ];

  jovian = {
    hardware = {
      has.amd.gpu = true;
      amd.gpu.enableBacklightControl = false;
    };
    steam = {
      updater.splash = "vendor";
      enable = true;
      autoStart = true;
      user = "aaron";
      desktopSession = "plasma";
    };
    steamos = {
      useSteamOSConfig = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.initrd.systemd.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  programs.xwayland.enable = true;
  # services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aaron = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$9BVbJKhiRZ/U5iTL7sZtT/$3xUVDretSE/RqiacfJbu/vK0Li0H8Z/S4LESEj1E/u1";
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      git
      lazygit
      ncdu
      just
      tree
      btop
      fastfetch
      nvtopPackages.amd
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services'.openssh.enable = true;
  services'.firewall.enable = true;

  programs'.firefox.enable = true;
}
