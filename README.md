# config
- Title and Command/Custom command: `/usr/bin/byobu`.
- Edit/Keyboard Shortcuts: uncheck `Enable menu access keys`.
- `ln -s` the dot files in dot_files, zshrcs and vimrcs to home.

# keyboard config with sudo rights
~~evdev.lst and evdev.xml to copy in /usr/share/X11/xkb/rules~~

Add to /usr/share/X11/xkb/rules/evdev.xml:
```
    <layout>
      <configItem>
        <name>ps</name>
        
        <shortDescription>perso</shortDescription>
        <description>Bepo perso</description>
        <languageList>
          <iso639Id>fra</iso639Id>
        </languageList>
      </configItem>
      <variantList>
        <variant>
          <configItem>
            <name>bepo_perso</name>
            <description>Bepo perso</description>
          </configItem>
        </variant>
      </variantList>
    </layout>
```

ps to `ln -s` in /usr/share/X11/xkb/symbols

# keyboard config without sudo rights

Add in bashrc
```
# change the keyboard config
. ~/Private/config/keyboard/xmodmap/.xmodmap.launcher > out.log 2> /dev/null

```

# TODO on a new computer

## For work
- Encrypt home folder
   1. Install ecryptfs
   1. `sudo adduser --encrypt-home <user>*` pour creer une nouvelle sesion avec un home crypter
   2. se donner les droit sudo `sudo usermod -aG sudo <user>`
   3. se logger sur la nouvelle session et supprimer la premiere
- Install veracrypt
- Add certificates on Chromium (settings-> advanced ->  and Firefox
- Install printer
- Install mattermost and trello (https://github.com/danielchatfield/trello-desktop)

## Little things
- change mouse side
- add Alt+5/4/6/2/8 for lecture/davance/return/volume down/volume up [For Ubuntu 18.04, it is in settings/Devices/keyboard]
- show dock on all displays
- Install ssh key for github and gitlab
- Install pip and pip3 (`sudo apt-get install python-pip python3-pip`)
- Install and configure numlockx (https://doc.ubuntu-fr.org/numlockx)

## keyboard
#### With sudo rights
- Add `  ps              Perso` and `bepo_perso      ps: Perso` lines to `/usr/share/X11/xkb/rules/evedv.lst` respectively in the `! layout` and `! variant` sections
- Add to evdev.xml :
```
    <layout>
      <configItem>
        <name>ps</name>
        
        <shortDescription>ps</shortDescription>
        <description>Perso</description>
        <languageList>
          <iso639Id>fra</iso639Id>
        </languageList>
      </configItem>
      <variantList>
        <variant>
          <configItem>
            <name>bepo_perso</name>
            <description>Perso</description>
          </configItem>
        </variant>
      </variantList>
    </layout>
```
- Add to `/usr/share/console-setup/KeyboardNames.pl` the language. (TODO: develop if working)
- copy `ps` file to `/usr/share/X11/xkb/symbols`
- Change default keyboard in `/etc/default/keyboard`

## terminal preparation
- Install zsh (and make it default with `chsh -s $(which zsh)` and log out/in)
- Install neovim (by apt-get in Ubuntu 18 !!)
- Install neovim-remote (`pip3 install neovim-remote`)
- Install tmux
- ~~Install byobu (by apt-get in Ubuntu 18 !!)~~
- Copy `.zshrc` (don't forget to change user name if need be!)
- Import oh-my-zsh from `git@github.com:guibur/oh-my-zsh.git` (don't forget to change user name in themes/guillaumeburger.zsh-theme if need be)
- Copy all files and folders except plugins to ~/.config/nvim
- Open new neovim do `:PlugInstall` and `:UpdateRemotePlugins`
- Install `sudo apt-get install exuberant-ctags silversearcher-ag fzy`

#### Problem of compatibility python2 and 3 with deoplete and work configuration
- install virtualenv (pip install)
- create virtualenv with python3 and pip install neovim
- add to zshrc:
```
    if ! { [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; } then
        export PYTHONPATH=
        source $HOME/neovim_env/neovim_env/bin/activate
        nvim
    fi
```

## configs
- Do `lesskey path/to/config/dot_files/lesskey`
- Copy files in `dot_files/config` in `~/.config` (flake8, pep8)
- Copy dot_files in home (gitconfig, pylintrc, noserc, byobu folder)
(change agignore to ignore in neovim-fuzzy plugin)
