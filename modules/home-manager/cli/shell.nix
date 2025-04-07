{pkgs, lib, ...}:

{
    home.packages = with pkgs; [
      kitty
    ];

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellInit = ''
        ${pkgs.hyfetch}/bin/hyfetch
      '';
    };

    home.shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      uu = "nh os switch -u";
      nixconfig = "sudoedit /home/jay/nixos-config/hosts/orca/configuration.nix";
      nixhome = "sudoedit /home/jay/nixos-config/hosts/orca/home.nix";
      rebuild = "git -C /home/jay/nixos-config add --all && nh os switch";
      cleanup = "sudo nix-collect-garbage";
      gaa = "git add --all";
    };

    programs.kitty = lib.mkForce {
    enable = true;
    themeFile = "Argonaut";
    keybindings = {
      "ctrl+plus" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
    };

    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 10;
      background_opacity = "0.5";
      background_blur = 5;
      symbol_map = let
        mappings = [
          "U+23FB-U+23FE"
          "U+2B58"
          "U+E200-U+E2A9"
          "U+E0A0-U+E0A3"
          "U+E0B0-U+E0BF"
          "U+E0C0-U+E0C8"
          "U+E0CC-U+E0CF"
          "U+E0D0-U+E0D2"
          "U+E0D4"
          "U+E700-U+E7C5"
          "U+F000-U+F2E0"
          "U+2665"
          "U+26A1"
          "U+F400-U+F4A8"
          "U+F67C"
          "U+E000-U+E00A"
          "U+F300-U+F313"
          "U+E5FA-U+E62B"
        ];
      in
        (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
    };
  };

}