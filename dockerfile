# Ubuntu system
FROM ubuntu:latest
LABEL Author='D-Mv'
LABEL OS='Ubuntu:latest'
LABEL Version="v2"
LABEL User='docker'
# Update & install basic software
RUN apt-get update && apt-get install -y locales && apt-get install -y apt-utils && apt-get install -y sudo && apt install -y build-essential zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev yarn gnupg2 curl zsh git mc nano
# Envrironment
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TZ=Asia/Jerusalem
RUN locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8 && dpkg-reconfigure locales && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $LANGUAGE && echo $LANG && echo $LC_ALL && echo $TZ
# Add user & change shell
RUN useradd docker && usermod -aG sudo docker && echo 'docker ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && mkdir /home/docker && chown docker /home/docker && chsh docker -s $(which zsh)
# Switch user
USER docker

# Install brew
RUN git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew && mkdir /home/docker/.linuxbrew/bin && ln -s /home/docker/.linuxbrew/Homebrew/bin/brew /home/docker/.linuxbrew/bin
ENV export HOMEBREW_NO_ENV_FILTERING=1
ENV PATH /home/docker/.linuxbrew/bin:$PATH
# Install DBs
RUN brew install sqlite3
# RUN brew install postgresql

# Install add-ons to shell
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions && git clone https://github.com/zdharma/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
RUN echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh \n source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> /home/docker/.zshrc
RUN touch /home/docker/.zsh_history
# Get rbenv & ruby-build
RUN git clone https://github.com/rbenv/rbenv.git /home/docker/.rbenv && git clone https://github.com/rbenv/ruby-build.git /home/docker/.rbenv/plugins/ruby-build
# Add paths
ENV PATH /home/docker/.rbenv/shims:$PATH
ENV PATH /home/docker/.rbenv/bin:$PATH
ENV PATH /home/docker/.rbenv:$PATH
# Install Ruby
RUN rbenv install 2.5.3 && rbenv global 2.5.3
# Set environtment path for ruby
ENV PATH /home/docker/.rbenv/versions/2.5.3/bin:$PATH
# Install required gems & heroku
RUN gem sources --remove https://rubygems.org/ && gem sources --add https://gems.ruby-china.com/ && gem sources -l
RUN gem install rake && gem install bundler && gem install rspec && gem install rubocop && gem install hub && gem install octokit && gem install rails && brew install heroku/brew/heroku
# Final stage
CMD echo "command run"
USER docker
WORKDIR /home/docker
ENTRYPOINT /bin/zsh