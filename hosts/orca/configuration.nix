{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../mod/nixos/main-user.nix
      inputs.home-manager.nixosModules.default
      ../../mod/nixos/eduroam.nix
      ../../mod/nixos/networking.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    themePackages = [pkgs.plymouth-blahaj-theme];
    theme = "blahaj";
  };

  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  boot.initrd.systemd.enable = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  boot.loader.timeout = 0;
  boot.kernel.sysctl."kernel.sysrq" = 1;

  boot.initrd.luks.devices."luks-f93ac02c-14ba-40c3-9354-87b2fb0a5690".device = "/dev/disk/by-uuid/f93ac02c-14ba-40c3-9354-87b2fb0a5690";
  boot.initrd.luks.devices."luks-81c01fe0-5db7-41f5-bd83-ff66a9243c72".device = "/dev/disk/by-uuid/81c01fe0-5db7-41f5-bd83-ff66a9243c72";

  sops.age.keyFile = "/home/jay/.config/sops/age/keys.txt";
  
  security.pam.services.swaylock = {};
  #security.pam.services.login.enableGnomeKeyRing = true;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

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

  programs.hyprland.enable = true;


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

  # Install NVIDIA drivers
  hardware.nvidia.package = pkgs.linuxKernel.packages.linux_6_6.nvidia_x11;
  hardware.nvidia.modesetting.enable = true;
  
  services.xserver.dpi = 110;
  environment.variables = { GDK_SCALE = "0.3"; };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  main-user.enable = true;
  main-user.userName = "jay";

  users.users.jay = {
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.user.password;
    extraGroups = [ "networkmanager" "wheel" ];
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

  # Bluetooth settings
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  systemd.user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # Install YubiKey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
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
    nvidia-docker
    steam
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
