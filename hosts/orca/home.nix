{ input, config, pkgs, lib, ... }:

{
  imports = [
    ../../mod/home-manager/hyprland/default.nix
    ../../mod/home-manager/browser/zen.nix
    ../../mod/home-manager/cli/cli_tools.nix
  ];

  home.username = "jay";
  home.homeDirectory = "/home/jay";

  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    #Languages
    nodejs
    python3
    texliveFull
    jdk
    
    #programs
    hello
    thunderbird
    jetbrains.idea-ultimate
    vscode-fhs
    tidal-hifi
    nextcloud-client
    prismlauncher
    whatsapp-for-linux
    element-desktop
    signal-desktop
    telegram-desktop  
    pandoc
    tor-browser-bundle-bin
    filezilla
    usbimager
    (pkgs.discord.override {
     # withOpenASAR = true;
      withVencord = true;
    })
    gimp

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.de_DE
  ];

  services.gnome-keyring.enable = true;


  home.sessionVariables = {
    #EDITOR = "code";
    FLAKE = "/home/jay/nixos-config";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING=1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
