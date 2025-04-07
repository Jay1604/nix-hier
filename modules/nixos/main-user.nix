{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable
      = lib.mkEnableOption "enable user module";
    
    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username and description
      '';
    };
  };

  config = lib.mkIf config.main-user.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "12345";
      description = "${cfg.userName}";
    };
  };
}
