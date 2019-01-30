# **Docker // Ruby Environment**

## **Why?**

Instead of bloating the laptop with development software, Docker container(s) can be used.

## **Container Contents**

Container is based on latest Ubuntu and configured to setup some standard software and utilities to use, as well as Ruby specific. The shared folder mapped to `./data`.

_Standard:_

- PGP
- Curl
- Git
- [Zsh](https://github.com/zsh-users/zsh) shell with [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) with [syntax highlighting](https://github.com/zdharma/fast-syntax-highlighting) & [auto-suggestion](https://github.com/zsh-users/zsh-autosuggestions)
- Set of standard build tool
- [Midnight Commander](https://github.com/MidnightCommander/mc)
- REMOVED: [Micro Editor](https://micro-editor.github.io/)
- ADDED: [Nano editor](https://www.nano-editor.org)

_Ruby:_

- Rbenv
- Ruby 2.5.3
- Gems:
  - rake
  - bundler
  - rspec
  - rubocop
  - pry
  - pry-byebug
  - hub
  - colored
  - octokit
  - faker
  - sinatra-contrib
  - sinatra
  - activerecord
  - sqlite3
- ADDED: Node 11.x
  - [ngrok](https://ngrok.com)
  - [lite-server](https://github.com/johnpapa/lite-server)
  - [vtop](https://github.com/MrRio/vtop)

## **Use**

Download and use the following scripts:

- `build_n_run.sh` - to build, run and execute container.
- `run.sh` - to delete old instance, run & execute the container.
- `exec.sh` - just execute (login).


## **UPDATE 1**

- Increased upper limits: 4 GB memory and 4 CPU cores.
- Change Oh-My-Zsh default theme to remove Git plugin to speed up the folder navigation on shared folders with Git initialized.
- Removed Micro Editor - due to installation issues.
- Added Nano editor instead.
- Changed scripts:
  - `build_n_run.sh` - added -t option. [More details here](https://docs.docker.com/engine/reference/commandline/build/).
- Added scripts:
  - `run_3000.sh` - maps port 3000 to host 8080 - for lite-server (default).
  - `run_4567.sh` - maps port 4567 to host 8080 - for ruby server (default).
  - `exec.sh` - execute (login) with *root* as user.
  - `destroy.sh` - destroys container and image.
