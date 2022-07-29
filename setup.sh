# If MacOS
# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ "${OSTYPE}" == "darwin"* ]]; then
    echo -e "Getting/using brew requires authentication"
    # Get brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Use brew
    brew install node
    brew install neovim
    # https://dev.to/jasonelwood/setup-gdb-on-macos-in-2020-489k
    brew install gdb
    # gdb_path=$(which gdb)
    # codesign --entitlements gdb-entitlement.xml -fs gdb-cert $gdb_path
    # echo "set startup-with-shell off" >> ~/.gdbinit
fi

# Overwrite dotfiles
files=("bash_profile" "bashrc" "gitconfig" "vimrc" "vim")
echo -e "To be overwritten: "
for file in ${files[@]}; do
    echo .$file
done
echo ""

while true; do
    read -p "Are you sure you want to overwrite all current dotfiles? " input
    case $input in 
        y | Y) 
            echo "Setting up new dotfiles..."
            for str in ${files[@]}; do 
                echo "Replacing ~/.$str"
                rm -r ~/.$str
                cp -r $str ~/.$str
            done
            break
            ;;
        n | N)
            echo "Stopping..."
            exit 1;
            ;;
        *) 
            echo "Invalid input"
    esac 
done
echo

# iceberg.vim
echo "Installing iceberg.vim..."
curl -o ~/.vim/colors/iceberg.vim \
     --create-dirs https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim

echo -e "Don't forget to run :PlugInstall in vim"

# Set up git
git config --global alias.s status
git config --global alias.br branch
git config credential.helper store
git config --global commit.gpgsign true

# Set up gpg keys
# https://github.com/pstadler/keybase-gpg-github
echo -e "\n"
gpg --list-secret-keys --keyid-format LONG
echo -e "Then run:
git config --global user.signingkey YOURKEYHERE
"
