OVPN server with certificates for Mikrotik RouterOS
1. Настраиваем RouterOS как OVPN сервер с применением сертификатов
ovpn_server.rsc - config for RouterOS

2. Экспортируем сертификаты для клиентов
export_certificates - export certificates for clients

3. Копируем 3 файла на клиента любым удобным способом: 
cert_export_CA.crt 
cert_export_client1-ovpn.crt 
cert_export_client1-ovpn.key 

4. Создаем файл client1.ovpn на клиента и запускаем OVPN от имени адмнистратора. Администратор нужен для установки маршрутов

5. Запускаем нужный конфиг

Для создания пользователей используем add_new_client.rsc и повторям пункты 3 и 4