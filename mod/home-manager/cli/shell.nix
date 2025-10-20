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
		rebuild = "git -C /home/jay/nixos-config add --all && nh os switch";
		cleanup = "nh clean all";
		gaa = "git add --all";
		vim = "nvim";
		vi = "nvim";
		enby = "man";
	};

	programs.kitty = lib.mkForce {
		enable = true;
		themeFile = "Argonaut";
		keybindings = {
			"ctrl+plus" = "change_font_size all +1.0";
			"ctrl+minus" = "change_font_size all -1.0";
		};
	};
}
