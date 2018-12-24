#generate CA
/certificate add name=template-CA country="" state="" locality="" organization="" unit="" common-name="CA" key-size=4096 days-valid=3650 key-usage=crl-sign,key-cert-sign
#sign CA
/certificate sign template-CA ca-crl-host=127.0.0.1 name="CA"
#generate template for server
/certificate add name=template-SRV country="" state="" locality="" organization="" unit="" common-name="srv-OVPN" key-size=4096 days-valid=1095 key-usage=digital-signature,key-encipherment,tls-server
#sign server certificate
/certificate sign template-SRV ca="CA" name="srv-OVPN"
#template for clients
/certificate add name=template-CL country="" state="" locality="" organization="" unit="" common-name="client-ovpn-template" key-size=4096 days-valid=365 key-usage=tls-client
#certificate for client
/certificate add name=client1 copy-from="client1" common-name="client1-ovpn"
/certificate sign client1 ca="CA" name="client1-ovpn"

#pool for clients
/ip pool add name=pool-ovpn ranges=10.129.0.11-10.129.0.254
#ppp profile for OVPN
/ppp profile add name=OVPN_server local-address=10.129.0.1 remote-address=pool-ovpn
#?????
#/ppp aaa set accounting=yes
#add user
/ppp secret add name=client1 password=P@ssword1 service=ovpn profile=OVPN_server
#enable OVPN server
/interface ovpn-server server set auth=sha1 cipher=blowfish128 default-profile=OVPN_server mode=ip netmask=24 require-client-certificate=yes certificate=srv-OVPN enabled=yes
