# slim-tweak
## A method of establishing and displaying a system-wide default session for the SLiM Display Manager, and other enhancements.
Slim-tweak is best-suited for systems that have multiple desktop environments or window managers to choose from, or that have multiple user logins.  Although certainly a hack, it uses a unique and simple approach to set a global default session for SLiM, altering only /etc/slim.conf and a custom Xsession, not the underlying SLiM code. It works for both Void Linux and Arch Linux, which means it may be used with either elogind or systemd. The bash script assumes desktop sessions are listed in **/usr/share/xsessions**, and that SLiM is configured in **/etc/slim.conf**. New xsession files are created in **/usr/share/slim/xsessions-sorted/** and a custom Xsession file in **/usr/share/slim/Xsession**.

## Other features
- Enables SLiM 1.3.6 users to choose executable files, in addition to .desktop entries, similar to SLiM-fork.
- Adds a notification that F1 may be used to change sessions
- Uses loginctl to terminate user seat/session without delay after logout (elogind)
- Unmounts all drives mounted by gvfs/fuse for the user logging out, making them available to other users

## Discussion
Unfortunately SliM provides no easy way of reordering or predicting the order of xsessions when reading them from the xsessions directory. Slim-tweak works best for SLiM 1.3.6, because when sessiondir is set in slim.conf, the %session variable will automatically be set to the first option that SLiM reads from the xsessions directory. This means that system-wide, a DE FACTO DEFAULT SESSION EXISTS and IS DISPLAYED, without having to press \<F1\>. \<F1\> still allows the user to cyle through other options. In SLiM 1.3.6, there is no longer a need to set a specific default in .xinitrc or Xsession, unless using a user-specific default differing from the system-wide one. However, slim-tweak still places a default in the custom Xsession to accomodate newer SLiM versions. A global .xinitrc executable may also be placed as an \<F1\> option in /usr/share/xsessions/. 

As the result of well-meaning patches, for SLiM-fork or SLiM 1.4+, the user must unfortunately press \<F1\> before the default %session is displayed, even though it is set in Xsession. 

Slim-tweak creates a new xsessions directory with empty .desktop files. It then leverages "ls -U" to predict the order that these files will appear in SLiM, and copies contents of original /usr/share/xsession .desktop entries into the new empty files, making sure that the chosen default desktop will be in the first one listed by SLiM. By copying contents, not entire files, the ordering is preserved. Unfortunately, this approach means that slim-tweak must be run again if new desktop entries are added.

## Installation
Copy to desired location included in your $PATH for executables (e.g. **/usr/local/bin** or **/usr/bin**). Make the slim-tweak file executable if needed. The file does not need to be owned by root, but you will need sudo/doas or root access to successfully run it. Run the script by name, "slim-tweak". This is not a GUI program, and must run from a command line in a terminal window, tty, or console.
