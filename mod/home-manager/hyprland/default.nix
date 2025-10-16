{ inputs, pkgs, lib, config, ... }:

with lib;
let
 sharedModules = builtins.fromJSON (builtins.readFile ./waybar/config.json);
in {
	home.packages = with pkgs; [
	    wofi 
			swaybg 
			wl-clipboard  
			waybar
			wlinhibit
      brightnessctl
      wlr-randr
      wlogout
      xdg-desktop-portal-hyprland
      playerctl
      pamixer
      waybar
      mako
      nwg-look
      grim
      slurp
	];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  services.mako = {
    enable = true;

    settings = {
      defaultTimeout = 5000;
      width = 400;

      "urgency.high.layer" = "overlay";
      "urgency.high.default-timeout" = 0;
      "urgency.high.ignore-timeout" = true;

      "mode.do-not-disturb.urgency.low.invisible" = true;
      "mode.do-not-disturb.urgency.normal.invisible" = true;
      "mode.shut-up.invisible" = true;   
    };
  };

  programs.rofi = {
    enable = true;

    plugins = with pkgs; [
      (rofi-calc.override {
        rofi-unwrapped = rofi-unwrapped;
      })
    ];

    extraConfig = {
      normalize-match = true;
      show-icons = true;
    };

    theme = "Monokai";
  };

	programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        mod = "dock";
        margin-top = 3;
        modules-center = [ "hyprland/workspaces" ];
        modules-left = [
          "clock"
        ];
        modules-right = [
          "tray"
          "cpu"
          "temperature"
          "memory"
          "custom/wlinhibit"
          "pulseaudio"
          "pulseaudio#microphone"
        ];
      }
      // sharedModules;
    };
  };
  
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "20x3";
      clock = true;
      ignore-empty-password = true;
      daemonize = true;
      show-failed-attempts = true;
      screenshots = true;
    };
  };
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "lock";
        command = "${config.programs.swaylock.package}/bin/swaylock";
      }
      {
        event = "before-sleep";
        command = "${config.programs.swaylock.package}/bin/swaylock; ${pkgs.playerctl}/bin/playerctl pause";
      }
    ];
  };

  home.file.".config/wofi.css".source = ./wofi.css;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;
	home.file.".config/waybar/scripts".source = ./waybar/scripts;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
}
