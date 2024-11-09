# If MacOS > 12
# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ "${OSTYPE}" == "darwin"* ]]; then
    echo -e "Getting/using brew requires authentication"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # brew install neovim
fi

# Overwrite dotfiles
files=("zshrc" "gitconfig" "vimrc")
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
echo -e "Don't forget to run :PlugInstall in vim"

# Install nodejs for coc in vim
curl -sL install-node.vercel.app/lts | bash

# Set up gpg keys
# https://github.com/pstadler/keybase-gpg-github
echo -e "\n"
gpg --list-secret-keys --keyid-format LONG
echo -e "Then run:
git config --global user.signingkey YOURKEYHERE
"
