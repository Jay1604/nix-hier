{config,...}:

{
  networking.hostName = "orca"; # Define your hostname.
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;

  sops.secrets.wpa = {
    sopsFile = ../../secrets/wifi_passwords.conf;
    format = "binary";
  };

  # Enable networking
  services.connman.enable = true;

  # networking.nameservers = ["194.242.2.2" "9.9.9.9"];
  networking.networkmanager.dns = "systemd-resolved";
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  networking.wireless.secretsFile = config.sops.secrets.wpa.path; 
  
  networking.wireless.networks = {
    WIFIonICE = {

    };

    "msg-internet" = {
      auth = ''
      key_mgmt=WPA-EAP
      eap=PEAP
      phase2="auth=MSCHAPV2"
      identity="niebij"
      password=ext:msgPassword
      '';
      priority = 10;
    };

    "MELIA-Berlin" ={

    };

    BBHOTELSGuest = {

    };
    
    "38C3-open" = {
      
    };

    "38C3" = {
      auth = ''
        key_mgmt=WPA-EAP
        eap=TTLS
        identity="38C3"
        password="38C3"
        ca_cert="${builtins.fetchurl {
          url = "https://letsencrypt.org/certs/isrgrootx1.pem";
          sha256 = "sha256:1la36n2f31j9s03v847ig6ny9lr875q3g7smnq33dcsmf2i5gd92";
        }}"
        altsubject_match="DNS:radius.c3noc.net"
        phase2="auth=PAP"
      '';
    };

    "r" = {
      pskRaw = ext:r;
    };

    "mobilis pyxis telephonum" = {
      pskRaw = ext:julis;
    };
    wal = {
      pskRaw = ext:wal;
      priority = 11;
    };
    "HHUD-Y" = {
      pskRaw = ext:hhudy;
      priority = 10;
    };
    "WLAN-756Q9M" = {
      pskRaw = ext:andrea;
    };
    "FritzBox 7490" = {
      pskRaw = ext:zuhause;
    };    
  };

}