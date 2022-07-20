# dotfiles
Backups of my dotfiles. Fairly self-explanatory. I am working to make this
cross-platform.

Details:
* Use hard links, not soft/symbolic links, because hard links are the same file
  under a different name and can therefore be properly pushed out.
* `~/.vimrc` has a symlink at `~/.config/nvim/init.vim`
