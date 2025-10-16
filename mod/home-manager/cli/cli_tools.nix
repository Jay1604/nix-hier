{pkgs, ...}:

{

  imports = [
    ./shell.nix
  ];

  home.packages = with pkgs; [
    htop
    wev
    curl
    zip
    killall
    sops
    unzip
    libnotify
    swig
    yubikey-manager
    wl-clipboard
    gcr
    seahorse
    hdparm
    bonnie
  ];

  programs.git = {
    enable = true;
    userName = "Jay1604";
    userEmail = "jay@niebisch.me";
    extraConfig = {
      init.defaultBranch = "main";
    };  
  };

  programs.hyfetch = {
    enable = false;
    settings = {
      preset = "transgender";
      mode = "rgb";
      auto_detect_light_dark = true;
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
      };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_disable = false;
    };
  };

  programs.nh = {
    enable = true;
    flake = "/home/jay/nixos-config";
    clean.enable = true;
    clean.extraArgs = "--keep-since 2d --keep 3";
  };
}
