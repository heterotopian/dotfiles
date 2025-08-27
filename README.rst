
========
dotfiles
========

Personal dotfiles manager.

-----
Usage
-----

::

    $ make info
    $ make clean
    $ make preview
    $ make install
    $ make delete
    $ make update



-----
Notes
-----

Re-initialize tempdir from homedir::

    make clean
    make tmp
    cp -R ~/.atom tmp
    rm -f tmp/.atom/{config.cson,init.coffee,keymap.cson,packages.list,styles.less}

Prepare homedir for stow by setting aside existing files::

    find .atom/{config.cson,init.coffee,keymap.cson,packages.list,styles.less} .bash.d .vim .gitconfig .gitignore .gvimrc .tmux.conf .vimrc -maxdepth 0 -mindepth 0 | while read existing; do mv "${existing}" "${existing}.prestow"; done



-------------
Stow Packages
-------------

atom
====


bash
====

.bash.d/
--------

Drop-in directory for Bash configuration fragments.

Load fragments from ``.bashrc``::

    if [ -d ~/.bash.d ]
    then
        for file in ~/.bash.d/*
        do
            if [ -r "${file}" ]
            then
               . "${file}"
            fi
        done
    fi


git
===


tmux
====


vim
===
