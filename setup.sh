# If MacOS
# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
if [[ "${OSTYPE}" == "darwin"* ]]; then
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
files=("bash_profile" "bashrc" "vimrc")
printf '%s\n' "To be overwritten: 
${files[@]}
"
while true; do
    read -p "Are you sure you want to overwrite all current dotfiles? " input
    case $input in 
        y | Y) 
            echo "Setting up new dotfiles..."
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

: '
Launch Keychain Access application: Applications > Utilities > Keychain Access.
From the Keychains list on the left, right-click on the System item and select Unlock Keychain "System".
From the toolbar, go to Keychain Access > Certificate Assistant > Create a Certificate.
Choose a name (e.g. gdb-cert).
Set Identity Type to Self Signed Root.
Set Certificate Type to Code Signing.
Check the Let me override defaults checkbox.
At this point, you can go on with the installation process until you get the Specify a Location For The Certificate dialogue box. Here you need to set Keychain to System. Finally, you can click on the Create button.
After these steps, you can see the new certificate under System keychains. From the contextual menu of the newly created certificate (right-click on it) select the Get info option. In the dialogue box, expand  
the Trust item and set Code signing to Always Trust.
Then, from the Keychains list on the left, right-click on the System item and select Lock Keychain "System".
Finally, reboot your system.
'

<<<<<<< HEAD
=======
# gdb_path=$(which gdb)
# codesign --entitlements gdb-entitlement.xml -fs gdb-cert $gdb_path
# echo "set startup-with-shell off" >> ~/.gdbinit

# Set up git
git config --global alias.s status
git config --global alias.br branch
git config credential.helper store
>>>>>>> e0a967e8212c16abce2546d08c70100a5e561e6c
