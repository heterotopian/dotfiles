
========
dotfiles
========

.. highlight:: console

Personal dotfiles manager.

Usage
=====

Clean generated files::

    $ make clean

Install repository files::

    $ make install           # Home directory
    $ make install-test      # Test directory

Dry run, show rsync changes required for install::

    $ make preview           # Home directory
    $ make preview-test      # Test directory



Contents
========

src/
----

.bash.d/
~~~~~~~~

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
