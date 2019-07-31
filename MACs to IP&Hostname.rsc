foreach v in=[/ip arp find] do={ \
put [/ip arp get $v address]; \
put [/ip arp get $v mac-address]; \
if ([len [/ip dhcp-server lease find where active-mac-address=[/ip arp get $v mac-address]]] >0) do={ \
:put [/ip dhcp-server lease get [find where active-mac-address=[/ip arp get $v mac-address]] host-name]}; \
put "================"}