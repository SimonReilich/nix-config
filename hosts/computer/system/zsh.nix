{ inputs, pkgs, ... }:

{
  # Prevent the new user dialog in zsh
  system.userActivationScripts.zshrc = "touch .zshrc";
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    promptInit = ''
      source ${inputs.zsh-plugins.syntax-highlighting}/zsh-syntax-highlighting.plugin.zsh;
      source ${inputs.zsh-plugins.completions}/zsh-completions.plugin.zsh;
      source ${inputs.zsh-plugins.autosuggestions}/zsh-autosuggestions.plugin.zsh;
      source ${inputs.zsh-plugins.fzf-tab}/fzf-tab.plugin.zsh;

      autoload -Uz compinit && compinit

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      autoload -Uz edit-command-line
      zle -N edit-command-line

      bindkey '^x^e' edit-command-line
      bindkey ' ' magic-space

      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(oh-my-posh init zsh --config /home/simonr/Documents/Infra/nix-config/hosts/computer/user/prompt.toml)"
    '';

    shellInit = ''
      autoload -Uz add-zsh-hook

      eval "$(devenv hook zsh)"

      alias -s json=jless
      alias -s md=bat
      alias -s rs='$EDITOR'
      alias -s txt=bat
      alias -s log=bat
      alias -s py='$EDITOR'
      alias -s js='$EDITOR'
      alias -s ts='$EDITOR'
      alias -s html='zen --profile ~/.zen/simon'

      # Redirect stderr to /dev/null
      alias -g NE='2>/dev/null'

      # Redirect stdout to /dev/null
      alias -g NO='>/dev/null'

      # Redirect both stdout and stderr to /dev/null
      alias -g NUL='>/dev/null 2>&1'

      # Copying output to clipboard
      alias -g C='| wl-copy'
    '';

    interactiveShellInit = ''
      template() {
        if [ -z "$1" ]; then
          echo "Usage: template <name>"
          return 1
        fi
        nix flake init -t "github:SimonReilich/Flake-Templates#$1"
      }
    '';

    shellAliases = {
      ls = "ls --color";
      update = "(cd /home/simonr/Documents/Infra/nix-config && git add * && sudo nixos-rebuild switch --flake /home/simonr/Documents/Infra/nix-config && sudo nix-collect-garbage --delete-older-than 7d)";
      pull-update = "(cd /home/simonr/Documents/Infra/nix-config && git add * && git pull && sudo nixos-rebuild switch --flake /home/simonr/Documents/Infra/nix-config && sudo nix-collect-garbage --delete-older-than 7d)";
      n8n = "zen-beta localhost:5678 & ssh -L 5678:localhost:5678 vps";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    ohMyZsh = {
      enable = true;
      plugins = [
        "cabal"
        "colored-man-pages"
        "colorize"
        "command-not-found"
        "copybuffer"
        "gh"
        "git"
        "git-auto-fetch"
        "history-substring-search"
        "npm"
        "pip"
        "python"
        "rust"
        "safe-paste"
        "spring"
        "ssh"
        "sudo"
        "zoxide"
      ];
      theme = "robbyrussell";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    flags = [
      "--cmd cd"
    ];
  };

  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
}
