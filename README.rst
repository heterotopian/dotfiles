
========
dotfiles
========

.. highlight:: console

Personal dotfiles manager.

Usage
=====

Install repository files into home directory
--------------------------------------------

::

    $ make install


Install repository files into local test directory
--------------------------------------------------

::

    $ make install-test


Clean test directory
--------------------

::

    $ make clean



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
