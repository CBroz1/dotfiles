# Setup Linux Machine

These are instructions to my fututre self on how to set up a new linux machine.

These instructions are presented in order, based on experience with Pop OS.

```bash
git clone github.com/cbroz1/dotfiles ~/dotfiles
cd ~/dotfiles
./config.sh
```

## Navigation

- Window tiler
  - Hint color: #44475a
  - Show active hint
  - Border radius: 2px
- Keyboard shortcuts: Settings -> Keyboard -> Keyboard shortcuts
  - Minimize: Windows -> Hide Window -> Super+N
- [NerdFont](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Meslo.zip)

## Browser

- Firefox
  - Add custom searches with ext. Then Settings -> Search -> Shortcut
    - yt
      - <https://www.youtube.com/results?search_query=%s>
      - <https://cdn-icons-png.flaticon.com/512/152/152810.png>
    - m
      - <https://www.google.com/maps/search/%s/@41.9,-87.7,13z/>
      - <https://cdn-icons-png.flaticon.com/512/61/61942.png>
    - a
      - <https://www.amazon.com/s?k=%s>
      - <https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/amazon-black-icon.png>
    - i
      - <https://www.google.com/search?q=%s&udm=2>
      - <https://cdn-icons-png.flaticon.com/256/9261/9261079.png>
  - Customize toolbar
    - Add home
    - Remove buffer x2
    - Remove pocket
  - [DarkReader Dracula](https://github.com/Dpbm/Dracula-DarkReader)
    - Background --> #282a36
    - BackgroText --> #f8f8f2
    - BackgroScrollbar --> custom --> #6272a4
    - BackgroSelection --> custom: --> #44475a
- Gmail sign in

## Programs

- [code](https://code.visualstudio.com/docs/?dv=linux64_deb): apt version is
    outdated. VSCode rejects soft linked config files
- [docker](https://docs.docker.com/engine/install/ubuntu/)
- [gnome extensions](https://extensions.gnome.org/)
  - Clipboard indicator (toggle the menu: Ctrl+Super+V)
  - Minimalist calendar 3
  - Places status indicator
  - Remove Alt+Tab delay v2
  - Resource monitor (5s refresh, off decimals, disk off, net off)
  - Sound input & output device chooser
  - User themes
- [miniconda](https://docs.anaconda.com/miniconda/install/)
- [nodeJS](https://nodejs.org/en/download)
- [nvim](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux)
- [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)
- [pika Backup](https://flathub.org/apps/org.gnome.World.PikaBackup)
- [pulse deb](http://webdev.web3.technion.ac.il/docs/cis/public/ssl-vpn/ps-pulse-ubuntu-debian.deb)
- [slack deb](https://slack.com/downloads/instructions/linux?ddl=1&build=deb)
- sublime
  - [Text](https://www.sublimetext.com/docs/linux_repositories.html)
  - [Merge](https://www.sublimemerge.com/docs/linux_repositories)
  - Enter respective licenses
  - Install package controll and dracula theme, switch theme
  - [Merge theme](https://github.com/facelessuser/merge-dracula-theme)
  - Edit color scheme, add global: `"fold_marker": "#bd93f9"`
- [tlmgr init-usertree](https://tug.org/texlive/upgrade.html)
- [tpm](https://github.com/tmux-plugins/tpm)
- [zoom](https://zoom.us/download?os=linux)

## Logins

- Set profile picture
- Set up git: `gh auth login`
- Set up nvim: `Copilot auth`
- Code login. If settings don't sync, move `~/dotfiles/code/*` to `~/.config/Code/User/`

## Misc

- [mocp config](https://wiki.archlinux.org/title/MOC#Configuration)
  - `cp /usr/share/doc/moc/examples/config.example ~/.moc/config`
  - set theme to [alldefault](https://github.com/wimstefan/mocp-themes/blob/master/alldefault)
  - download linked theme to `~/.moc/themes/`
- Dracula theme
  - [gnome-terminal](https://draculatheme.com/gnome-terminal) (TODO: is moving dircolors file enough?)
  - [vim](https://draculatheme.com/vim)
  - [gtk](https://draculatheme.com/gtk)
- Tweaks (installed via apt)
  - Appearance -> Applications -> Dracula
  - Startup applications: Firefox, Slack
