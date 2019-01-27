# **Docker // Ruby Environment**

## **Why?**

Instead of bloating the laptop with development software, Docker container(s) can be used.

## **Container Contents**

Container is based on latest Ubuntu and configured to setup some standard software and utilities to use, as well as Ruby specific. The shared folder set to `./data`

_Standard:_

- PGP
- Curl
- Git
- [Zsh](https://github.com/zsh-users/zsh) shell with [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) with [syntax highlighting](https://github.com/zdharma/fast-syntax-highlighting) & [auto-suggestion](https://github.com/zsh-users/zsh-autosuggestions)
- Set of standard build tool
- [Midnight Commander](https://github.com/MidnightCommander/mc)
- [Micro Editor](https://micro-editor.github.io/)

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

## **Use**

Download and use the following scripts:

- `build_n_run.sh` - to build, run and execute container
- `run.sh` - to delete old instance, run & execute the container
- `exec.sh` - just execute (login)
