# Setup Linux Machine

These are instructions to my fututre self on how to set up a new linux machine.

These instructions are presented in order, based on experience with Pop OS.

## Browser

- Firefox. Add custom searches.
- Gmail

## Browser instructions

Follow up-to-date instructions from the official websites.

- Miniconda
- Docker
- Sublime text/merge
- LaTeX
- Spotify-tui # requires libssl1.1 from focal-security
- Linuxbrew
- Tweaks
- [tlmgr init-usertree](https://tug.org/texlive/upgrade.html>)
- Dracula theme
    - [gtk](https://draculatheme.com/gtk)
    - [gnome-terminal](https://draculatheme.com/gnome-terminal)
    - [vim](https://draculatheme.com/vim)
- Redshift on startup with `/etc/systemd/system/redshift-gtk.service`

## Manual edits

- Set up ssh key for github
- Add git config
- Set profile picture
- Set default text editor in `org.gnome.gedit.desktop`

```bash
sudo apt-get update
sudo apt-get install gnome-tweaks npm xclip tmux rclone vlc redshift-gtk tlmgr
sudo npm install -g saltthepass
git clone github.com/cbroz1/dotfiles ~/dotfiles
gsettings set org.gnome.desktop.background picture-options 'none'
gsettings set org.gnome.desktop.background primary-color '#282a36'
eval `dircolors /home/cb/.dir_colors/dircolors` # add to .bashrc?
```

## Gnome extensions

- Clipboard indicator
- Cosmic doc
- Cosmic workspaces
- Cosmic X11 Gestures
- Chronomix
- Desktop icons NG
- Minimalist calendar 3
- Places status indicator
- Pop COSMIC
- Pop shell
- Remove Alt+Tab delay v2
- Resource monitor
- Sound input & output device chooser
- System76 Power
- Ubuntu app indicators
- User themes
