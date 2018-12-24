#generate new certificate
/certificate add name=clientN copy-from="client1" common-name="clientN-ovpn"
#sign certificate
/certificate sign clientN ca="CA" name="clientN-ovpn"
#add new client
/ppp secret add name=clientN password=P@sswordN service=ovpn profile=OVPN_server
#export certificate
/certificate export-certificate client1-ovpn export-passphrase=private-key-passwordN




