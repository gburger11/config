# Basic programs
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

sudo apt install tree tmux vim python3-pip zsh meld fzy silversearcher-ag exuberant-ctags par ripgrep fd-find python3-venv cppcheck
# For bluetooth headset
sudo apt install blueman
# For two / three fingers click on touchpad -> then set correct setting in Tweak (reboot needed)
sudo apt install xserver-xorg-input-synaptics gnome-tweaks

ln -s $HOME/Private/config/nvim_configs/nvim $HOME/.config

# Change default shell
chsh -s $(which zsh)

# Install neovim and dependencies. Do not use apt as it install very old versions
mkdir -p $HOME/.soft_manually_installed
cd $HOME/.soft_manually_installed
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
mkdir -p $HOME/.local
mkdir -p $HOME/.local/bin
ln -s $HOME/.soft_manually_installed/nvim.appimage $HOME/.local/bin/nvim
pip3 install -U pynvim neovim-remote black pylint mypy isort --user
cd -

cd nvim_configs
ln -s $HOME/Private/config/nvim $HOME/.config/nvim
nvim -c "PlugUpgrade | PlugInstall | PlugUpdate | UpdateRemotePlugins"
cd -

cd config_files
for f in *
do
    ln -s $HOME/Private/config/config_files/$f $HOME/.config/$f
done
cd -

cd dot_files
for f in *
do
    ln -s $HOME/Private/config/dot_files/$f $HOME/${f/dot_/.}
done
cd -

cd zshrcs
ln -s $HOME/Private/config/zshrcs/dot_zshrc $HOME/.zshrc
git clone git@github.com:guibur/oh-my-zsh.git $HOME/.oh-my-zsh
cd -

lesskey lesskey_description
