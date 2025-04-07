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
}