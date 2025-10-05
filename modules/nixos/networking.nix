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
  networking.nameservers = ["9.9.9.9"];

  networking.wireless.secretsFile = config.sops.secrets.wpa.path; 

  networking.wireless.networks = {
    WIFIonICE = {};

    "IKEA WiFi" = {};

    c4 = {};

    Vodafone-0EE6 = {
      pskRaw = "ext:tante";
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

    "MELIA-Berlin" ={};

    BBHOTELSGuest = {};

    "r" = {
      pskRaw = "ext:r";
    };

    "mobilis pyxis telephonum" = {
      pskRaw = "ext:julis";
    };
    wal = {
      pskRaw = "ext:wal";
      priority = 11;
    };
    "HHUD-Y" = {
      pskRaw = "ext:hhudy";
      priority = 10;
    };
    "WLAN-756Q9M" = {
      pskRaw = "ext:andrea";
    };
    "FritzBox 7490" = {
      pskRaw = "ext:zuhause";
    };    
  };

}