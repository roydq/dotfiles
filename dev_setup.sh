#!/bin/bash
set -e

function log_status {
  echo ""
  echo -e ">> \e[36m$1\e[0m"
  echo ""
}

if ! [ $SUDO_USER ]; then
   echo "This script must be run with sudo." >&2
   exit 1
fi

log_status "Updating"

apt-get update
apt-get -yqq upgrade
apt-get -yqq autoremove

log_status "Installing build packages"

# https://github.com/rbenv/ruby-build/wiki
apt-get -yqq install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

log_status "Installing service packages"

# Services
apt-get -yqq install postgresql redis-server postgresql-server-dev-12

log_status "Installing misc packages"

# Tools
apt-get -yqq install tmux neovim python3-pip unzip expect

# Install rbenv
if ! [ -d /home/$SUDO_USER/.rbenv ]; then
  log_status "Installing rbenv"

  sudo -u $SUDO_USER git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  sudo -u $SUDO_USER cd ~/.rbenv && src/configure && make -C src
else
  log_status "rbenv already installed"
fi

# Install ruby-build
if ! [ -d /home/$SUDO_USER/.rbenv/plugins/ruby-build ]; then
  log_status "Installing ruby-build"

  sudo -u $SUDO_USER mkdir -p "$(rbenv root)"/plugins
  sudo -u $SUDO_USER git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
else
  log_status "ruby-build already installed"
fi

# Make a temp dir for these
TMPDIR=`mktemp -d`
cd $TMPDIR

# AWS CLI
if ! command -v aws &> /dev/null; then
  log_status "Installing AWS CLI"

  AWSCLI=awscliv2.zip 
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$AWSCLI"
  unzip $AWSCLI
  ./aws/install
  rm -r ./aws
  rm $AWSCLI
else
  log_status "AWS CLI already installed"
fi

# Deis CLI
if ! command -v deis &> /dev/null; then
  log_status "Installing Deis CLI"

  curl -sSL https://raw.githubusercontent.com/teamhephy/workflow-cli/master/install-v2.sh | bash
  mv $PWD/deis /usr/local/bin/deis
else
  log_status "Deis CLI already installed"
fi

# Kubectl
if ! command -v kubectl &> /dev/null; then
  log_status "Installing kubectl"

  curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  mv ./kubectl /usr/local/bin/kubectl
else
  log_status "Kubectl already installed"
fi

# N for NodeJS
if ! [ -d /home/$SUDO_USER/n ]; then
  log_status "Installing n for nodejs"

  curl -LO https://git.io/n-install
  sudo -u $SUDO_USER /bin/bash n-install -y
else
  log_status "N for nodejs already installed"
fi

log_status "Done!"
