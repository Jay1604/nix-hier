{ input, config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland/default.nix
    ../../modules/home-manager/browser/zen.nix
    ../../modules/home-manager/cli/cli_tools.nix
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
    whatsie
    element-desktop
    signal-desktop
    telegram-desktop  
    pandoc
    tor-browser-bundle-bin
    filezilla
    usbimager
    gimp

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.de_DE
    vlc
  ];

  home.sessionVariables = {
    #EDITOR = "code";
    FLAKE = "/home/jay/nixos-config";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING=1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
