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
        # Disable AI features
        "chat.disableAIFeatures" = true;
        "chat.agent.enabled" = false;
        "chat.commandCenter.enabled" = false;
        "chat.editor.enableChat" = false;
        "editor.inlineSuggest.enabled" = false;
        "terminal.integrated.initialHint" = false;
        "github.copilot.enable" = { "*" = false; };
        "github.copilot.editor.enableAutoCompletions" = false;

        # Privacy and experiments
        "telemetry.telemetryLevel" = "off";
        "redhat.telemetry.enabled" = false;
        "workbench.enableExperiments" = false;
        "workbench.editor.empty.hint" = "hidden";
      };
    };
  };

  home.packages = with pkgs; [
    code-nautilus
  ];

  stylix.targets.vscodium.enable = true;
}
