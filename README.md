# **Docker // Ruby Environment v2**

## **Why?**

Instead of bloating the laptop with development software, Docker container(s) can be used.

## **Container Contents**

Container is based on latest Ubuntu and configured to setup some standard software and utilities to use, as well as Ruby specific. The shared folder mapped to `./data`.

_Standard:_

- PGP
- Curl
- Git
- [Zsh](https://github.com/zsh-users/zsh) shell with [syntax highlighting](https://github.com/zdharma/fast-syntax-highlighting) & [auto-suggestion](https://github.com/zsh-users/zsh-autosuggestions)
- Set of standard build tool
- [Midnight Commander](https://github.com/MidnightCommander/mc)
- [Nano editor](https://www.nano-editor.org)
- Linuxbrew

_Ruby:_

- Rbenv
- Ruby 2.5.3
- Some gems for starters, including Rails
- Heroku
- SQLite
- PostgreSQL (off by default)


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
  - `_build_n_run.sh` - added -t option. [More details here](https://docs.docker.com/engine/reference/commandline/build/).
- Added scripts:
  - `_run_3000.sh` - maps port 3000 to host 8080.
  - `_destroy.sh` - destroys container and image.
  - `exec.sh` - execute (login) with _docker_ as user.
  - `exec_root.sh` - execute (login) with _root_ as user.
  - `start.sh` - starts container.

## **UPDATE 2**

- Removed gem installation to speed up.
- Added PostgreSQL (can be disabled).
- Add Linuxbrew.

## v2

- Removed all non-required stuff:
  - scripts with ports (build-n-run & run have ports mapped)
  - removed ZSH themes
- Refactored to decrease amount of actions and layers
- Node with JS will be included in 'Docker // JS Environment'