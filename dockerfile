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

# Install Midnigh Commander
RUN sudo apt-get install -y mc
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
RUN sudo echo 'source $ZSH/oh-my-zsh.sh' >> /home/docker/.zshrc
# Install zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN sudo echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /home/docker/.zshrc
# Install syntax highlight
RUN git clone https://github.com/zdharma/fast-syntax-highlighting ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
RUN sudo echo 'source ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> /home/docker/.zshrc
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
# Install required gems
RUN sudo apt-get install sqlite3 libsqlite3-dev
RUN gem sources --remove https://rubygems.org/
RUN gem sources --add https://gems.ruby-china.com/
RUN gem sources -l
RUN gem install rake bundler rspec rubocop pry pry-byebug hub colored octokit faker sinatra-contrib sinatra activerecord sqlite3
# Install Micro
RUN sudo curl https://getmic.ro
# Fixing ownership
RUN sudo touch /home/docker/.zsh_history
RUN sudo mkdir /home/docker/.config
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