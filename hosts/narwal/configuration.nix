{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../mod/nixos/main-user.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-6b427175-7d47-4355-9eb2-4623e758b462".device = "/dev/disk/by-uuid/6b427175-7d47-4355-9eb2-4623e758b462";

  boot.plymouth = {
    enable = true;
    themePackages = [pkgs.plymouth-blahaj-theme];
    theme = "blahaj";
  };

  boot.initrd.systemd.enable = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  boot.loader.timeout = 0;
  boot.kernel.sysctl."kernel.sysrq" = 1;
  
  security.pam.services.swaylock = {};
  #security.pam.services.login.enableGnomeKeyRing = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "narwal";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Display Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Enable acpid
  services.acpid.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  main-user.enable = true;
  main-user.userName = "jay";

  users.users.jay = {
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.user.password;
    extraGroups = [ "audio" "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  home-manager = {
    # also inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jay" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install YubiKey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.gnome.gnome-keyring.enable = true;
  
  environment.systemPackages = with pkgs; [
    tree
    nh
    nix-output-monitor
    nvd
    wget
    cacert
    vesktop
    home-manager
    openssl 
    alejandra
    nixd 
    steam
    nvidia-vaapi-driver
    egl-wayland
    outputs.packages."${pkgs.stdenv.system}".nixvim
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  system.stateVersion = "24.05";

}
