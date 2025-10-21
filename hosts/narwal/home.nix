{ input, inputs, config, pkgs, lib, ... }:

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
    
    #programs
    hello
    thunderbird
    jetbrains.idea-ultimate
    vscode-fhs
    nextcloud-client
    element-desktop
    signal-desktop
    telegram-desktop  
    pandoc
    filezilla
    usbimager
    protonmail-bridge
    prismlauncher
    r2modman
    vintagestory
    firefox
    heroic
    linux-wallpaperengine
    protonup-qt
    atlauncher
    inputs.tidaLuna.packages.${system}.default
    ausweisapp
		ausweiskopie
		wine

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.de_DE
    hunspellDicts.en_US
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];


  home.sessionVariables = {
    #EDITOR = "code";
    FLAKE = "/home/jay/nix-hier";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONREPARENTING=1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
