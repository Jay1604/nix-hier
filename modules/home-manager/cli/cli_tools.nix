{pkgs, ...}:

{

  imports = [
    ./shell.nix
  ];

  home.packages = with pkgs; [
    htop
    wev
    curl
    git
    zip
    killall
    hyfetch
    sops
    unzip
    libnotify
    swig
    yubikey-manager
    wl-clipboard
    gcr
    seahorse
    vim
    hdparm
    bonnie
  ];

  programs.git = {
    enable = true;
    userName = "Jay1604";
    userEmail = "example@example.com";
    extraConfig = {
      init.defaultBranch = "main";
    };  
  };

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.nh = {
    enable = true;
    flake = "/home/jay/nixos-config";
    clean.enable = true;
    clean.extraArgs = "--keep-since 2d --keep 3";
  };
}