{config, ...}:

{
  sops.secrets.fffVPN = {
    sopsFile = ../../secrets/fffVPN.conf;
    format = "binary";
  };

  sops.secrets.fffVPN_config = {
    sopsFile = ../../secrets/fffVPN-config;
    format = "binary";
  };

  sops.secrets.HHU_VPN_config = {
    sopsFile = ../../secrets/HHU-VPN;
    format = "binary";
  };

  services.openvpn.servers = {
    fffVPN = {
      config = ''config /etc/openvpn/fffVPN.ovpn'';
      authUserPass = "/etc/openvpn/fffVPN.conf";
      autoStart = false;
      updateResolvConf = true;
    };
    HHUVPN = { 
      config = ''config /etc/openvpn/HHU-VPN.ovpn'';
      autoStart = false;
    };
  };

  environment.etc."openvpn/fffVPN.conf".source = config.sops.secrets.fffVPN.path;
  environment.etc."openvpn/fffVPN.ovpn".source = config.sops.secrets.fffVPN_config.path;
  environment.etc."openvpn/HHU-VPN.ovpn".source = config.sops.secrets.HHU_VPN_config.path;
}