{
:log info "Starting Backup Script...";
:local sysname [/system identity get name];
:local sysver [/system package get system version];
:log info "Flushing DNS cache...";
/ip dns cache flush;
:delay 2;
:log info "Deleting last Backups...";
:foreach i in=[/file find] do={:if ([:typeof [:find [/file get $i name] "$sysname-backup-"]]!="nil") do={/file remove $i}};
:delay 2;
:local smtpserv [:resolve "smtp.yandex.ru" server=8.8.8.8];
:local Eaccount "backup@mikrotik-ninja.ru"; #YOUR MAILBOX FOR SEND EMAIL
:local pass "bubnovd.net"; #PASSWORD FOR MAILBOX
:local mailto "backup-inbox@mikrotik-ninja.ru"; #YOUR MAILBOX FOR RECEIVE BACKUPS
:local encr "bubnovd.net"; #PASSWORD FOR BACKUP ENCRYPTION
:local backupfile ("$sysname-backup-" . [:pick [/system clock get date] 7 11] . [:pick [/system clock get date] 0 3] . [:pick [/system clock get date] 4 6] . ".backup");
:log info "Creating new Full Backup file...";
/system backup save name=$backupfile encryption=aes-sha256 password=$encr;
:delay 2;
:log info "Sending Full Backup file via E-mail...";
/tool e-mail send from="<$Eaccount>" to=$mailto server=$smtpserv port=587 user=$Eaccount password=$pass start-tls=yes file=$backupfile subject=("$sysname Full Backup (" . [/system clock get date] . ")") body=("$sysname full Backup file see in attachment.\nRouterOS version: \$sysver\nTime and Date stamp: " . [/system clock get time] . " " . [/system clock get date]);
:delay 5;
:local exportfile ("$sysname-backup-" . [:pick [/system clock get date] 7 11] . [:pick [/system clock get date] 0 3] . [:pick [/system clock get date] 4 6] . ".rsc");
:log info "Creating new Setup Script file...";
/export verbose file=$exportfile;
:delay 2;
:log info "Sending Setup Script file via E-mail...";
/tool e-mail send from="<$Eaccount>" to=$mailto server=$smtpserv port=587 user=$Eaccount password=$pass start-tls=yes file=$exportfile subject=("$sysname Setup Script Backup (" . [/system clock get date] . ")") body=("$sysname Setup Script file see in attachment.\nRouterOS \version: $sysver\nTime and Date stamp: " . [/system clock get time] . " \
" . [/system clock get date]);
:delay 5;
:log info "All System Backups emailed successfully.\nBackuping completed.";
}
