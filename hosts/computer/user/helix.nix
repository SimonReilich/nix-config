{ config, pkgs, ... }: 

{
  programs.helix = with pkgs; {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      bash-language-server
      biome
      clang-tools
      hongdown
      marksman
      nil
      nixd
      nixpkgs-fmt
      prettier
      typescript-language-server
      ruff
      rust-analyzer
      tailwindcss-language-server
      taplo
      terraform-ls
      typescript
      vscode-langservers-extracted
      yaml-language-server
      texlab
    ];

    themes = {
      my_theme = {
        inherits = "base16_default_dark";
        palette = {
          base00 = "#1d1f21";
          base01 = "#282a2e";
          base02 = "#373b41";
          base03 = "#6c6c6c"; 
          base04 = "#b4b7b4";
          base05 = "#c5c8c6";
          base06 = "#e0e0e0";
          base07 = "#ffffff";
          base08 = "#3971ed"; 
          base09 = "#fba922"; 
          base0A = "#fba922"; 
          base0B = "#fba922"; 
          base0C = "#3971ed"; 
          base0D = "#3971ed"; 
          base0E = "#a36ac7"; 
          base0F = "#cc342b"; 
        };
        "ui.background" = { };
        "ui.statusline.normal" = { fg = "base0E"; bg = "base01"; modifiers = [ "bold" ]; };
        "ui.statusline.insert" = { fg = "base08"; bg = "base01"; modifiers = [ "bold" ]; };
        "ui.statusline.select" = { fg = "base09"; bg = "base01"; modifiers = [ "bold" ]; };
        "ui.linenr.selected" = { fg = "base0E"; bg = "base01"; modifiers = [ "bold" ]; };
      };
    };

    settings = {
      theme = "my_theme";
      editor = {
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";

        soft-wrap.enable = true;

        auto-save = {
          focus-lost = true;
          after-delay.enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          ignore = false;
        };

        indent-guides = {
          character = "┊";
          render = true;
          skip-levels = 1;
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };

        statusline = {
          left = [
            "mode"
            "file-name"
            "spinner"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "file-type"
            "file-line-ending"
            "position"
          ];
          mode.normal = "󰆾";
          mode.insert = "󰏫";
          mode.select = "󰒉";
        };
      };
    };

    languages = {
      language-server.biome = {
        command = "biome";
        args = [ "lsp-proxy" ];
      };

      language-server.rust-analyzer.config.check = {
        command = "clippy";
      };

      language-server.typescript-language-server.config.tsserver = {
        path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
      };

      language-server.texlab = {
        config = {
          latex = {
            build = {
              onSave = true;
              executable = "latexmk";
              args = [ 
                "-lualatex"
                "-shell-escape" 
                "-interaction=nonstopmode"
                "-synctex=1"
                "%f" 
              ];
            };
          };
        };
      };

      language = [
        {
          name = "css";
          language-servers = [
            "vscode-css-language-server"
            "tailwindcss-ls"
            "biome"
          ];
          auto-format = true;
        }

        {
          name = "html";
          language-servers = [
            "vscode-html-language-server"
            "tailwindcss-ls"
          ];
          formatter = {
            command = "prettier";
            args = [
              "--stdin-filepath"
              "%{buffer_name}"
            ];
          };
          auto-format = true;
        }
        
        {
          name = "javascript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"

          ];
          auto-format = true;
        }
        
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--indent-style"
              "space"
              "--stdin-file-path"
              "%{buffer_name}"
            ];
          };
          auto-format = true;
        }

        {
          name = "markdown";
          language-servers = [ "marksman" ];
          formatter = {
            command = "hongdown";
            args = [
              "--line-width=120"
              "--stdin"
            ];
          };
          auto-format = true;
        }
        
        {
          name = "nix";
          formatter = {
            command = "nixpkgs-fmt";
          };
          auto-format = true;
        }
        
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
        }

        {
          name = "toml";
          language-servers = [ "taplo" ];
          formatter = {
            command = "taplo";
            args = [
              "fmt"
              "-o"
              "column_width=120"
              "-"
            ];
          };
          auto-format = true;
        }

        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"

          ];
          formatter = {
            command = "biome";
            args = [
              "format"
              "--indent-style"
              "space"
              "--stdin-file-path"
              "%{buffer_name}"
            ];
          };
          auto-format = true;
        }
        
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
          formatter = {
            command = "prettier";
            args = [
              "--stdin-filepath"
              "%{buffer_name}"
            ];
          };
          auto-format = true;
        }

        {
          name = "latex";
          language-servers = [ "texlab" ];
        }
      ];
    };
  };
  stylix.targets.helix.enable = false;
}
