/ip firewall address-list
add address=0.0.0.0/8 list=bogons
add address=10.0.0.0/8 list=bogons
add address=100.64.0.0/10 list=bogons
add address=127.0.0.0/8 list=bogons
add address=169.254.0.0/16 list=bogons
add address=172.16.0.0/12 list=bogons
add address=192.0.0.0/24 list=bogons
add address=192.0.2.0/24 list=bogons
add address=192.168.0.0/16 list=bogons
add address=198.18.0.0/15 list=bogons
add address=198.51.100.0/24 list=bogons
add address=203.0.113.0/24 list=bogons
add address=224.0.0.0/3 list=bogons
add address=192.168.120.0/24 list=LAN
add address=10.0.16.0/24 list=VPN
add address=192.168.0.0/16 list=NET
add address=192.168.11.1 list=ftp_open
add address=192.168.11.1 list=snmp_allow


/ip firewall filter
add action=accept chain=input comment="<---------------------------------------------------------------------------------------------------------------- ---------INPUT------------------------------------------------------------------------------------------------------------------------->" disabled=yes
add action=accept chain=input comment="established, related"      connection-state=established,related
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=drop chain=input comment=DNS dst-port=53 in-interface-list=WAN protocol=udp
add action=drop chain=input comment="drop netbios" dst-port=137 protocol=udp
add action=drop chain=input dst-port=138 protocol=udp
add action=drop chain=input comment=HASP dst-port=1947 protocol=udp
add action=drop chain=input comment="drop broadcast src" src-address-type=broadcast
add action=drop chain=input comment="drop multicast src" src-address-type=multicast
add action=drop chain=input comment="drop bogons" in-interface-list=WAN src-address-list=bogons
add action=drop chain=input comment="drop large" disabled=yes log=yes log-prefix=LLL packet-size=!0-1500
add action=drop chain=input comment=bfd disabled=yes dst-port=3784 in-interface-list=WAN protocol=udp
add action=drop chain=input comment="drop ssh brute forcers" src-address-list=ssh_blacklist
add action=add-src-to-address-list address-list=ssh_blacklist address-list-timeout=1w3d chain=input connection-state=new dst-port=22 protocol=tcp src-address-list=ssh_stage3
add action=add-src-to-address-list address-list=ssh_stage3 address-list-timeout=1m chain=input connection-state=new dst-port=22 protocol=tcp src-address-list=ssh_stage2
add action=add-src-to-address-list address-list=ssh_stage2 address-list-timeout=1m chain=input connection-state=new dst-port=22 protocol=tcp src-address-list=ssh_stage1
add action=add-src-to-address-list address-list=ssh_stage1 address-list-timeout=1m chain=input connection-state=new dst-port=22 protocol=tcp src-address-list=!ssh_open
add action=accept chain=input dst-port=22 protocol=tcp
add action=accept chain=input comment=ospf protocol=ospf src-address-list=NET
add action=accept chain=input comment=bfd dst-port=3784 protocol=udp src-address-list=NET
add action=accept chain=input comment=ftp dst-port=21 protocol=tcp src-address-list=ftp_open
add action=accept chain=input comment=icmp protocol=icmp
add action=accept chain=input comment=ssl disabled=yes dst-port=443 protocol=tcp
add action=accept chain=input comment=web dst-port=80 protocol=tcp src-address-list=NET
add action=accept chain=input comment=ntp dst-port=123 protocol=udp src-address-list=NET
add action=accept chain=input comment=traceroute dst-port=33343 protocol=udp src-address-list=NET
add action=accept chain=input comment=winbox dst-port=8291 protocol=tcp
add action=accept chain=input comment=OLD port=1701,500,4500 protocol=udp
add action=accept chain=input comment="IPSEC ESP" protocol=ipsec-esp
add action=accept chain=input comment=ipsec dst-port=500,4500 protocol=udp
add action=accept chain=input comment=l2tp dst-port=1701 in-interface-list=WAN protocol=udp
add action=accept chain=input comment="Winbox MAC" dst-port=20561 in-interface-list=!WAN protocol=udp
add action=accept chain=input comment=snmp dst-port=161 protocol=udp src-address-list=DataCenter
add action=accept chain=input dst-port=161 protocol=tcp src-address-list=DataCenter
add action=accept chain=input comment=dhcp dst-port=67 in-interface-list=!WAN protocol=udp
add action=accept chain=input dst-port=68 in-interface-list=!WAN protocol=udp
add action=accept chain=input comment=dns dst-port=53 protocol=udp src-address-list=LAN
add action=accept chain=input comment=CAPWAP dst-port=5246 protocol=udp src-address-list=LAN
add action=accept chain=input dst-port=5247 protocol=udp src-address-list=LAN
add action=drop chain=input comment=neighbour dst-port=5678 in-interface-list=WAN protocol=udp
add action=accept chain=input dst-port=5678 protocol=udp
add action=accept chain=input disabled=yes dst-port=3784 protocol=udp
add action=drop chain=input comment="drop all"
add action=accept chain=input comment="<------------------------------------------------------------------------------------------------------------------------INPUT------------------------------------------------------------------------------------------------------------------------->" disabled=yes
