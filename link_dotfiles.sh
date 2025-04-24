#! /bin/bash
set -e

# Create link if it doesn't already exist
function create_link() {
  src=$1
  dest=$2

  if [ -L $dest ]; then
    echo "$dest already linked"
  elif [ -f $dest ]; then
    echo "file already exists at $dest"
  else
    echo "link $src to $dest"
    ln -s $src $dest
  fi
}

# Path to config files to link/copy
config_path=$PWD/config

# Files and directories to link
linked_paths=(.tmux.conf .gitconfig .shell .zshrc .config/nvim .local/share/nvim/site .oh-my-zsh/custom/themes/roy.zsh-theme)

# Just in case
mkdir -p ~/.local/share/nvim
mkdir -p ~/.config
mkdir -p ~/.oh-my-zsh/custom/themes

# Link dotfiles
echo "Linking dotfiles..."
for item in "${linked_paths[@]}"
do
  create_link $config_path/$item $HOME/$item
done
echo "Done."
echo ""

# Check if this is WSL. If so, link some WSL-specific dotfiles
# Might not actually be necessary, this was with WSL 1
if [[ $PATH == *"Windows"* ]]; then
  # Used for Windows Subsystem for linux
  wsl_linked_paths=(.bash_aliases .bashrc)

  # Backup default .bashrc
  if [[ ! -L $HOME/.bashrc && -f $HOME/.bashrc ]]; then
    mv $HOME/.bashrc $HOME/.bashrc.default
  fi

  echo "WSL detected, linking bash config..."
  for item in "${wsl_linked_paths[@]}"
  do
    create_link $config_path/wsl/$item $HOME/$item
  done
  echo "Done"
  echo ""
fi

# Install tmux plugin manager
echo "Cloning tmux plugin manager..."
tpm_dir=$HOME/.tmux/plugins/tpm
if [[ ! -e "$tpm_dir" ]]; then
  git clone https://github.com/tmux-plugins/tpm $tpm_dir
else
  echo "tmux plugin manager already installed"
fi
echo "Done."
echo ""
