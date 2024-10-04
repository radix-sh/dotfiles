# dotfiles
These are backups of my dotfiles. Running `setup.sh` is destructive, so read
it carefully (and run `compare.sh` first) beforehand.

Notes for myself:
* Use hard links, not soft/symbolic links, because hard links are the same file
  under a different name and can therefore be properly pushed out.
* `~/.vimrc` has a symlink at `~/.config/nvim/init.vim`
