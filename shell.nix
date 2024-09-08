let
  # If you followed the Ad hoc shell environments tutorial and don’t want to 
  # to download all dependencies again, specify the exact same revision as in 
  # the section Towards reproducibility:
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    fastfetch
    cowsay
    lolcat
    neovim
    tmux
    git
  ];
  
# set environment variables
# set shell startup commands
GREETING="Home sweet home! Your Personal development setup is ready!";
shellHook = ''

    # config neovim
    echo "\nNeovim configure start...\n" 
    echo "==============================\n" 
    # Clone the Neovim configuration from your GitHub repo
    git clone https://github.com/davidgao7/nvim-config.git
    mv nvim-config/nvim $HOME/.config

    # Set the XDG config and data directories to use the cloned config
    export XDG_CONFIG_HOME=$HOME/.config
    export XDG_DATA_HOME=$HOME/.local/share

    # alias vim to nvim
    alias vim=nvim

    echo "\n==============================\n" 
    echo "Neovim configured with Lazy package manager completed!\n"

    # config tmux
    echo "Tmux configure start...\n" 
    echo "==============================\n" 
    echo "insall tmux plugin manager: tpm"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
    echo "install tmux plugins"
    mv nvim-config/tmux.conf $HOME/.tmux.conf
    tmux source $HOME/.tmux.conf || true
    echo "Tmux Plugin Manager (TPM) is setted up!"
    echo "\n==============================\n" 
    echo "Tmux configured!\n"

    echo $GREETING | cowsay | lolcat
'';
}

