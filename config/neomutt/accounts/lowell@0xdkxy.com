# vim: filetype=muttrc
set my_pass="`pass outlook/lowell@0xdkxy.com`"

unmailboxes *

set ssl_starttls = yes
set ssl_force_tls = yes
set realname = "HAOYU LI"
set imap_user="lowell@0xdkxy.com"
set imap_pass=$my_pass
set smtp_url="smtp://$imap_user@smtp-mail.outlook.com:587"
set smtp_pass=$my_pass
# set smtp_authenticators="gssapi:login"
set folder = imaps://imap-mail.outlook.com:993
set spoolfile=+INBOX

set from = "lowell@0xdkxy.com"
set envelope_from
set use_from = "yes"
set record="+Sent"
set trash = "+Trash"
set postponed="+Drafts"
set mail_check = 100

# Allow Mutt to open a new IMAP connection automatically.
unset imap_passive

# Keep the IMAP connection alive by polling intermittently (time in seconds).
set imap_keepalive = 300

## Hook -- IMPORTANT!
account-hook $folder "set imap_pass=$my_pass"


# You can use any gmail imap mailboxes
# mailboxes =INBOX =[Gmail]/Sent\ Mail =[Gmail]/Drafts =[Gmail]/Spam =[Gmail]/Trash

