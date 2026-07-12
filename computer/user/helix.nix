{ config, pkgs, ... }: 

{
  programs.helix = with pkgs; {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      bash-language-server
      biome
      clang-tools
      docker-compose-language-service
      dockerfile-language-server
      golangci-lint
      golangci-lint-langserver
      gopls
      gotools
      hongdown
      marksman
      nil
      nixd
      nixpkgs-fmt
      prettier
      typescript-language-server
      sql-formatter
      ruff
      (python3.withPackages (
        p:
        (with p; [
          python-lsp-ruff
          python-lsp-server
        ])
      ))
      rust-analyzer
      tailwindcss-language-server
      taplo
      terraform-ls
      typescript
      vscode-langservers-extracted
      yaml-language-server
    ];

    themes = {
      prompt_theme = {
        inherits = "base16_default_dark";
        palette = {
          base00 = "#1d1f21";
          base01 = "#282a2e";
          base02 = "#373b41";
          base03 = "#6c6c6c"; # prompt grey
          base04 = "#b4b7b4";
          base05 = "#c5c8c6";
          base06 = "#e0e0e0";
          base07 = "#ffffff";
          base08 = "#3971ed"; # prompt blue for variables
          base09 = "#fba922"; # prompt yellow for constants
          base0A = "#fba922"; # prompt yellow for types
          base0B = "#fba922"; # prompt yellow for strings
          base0C = "#3971ed"; # prompt blue/cyan
          base0D = "#3971ed"; # prompt blue for functions
          base0E = "#a36ac7"; # prompt magenta for keywords
          base0F = "#cc342b"; # prompt red for errors
        };
        "ui.background" = { };
        "ui.statusline.normal" = { fg = "base0E"; bg = "base01"; modifiers = [ "bold" ]; };
        "ui.statusline.insert" = { fg = "base08"; bg = "base01"; modifiers = [ "bold" ]; };
        "ui.statusline.select" = { fg = "base09"; bg = "base01"; modifiers = [ "bold" ]; };
        "ui.linenr.selected" = { fg = "base0E"; bg = "base01"; modifiers = [ "bold" ]; };
      };
    };

    settings = {
      theme = "prompt_theme";
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
          mode.normal = "";
          mode.insert = "I";
          mode.select = "S";
        };
      };

      keys = {
        normal = {
          H = "extend_char_left";
          x = "extend_to_line_bounds";
          J = [
            "extend_line_down"
            "extend_to_line_bounds"
          ];
          K = [
            "extend_line_up"
            "extend_to_line_bounds"
          ];
          L = "extend_char_right";
          B = "extend_prev_word_start";
          W = "extend_next_word_start";
          E = "extend_next_word_end";
          A-b = "move_prev_long_word_start";
          A-B = "extend_prev_long_word_start";
          A-w = "move_next_long_word_start";
          A-W = "extend_next_long_word_start";
          A-e = "move_next_long_word_end";
          A-E = "extend_next_long_word_end";
          T = "extend_till_char";
          F = "extend_next_char";
          A-t = "till_prev_char";
          A-f = "find_prev_char";
          A-T = "extend_till_prev_char";
          A-F = "extend_prev_char";
          A-j = "join_selections";
          A-k = "keep_selections";
          M = [
            "select_mode"
            "match_brackets"
            "normal_mode"
          ];
          "#" = "toggle_comments";
          A-l = "extend_to_line_end";
          A-h = "extend_to_line_start";
          left = "goto_previous_buffer";
          right = "goto_next_buffer";
          A-d = "delete_selection";
          c = "change_selection_noyank";
          d = "delete_selection_noyank";
          N = "extend_search_next";
          A-n = "search_prev";
          A-N = "extend_search_prev";
          C-d = [
            "page_cursor_half_down"
            "align_view_center"
          ];
          C-u = [
            "page_cursor_half_up"
            "align_view_center"
          ];
          C-j = [
            "extend_to_line_bounds"
            "delete_selection"
            "paste_after"
          ];
          C-k = [
            "extend_to_line_bounds"
            "delete_selection"
            "move_line_up"
            "paste_before"
          ];
          tab = "move_parent_node_end";
          S-tab = "move_parent_node_start";

          G = {
            j = "@vgj<esc>";
            k = "@vgk<esc>";
          };

          g = {
            j = "goto_last_line";
            k = "goto_file_start";
          };

          space = {
            c = ":buffer-close";
            A-f = ":toggle auto-format";
            q = ":write-quit-all";
            Q = ":quit!";
            w = ":write";
            "." = ":toggle file-picker.git-ignore";
          };
        };

        insert = {
          C-u = [
            "extend_to_line_bounds"
            "delete_selection_noyank"
            "open_above"
          ];
          C-w = [
            "move_prev_word_start"
            "delete_selection_noyank"
          ];
          C-space = "completion";
          S-tab = "move_parent_node_start";
        };

        select = {
          tab = "extend_parent_node_end";
          S-tab = "extend_parent_node_start";

          g = {
            j = "goto_last_line";
            k = "goto_file_start";
          };
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

      language-server.yaml-language-server.config.yaml.schemas = {
        kubernetes = "k8s/*.yaml";
      };

      language-server.typescript-language-server.config.tsserver = {
        path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
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
          name = "go";
          language-servers = [
            "gopls"
            "golangci-lint-lsp"
          ];
          formatter = {
            command = "goimports";
          };
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
          name = "jsonc";
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
          file-types = [
            "jsonc"
            "hujson"
          ];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "tailwindcss-ls"
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
          name = "python";
          language-servers = [ "pylsp" ];
          formatter = {
            command = "sh";
            args = [
              "-c"
              "ruff check --select I --fix - | ruff format --line-length 88 -"
            ];
          };
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
        }
        {
          name = "sql";
          formatter = {
            command = "sql-formatter";
            args = [
              "-l"
              "postgresql"
              "-c"
              "{\"keywordCase\": \"lower\", \"dataTypeCase\": \"lower\", \"functionCase\": \"lower\", \"expressionWidth\": 120, \"tabWidth\": 4}"
            ];
          };
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
          name = "tsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "tailwindcss-ls"
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
      ];
    };
  };
  stylix.targets.helix.enable = false;
}
