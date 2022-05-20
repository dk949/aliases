#!/bin/sh
alias rg="rg --hidden --ignore-case -g "'!.git'

alias rootrg="rg\
    -g '!**/*dbus*/**'\
    -g '!**/*gnupg*/**'\
    -g '!**/*gpg*/**'\
    -g '!**/*grub*/**'\
    -g '!**/*polkit*/**'\
    -g '!**/*ssh*/**'\
    -g '!**/*sudo*/**'\
    -g '!**/*systemd*/**'\
    -g '!**/*vpn*/**'\
    -g '!**/tmp/systemd-private*'\
    -g '!/dev'\
    -g '!/etc/*shadow*'\
    -g '!/etc/NetworkManager/system-connections'\
    -g '!/etc/audit'\
    -g '!/etc/crypttab'\
    -g '!/etc/default/useradd'\
    -g '!/etc/libaudit*'\
    -g '!/etc/samba/private'\
    -g '!/etc/sudoers*'\
    -g '!/etc/ufw'\
    -g '!/lost+found'\
    -g '!/proc'\
    -g '!/root/'\
    -g '!/run'\
    -g '!/sys'\
    -g '!/usr/bin/augenrules'\
    -g '!/usr/share/factory'\
    -g '!/usr/share/ufw'\
    -g '!/var/cache'\
    -g '!/var/db'\
    -g '!/var/lib'\
    -g '!/var/log/audit'\
    -g '!/var/log/btmp'\
    -g '!/var/log/private'\
    -g '!/var/log/samba'\
    "
