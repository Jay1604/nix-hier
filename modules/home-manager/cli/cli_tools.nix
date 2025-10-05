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
    seahorse
    hdparm
    bonnie
    lshw
    openldap
    pywal16
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
      light_dark = "dark";
      lightness = 0.75;
      color_align = {
        mode = "horizontal";
        custom_colors = [];
        fore_back = null;
      };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_shown = [];
      pride_month_disable = false;
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
    extraConfig =''
      set number relativenumber
      set background=dark
    '';
  };

  programs.nh = {
    enable = true;
    flake = "/home/jay/nixos-config";
    clean.enable = true;
    clean.extraArgs = "--keep-since 2d --keep 3";
  };
}