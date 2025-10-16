{inputs, pkgs, lib, config, ...}:

{
  sops.secrets.easyroam = {
    sopsFile = ../../secrets/eduroam;
    format = "binary";
    restartUnits = [ "easyroam-install.service" ];
  };

  services.easyroam = {
    enable = true;
    pkcsFile = config.sops.secrets.easyroam.path; # or e.g. config.sops.secrets.easyroam.path
    # automatically configure wpa-supplicant (use this if you configure your networking via networking.wireless)
    wpa-supplicant = {
        enable = true;
    };
    
  };
}