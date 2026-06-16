{ config, pkgs, ... }:

{
  programs.vscodium = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        angular.ng-template
        astro-build.astro-vscode
        bbenoist.nix
        brettm12345.nixfmt-vscode
        github.vscode-github-actions
        haskell.haskell
        james-yu.latex-workshop
        jnoortheen.nix-ide
        justusadam.language-haskell
        mkhl.direnv
        myriad-dreamin.tinymist
        ocamllabs.ocaml-platform
        piousdeer.adwaita-theme
        redhat.java
        rust-lang.rust-analyzer
        streetsidesoftware.code-spell-checker
        streetsidesoftware.code-spell-checker-german
        usernamehw.errorlens
        vue.volar
      ];
      userSettings = {
        "chat.agent.enabled" = false;
        "chat.disableAIFeatures" = true;
        "chat.editor.fontFamily" = "JetBrainsMono Nerd Font";
        "chat.editor.fontSize" = 16.0;
        "chat.fontFamily" = "Lexend";
        "debug.console.fontFamily" = "JetBrainsMono Nerd Font";
        "debug.console.fontSize" = 16.0;
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontSize" = 16.0;
        "editor.inlayHints.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.inlineSuggest.enabled" = false;
        "editor.inlineSuggest.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.minimap.sectionHeaderFontSize" = 10.285714285714286;
        "git.autofetch" = true;
        "markdown.preview.fontFamily" = "Lexend";
        "markdown.preview.fontSize" = 16.0;
        "notebook.markup.fontFamily" = "Lexend";
        "redhat.telemetry.enabled" = false;
        "scm.inputFontFamily" = "JetBrainsMono Nerd Font";
        "scm.inputFontSize" = 14.857142857142858;
        "screencastMode.fontSize" = 64.0;
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.fontSize" = 16.0;
        "terminal.integrated.initialHint" = false;
        "workbench.colorTheme" = "Stylix";
        "workbench.editor.empty.hint" = "hidden";
        "workbench.enableExperiments" = false;
        "git.confirmSync" = false;

        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };

        "latex-workshop.format.fixMath.enabled" = true;
        "latex-workshop.latex.recipes" = [
          {
            "name" = "latexmk (lualatex)";
            "tools" = [
              "lualatexmk"
            ];
          }
          {
            "name" = "latexmk";
            "tools" = [
              "latexmk"
            ];
          }
          {
            "name" = "latexmk (latexmkrc)";
            "tools" = [
              "latexmk_rconly"
            ];
          }
          {
            "name" = "latexmk (xelatex)";
            "tools" = [
              "xelatexmk"
            ];
          }
          {
            "name" = "pdflatex -> bibtex -> pdflatex * 2";
            "tools" = [
              "pdflatex"
              "bibtex"
              "pdflatex"
              "pdflatex"
            ];
          }
          {
            "name" = "Compile Rnw files";
            "tools" = [
              "rnw2tex"
              "latexmk"
            ];
          }
          {
            "name" = "Compile Jnw files";
            "tools" = [
              "jnw2tex"
              "latexmk"
            ];
          }
          {
            "name" = "Compile Pnw files";
            "tools" = [
              "pnw2tex"
              "latexmk"
            ];
          }
          {
            "name" = "tectonic";
            "tools" = [
              "tectonic"
            ];
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [
    code-nautilus
  ];
}
