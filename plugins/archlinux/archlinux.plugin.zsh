# Archlinux zsh aliases and functions
# Usage is also described at https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins

# Pacman Tips - https://wiki.archlinux.org/index.php/Pacman_Tips

# Look for yaourt, and add some useful functions if we have it.
if [ -n "`command -v yaourt`" ]; then
  upgrade() {
    yaourt -Syu
  }

  alias yaconf='yaourt -C'        # Fix all configuration files with vimdiff

  # Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
  alias pacupg='yaourt -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
  alias pacsu='yaourt --sucre'      # Same as yaupg, but without confirmation
  alias pacin='yaourt -S'           # Install specific package(s) from the repositories
  alias pacins='yaourt -U'          # Install specific package not from the repositories but from a file
  alias pacre='yaourt -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
  alias pacrem='yaourt -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
  alias pacrep='yaourt -Si'         # Display information about a given package in the repositories
  alias pacreps='yaourt -Ss'        # Search for package(s) in the repositories
  alias pacloc='yaourt -Qi'         # Display information about a given package in the local database
  alias paclocs='yaourt -Qs'        # Search for package(s) in the local database

  # Additional yaourt alias examples
  if [ -n "`command -v abs`" ]; then
    alias pacupd='yaourt -Sy && sudo abs'   # Update and refresh the local package and ABS databases against repositories
  else
    alias pacupd='yaourt -Sy'               # Update and refresh the local package and ABS databases against repositories
  fi

  alias pacinsd='yaourt -S --asdeps'        # Install given package(s) as dependencies of another package
  alias pacmir='yaourt -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

else
  if [ -n "`command -v packer`" ]; then
    upgrade() {
      packer -Syu
    }
    alias pacin='packer -S'                # Install specific package(s) from the repositories
    alias pacrep='packer -Si'              # Display information about a given package in the repositories
    alias pacreps='packer -Ss'             # Search for package(s) in the repositories
  else
    upgrade() {
      sudo pacman -Syu
    }
    alias pacin='sudo pacman -Sy'          # Install specific package(s) from the repositories
    alias pacrep='pacman -Si'              # Display information about a given package in the repositories
    alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
  fi

 alias pacupg='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
 alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file
 alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
 alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
 alias pacloc='pacman -Qi'              # Display information about a given package in the local database
 alias paclocs='pacman -Qs'             # Search for package(s) in the local database

 # Additional pacman alias examples
 if [ -n "`command -v abs`" ]; then
   alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
 else
   alias pacupd='sudo pacman -Sy'     # Update and refresh the local package and ABS databases against repositories
 fi

 alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
 alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
fi

alias pacremdep='sudo pacman -Rcns'    # Remove the specified package(s), its configuration(s) and all dependencies

# https://bbs.archlinux.org/viewtopic.php?id=93683
paclist() {
  sudo pacman -Qei $(pacman -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
}

alias paclsorphans='sudo pacman -Qdt'
alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'

pacdisowned() {
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap  'rm -rf "$tmp"' EXIT

  pacman -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr \
      ! -name lost+found \
        \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}
