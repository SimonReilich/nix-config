{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.terminal.helix;

  mkLanguageOption =
    name: description:
    mkEnableOption "${description} language support in Helix";
in
{
  options.terminal.helix = {
    enable = mkEnableOption "Helix editor configuration";

    defaultEditor = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to set Helix as the default editor.";
    };

    languages = {
      bash = mkLanguageOption "bash" "Bash";
      c = mkLanguageOption "c" "C/C++ (clangd)";
      css = mkLanguageOption "css" "CSS";
      html = mkLanguageOption "html" "HTML";
      javascript = mkLanguageOption "javascript" "JavaScript";
      json = mkLanguageOption "json" "JSON";
      latex = mkLanguageOption "latex" "LaTeX (texlab)";
      markdown = mkLanguageOption "markdown" "Markdown";
      nix = mkLanguageOption "nix" "Nix";
      python = mkLanguageOption "python" "Python (ruff)";
      rust = mkLanguageOption "rust" "Rust (rust-analyzer)";
      terraform = mkLanguageOption "terraform" "Terraform";
      toml = mkLanguageOption "toml" "TOML";
      typescript = mkLanguageOption "typescript" "TypeScript";
      yaml = mkLanguageOption "yaml" "YAML";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.helix = {
        enable = true;
        defaultEditor = cfg.defaultEditor;

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
            "ui.statusline.normal" = {
              fg = "base0E";
              bg = "base01";
              modifiers = [ "bold" ];
            };
            "ui.statusline.insert" = {
              fg = "base08";
              bg = "base01";
              modifiers = [ "bold" ];
            };
            "ui.statusline.select" = {
              fg = "base09";
              bg = "base01";
              modifiers = [ "bold" ];
            };
            "ui.linenr.selected" = {
              fg = "base0E";
              bg = "base01";
              modifiers = [ "bold" ];
            };
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
      };

      stylix.targets.helix.enable = false;
    }

    # Bash
    (mkIf cfg.languages.bash {
      programs.helix = {
        extraPackages = [ pkgs.bash-language-server ];
        languages.language = [
          {
            name = "bash";
            language-servers = [ "bash-language-server" ];
            auto-format = true;
          }
        ];
      };
    })

    # C / C++
    (mkIf cfg.languages.c {
      programs.helix = {
        extraPackages = [ pkgs.clang-tools ];
        languages.language = [
          {
            name = "c";
            language-servers = [ "clangd" ];
          }
          {
            name = "cpp";
            language-servers = [ "clangd" ];
          }
        ];
      };
    })

    # CSS
    (mkIf cfg.languages.css {
      programs.helix = {
        extraPackages = with pkgs; [
          vscode-langservers-extracted
          tailwindcss-language-server
          biome
        ];
        languages = {
          language-server.biome = {
            command = "biome";
            args = [ "lsp-proxy" ];
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
          ];
        };
      };
    })

    # HTML
    (mkIf cfg.languages.html {
      programs.helix = {
        extraPackages = with pkgs; [
          vscode-langservers-extracted
          tailwindcss-language-server
          prettier
        ];
        languages.language = [
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
        ];
      };
    })

    # JavaScript
    (mkIf cfg.languages.javascript {
      programs.helix = {
        extraPackages = with pkgs; [
          typescript-language-server
          typescript
          biome
        ];
        languages = {
          language-server.biome = {
            command = "biome";
            args = [ "lsp-proxy" ];
          };
          language-server.typescript-language-server.config.tsserver = {
            path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
          };
          language = [
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
          ];
        };
      };
    })

    # JSON
    (mkIf cfg.languages.json {
      programs.helix = {
        extraPackages = with pkgs; [
          vscode-langservers-extracted
          biome
        ];
        languages = {
          language-server.biome = {
            command = "biome";
            args = [ "lsp-proxy" ];
          };
          language = [
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
          ];
        };
      };
    })

    # LaTeX
    (mkIf cfg.languages.latex {
      programs.helix = {
        extraPackages = [ pkgs.texlab ];
        languages = {
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
              name = "latex";
              language-servers = [ "texlab" ];
            }
          ];
        };
      };
    })

    # Markdown
    (mkIf cfg.languages.markdown {
      programs.helix = {
        extraPackages = with pkgs; [
          marksman
          hongdown
        ];
        languages.language = [
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
        ];
      };
    })

    # Nix
    (mkIf cfg.languages.nix {
      programs.helix = {
        extraPackages = with pkgs; [
          nil
          nixd
          nixpkgs-fmt
        ];
        languages.language = [
          {
            name = "nix";
            formatter = {
              command = "nixpkgs-fmt";
            };
            auto-format = true;
          }
        ];
      };
    })

    # Python
    (mkIf cfg.languages.python {
      programs.helix = {
        extraPackages = [ pkgs.ruff ];
        languages.language = [
          {
            name = "python";
            language-servers = [ "ruff" ];
            formatter = {
              command = "ruff";
              args = [
                "format"
                "-"
              ];
            };
            auto-format = true;
          }
        ];
      };
    })

    # Rust
    (mkIf cfg.languages.rust {
      programs.helix = {
        extraPackages = [ pkgs.rust-analyzer ];
        languages = {
          language-server.rust-analyzer.config.check = {
            command = "clippy";
          };
          language = [
            {
              name = "rust";
              language-servers = [ "rust-analyzer" ];
              auto-format = true;
            }
          ];
        };
      };
    })

    # Terraform
    (mkIf cfg.languages.terraform {
      programs.helix = {
        extraPackages = [ pkgs.terraform-ls ];
        languages.language = [
          {
            name = "terraform";
            language-servers = [ "terraform-ls" ];
            auto-format = true;
          }
        ];
      };
    })

    # TOML
    (mkIf cfg.languages.toml {
      programs.helix = {
        extraPackages = [ pkgs.taplo ];
        languages.language = [
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
        ];
      };
    })

    # TypeScript
    (mkIf cfg.languages.typescript {
      programs.helix = {
        extraPackages = with pkgs; [
          typescript-language-server
          typescript
          biome
        ];
        languages = {
          language-server.biome = {
            command = "biome";
            args = [ "lsp-proxy" ];
          };
          language-server.typescript-language-server.config.tsserver = {
            path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
          };
          language = [
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
          ];
        };
      };
    })

    # YAML
    (mkIf cfg.languages.yaml {
      programs.helix = {
        extraPackages = with pkgs; [
          yaml-language-server
          prettier
        ];
        languages.language = [
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
    })
  ]);
}
