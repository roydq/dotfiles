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
linked_paths=(.tmux.conf .gitconfig .shell .zshrc .config/nvim)

# Just in case
mkdir -p ~/.config

# Link dotfiles
echo "Linking dotfiles..."
for item in "${linked_paths[@]}"; do
  create_link $config_path/$item $HOME/$item
done
echo "Done."
echo ""

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
