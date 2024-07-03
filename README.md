# keyboard config (with sudo rights)

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
- Complete `evdev.xml` as well :
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
- Add to `/usr/share/console-setup/KeyboardNames.pl` the language. (Necessary for setting keyboard at login)
- copy `ps` file to `/usr/share/X11/xkb/symbols`
- Change default keyboard in `/etc/default/keyboard`

## terminal preparation
- Install zsh (and make it default with `chsh -s $(which zsh)` and log out/in)
- Install neovim (Avoid apt as it always install (very) old versins)
- Install neovim-remote (`pip3 install neovim-remote`)
- Install tmux
- Copy `.zshrc` (don't forget to change user name if need be!)
- Import oh-my-zsh from `git@github.com:guibur/oh-my-zsh.git` (don't forget to change user name in themes/guillaumeburger.zsh-theme if need be)
- Copy all files and folders except plugins to ~/.config/nvim
- Open new neovim do `:PlugInstall` and `:UpdateRemotePlugins`
- Install `sudo apt-get install exuberant-ctags silversearcher-ag fzy`

## configs
- Do `lesskey path/to/config/dot_files/lesskey`
- Copy files in `dot_files/config` in `~/.config` (flake8, pep8)
- Copy dot_files in home (gitconfig, pylintrc, noserc, byobu folder)
(change agignore to ignore in neovim-fuzzy plugin)
