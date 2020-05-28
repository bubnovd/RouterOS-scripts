:local grafana_addr 127.0.0.1
:local pwd supermegapassword

put "Create CA"
/certificate add common-name=API_CA name=API_CA days-valid=3650
delay 1
execute {/certificate sign API_CA}
for i from=20 to=0 do={put ("Cigning CA. Remain " . $i . "sec..."); delay 1}

put "Create API certificate"
/certificate add common-name=API name=API days-valid=3650
delay 1
execute {/certificate sign API ca=API_CA}
for i from=20 to=0 do={put ("Cigning certificate. Remain " . $i . "sec..."); delay 1}
put "Configure access"
/ip service set certificate=API disabled=no address=$grafana_addr port=8729 API-ssl
/ip firewall filter add chain=input protocol=tcp dst-port=8729 src-address=$grafana_addr action=accept  comment=API_SSL
/ip cloud set ddns-enabled=yes
/user group add name=monitoring comment=grafana.bubnovd.net policy=read,API 
/user add name=monitoring group=monitoring comment=grafana.bubnovd.net password=$pwd address=$grafana_addr
put "All done!"