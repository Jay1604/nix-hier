{pkgs, ...}:

{

  plugins = {
    treesitter = {
      enable = true;
      settings = {
        auto_install = true;
				highlight.enable = true;
      };
    };
    lsp.servers.nixd = {
      enable = true;
      settings.formatting.command = [ "nixfmt" ];
    };
		telescope = {
		  enable = true;
			keymaps = {
			  "<leader>ff" = "find_files";
  			"<leader>fs" = "live_grep";
				"<leader>fg" = "git_files";
			};
		};
		yazi.enable = true;
 		cmp =
		  let
      	border = [
        	"╭"
        	"─"
        	"╮"
        	"│"
        	"╯"
        	"─"
        	"╰"
        	"│"
      	];
    	in
    	{
				enable = true;
				autoEnableSources = true;
				settings = {
					sources = [
						{
							name = "nvim_lsp";
						}
						{
							name = "luasnip";
						}
						{
							name = "path";
						}
						{
					  	name = "buffer";
						}
						{
					  	name = "copilot";
						}
					];
					mapping = {
						"<C-d>" = "cmp.mapping.scroll_docs(-4)";
						"<C-e>" = "cmp.mapping.close()";
						"<C-f>" = "cmp.mapping.scroll_docs(4)";
						"<CR>" = "cmp.mapping.confirm({ select = true })";
						"<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
						"<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
					};
					window.completion.border = border;
					window.documentation.border = border;
				};
			};
		
		copilot-cmp = {
			enable = true;
			event = [
				"InsertEnter"
				"LspAttach"
			];
		};

		cmp-treesitter.enable = true;
		lsp-lines.enable = true;
		nvim-surround.enable = true;
    lazygit.enable = true;
	};

	keymaps = [
    {
      action = "<cmd>Yazi<CR>";
      key = "<leader>fv";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope lsp_definitions<CR>";
      key = "<leader>gd";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      key = "<leader>ha";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      key = "<leader>ca";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>lua require(\"lsp_lines\").toggle()<CR>";
      key = "<leader>ol";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>Telescope diagnostics<CR>";
      key = "<leader>di";
      options = {
        silent = true;
      };
    }
  ];

  colorschemes.dracula.enable = true;
	
  extraPackages = [
    pkgs.nixfmt-rfc-style
		pkgs.gcc
		pkgs.ripgrep
  ];

  opts = {
		number = true;
		relativenumber = true;
		undofile = true;
    shiftwidth = 2;
    tabstop = 2;
  };

	globals = {
	  mapleader = " ";
	};
}
