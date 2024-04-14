# slim-tweak
## A method of establishing and displaying a system-wide default session for the SLiM Display Manager, and other enhancements.
Slim-tweak works for SLiM versions 1.36 and slim-fork/1.4. It is best-suited for systems that have multiple desktop environments or window managers to choose from, or that have multiple user logins.  Although certainly a hack, it uses a unique and simple approach to set a global default session for SLiM, altering only /etc/slim.conf and a custom Xsession, not the underlying SLiM code. It works for both Void Linux and Arch Linux, which means it may be used with either elogind or systemd, or without either one. The bash script assumes desktop sessions are listed in **/usr/share/xsessions**, and that SLiM is configured in **/etc/slim.conf**. New xsession files are created in **/usr/share/slim/xsessions-sorted/** and a custom Xsession file in **/usr/share/slim/Xsession**.

## Other features
- Enables SLiM 1.3.6 users to choose executable files, in addition to .desktop entries, similar to SLiM-fork.
- Displays default session and adds a notification that F1 may be used to change sessions
- Enables users of later versions of SLiM to see default session (before pressing F1) 
- Uses loginctl to terminate user seat/session without delay after logout (elogind)
- Unmounts all drives mounted by gvfs/fuse for the user logging out, making them available to other users

## Discussion
This is not a GUI app, and must run from a command line in a terminal window, tty, or console. A second script, "**slim-untweak**" is also installed, and may be used to revert all changes made by slim-tweak.

SliM sadly does not provide an easy way of reordering or predicting the order of sessions when reading them from the xsessions directory. Slim-tweak works because when sessiondir is set in slim.conf, the %session variable will automatically be set to the first option that SLiM reads from the xsessions directory. This means that system-wide, a DE FACTO DEFAULT SESSION EXISTS and CAN BE DISPLAYED at login, without having to press \<F1\>. \<F1\> still allows the user to cyle through other options. Manual configuratiion is no longer necessary in most cases.

**The login user's ~/.xinitrc IS NO LONGER REQUIRED, AND IS IN FACT IGNORED**, unless selected as an F1 option (or default).  Fewer issues tend to occur when ~/.xinitrc is NOT used, but while it is not a recommended session option after running slim-tweak, it is still an available one. A global executable may also be placed as an \<F1\> option in /usr/share/xsessions/. 

Slim-tweak creates a new xsessions directory and leverages "ls -U" to predict the order that files will appear in SLiM, then copies the contents of original /usr/share/xsession .desktop entries. For later versions of SLiM, slim-tweak also appropriates or creates the welcome message for each SLiM theme, in order to display the session default on the login screen. Unfortunately, this approach means that slim-tweak must be run again if new /usr/share/xsession entries or /usr/slim/themes are added.

## Installation

- Clone the "main" branch or download the files in it.
- Move the folder/files to any desired location on the local system.
- cd /_your_folder_with_slim-tweak_files
- chmod +x install.sh
- sudo ./install.sh

A version of the SLiM display manager is required, as is bash. Root access is required. Depending on $PATH at time of installation, slim-tweak and slim-untweak will be placed in /usr/local/bin/, or /usr/bin/. To uninstall, run slim-untweak, then simply remove the two executable files,

## Notes
To run, from the commandline: **sudo slim-tweak**

or to revert changes: **sudo slim-untweak**

As written, slim-tweak will not work for Gentoo or other distributions that store sessions in a different location than **/usr/share/xsessions**.  The script has a $SESSIONDIR variable at the beginning, which may be reassigned to try slim-tweak with these other distros, but this has not been tested. 
