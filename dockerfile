# Ubuntu system
FROM ubuntu:latest
LABEL Author='D-Mv'
LABEL OS='Ubuntu'
LABEL Version="latest"
LABEL User='docker'
# Add user
RUN useradd docker
# Update
RUN apt-get update
RUN apt-get install -y apt-utils
# Set up sudo
RUN apt-get install -y sudo
RUN usermod -aG sudo docker
RUN echo 'docker ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
# Make home dir
RUN mkdir /home/docker
RUN chown docker /home/docker
# Switch user
USER docker

## Install basic software

# Midnigh Commander
RUN sudo apt-get install -y mc
# Nano
RUN sudo apt-get install nano
# PGP
RUN sudo apt-get install -y gnupg2
# Curl
RUN sudo apt-get install -y curl
# Git
RUN sudo apt-get install -y git

## Set up shell

# Create, if needed .bashrc
RUN sudo touch .bashrc
# Instal zsh
RUN sudo apt install -y zsh
# Make changes to bash
RUN sudo touch .bashrc
RUN sudo chmod 777 .bashrc
RUN sudo echo 'export SHELL=$(which zsh)' >> /home/docker/.bashrc
RUN sudo chsh -s $(which zsh)
# Get on.my.zsh
RUN sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Add required lines to .zshrc
RUN sudo touch /home/docker/.zshrc
RUN sudo chown docker /home/docker/.zshrc
# RUN mkdir /home/docker/.oh-my-zsh
RUN sudo chown -R docker /home/docker/.oh-my-zsh
# Remove git plugin
# RUN sudo rm -rf /home/docker/.oh-my-zsh/plugins/git*
RUN sudo echo 'source $ZSH/oh-my-zsh.sh' >> /home/docker/.zshrc
# Install zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN sudo echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /home/docker/.zshrc
# Install syntax highlight
RUN git clone https://github.com/zdharma/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
RUN sudo echo 'source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> /home/docker/.zshrc
# Remove Git module from the .oh-my-zsh theme
RUN sudo rm -rf /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN sudo touch /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN sudo chown docker /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN echo 'local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"' >> /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN echo 'PROMPT="${ret_status} %{$fg[cyan]%}%c%{$reset_color%} "' >> /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN echo 'ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"' >> /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN echo 'ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "' >> /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN echo 'ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"' >> /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
RUN echo 'ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"' >> /home/docker/.oh-my-zsh/themes/robbyrussell.zsh-theme
# Set up build utilities
RUN sudo apt install -y build-essential zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev

## Install rbenv & ruby

# Get rbenv & ruby-build
RUN git clone https://github.com/rbenv/rbenv.git /home/docker/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /home/docker/.rbenv/plugins/ruby-build
# Add paths
RUN sudo echo 'export PATH="/home/docker/.rbenv/shims:$PATH"' >> /home/docker/.zshrc
RUN sudo echo 'export PATH="/home/docker/.rbenv/bin:$PATH"' >> /home/docker/.zshrc
RUN sudo echo 'export PATH="/home/docker/.rbenv:$PATH"' >> /home/docker/.zshrc
RUN sudo /home/docker/.rbenv/plugins/ruby-build/install.sh
# Set the environment path for rbenv
ENV PATH /home/docker/.rbenv/bin:$PATH
RUN sudo echo 'eval "$(rbenv init -)"' >> /home/docker/.zshrc
# Install Ruby
RUN rbenv install 2.5.3
RUN rbenv global 2.5.3
# Set environtment path for ruby
ENV PATH /home/docker/.rbenv/versions/2.5.3/bin:$PATH
RUN ruby -v
# Set environment to bypass tzdata interaction
ENV TZ=Asia/Jerusalem
RUN sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
# Optional
# RUN sudo DEBIAN_FRONTEND=noninteractive
# Install required DBs
RUN sudo apt-get -y install sqlite3 libsqlite3-dev
RUN sudo apt-get -y install libpq-dev build-essential
RUN sudo apt-get -y install postgresql postgresql-contrib
RUN sudo update-rc.d postgresql enable
RUN sudo service postgresql start
# Install required gems
RUN gem sources --remove https://rubygems.org/
RUN gem sources --add https://gems.ruby-china.com/
RUN gem sources -l
RUN gem install rake
RUN gem install bundler
RUN gem install rspec
RUN gem install rubocop
RUN gem install hub
RUN gem install octokit
# (Optional)
RUN gem install rails
# Node
RUN sudo curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN mkdir /home/docker/.npm-global
RUN npm config set prefix '/home/docker/.npm-global'
RUN sudo echo 'export PATH=/home/docker/.npm-global/bin:$PATH' >> /home/docker/.zshrc
ENV PATH=/home/docker/.npm-global/bin:$PATH
# Install packages
RUN npm i -g ngrok
RUN npm i -g lite-server
RUN npm i -g vtop

# Install brew
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
RUN mkdir /home/docker/.linuxbrew/bin
RUN ln -s /home/docker/.linuxbrew/Homebrew/bin/brew /home/docker/.linuxbrew/bin
RUN sudo echo 'export HOMEBREW_NO_ENV_FILTERING=1' >> /home/docker/.zshrc
# (Optional) Install micro editor
# RUN brew install micro
# Install Yarn
ENV alias node=nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN sudo apt-get update && sudo apt-get -y install yarn
# Fixing ownership
RUN sudo touch /home/docker/.zsh_history
# RUN sudo mkdir /home/docker/.config
RUN sudo chown docker /home/docker/
RUN sudo chown docker /home/docker/.zsh_history
RUN sudo chown docker /home/docker/.zshrc
RUN sudo chown docker /home/docker/.config

# Final stage
CMD echo "command run"
USER docker
WORKDIR /home/docker
ENTRYPOINT /bin/zsh
# EXPOSE 5555