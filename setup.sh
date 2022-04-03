# get brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# use brew
# brew install node
# brew install neovim

# overwrite dotfiles
while true; do
    read -p "Are you sure you want to overwrite all current dotfiles? " input
    case $input in 
        y | Y) 
            echo "Setting up new dotfiles..."
            files=("bash_profile" "bashrc" "vimrc")
            for str in ${files[@]}; do 
                echo "Replacing ~/.$str"
                rm ~/.$str
                cp $str ~/.$str
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


