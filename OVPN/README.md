OVPN server with certificates for Mikrotik RouterOS
1. Настраиваем RouterOS как OVPN сервер с применением сертификатов
ovpn_server.rsc - config for RouterOS

2. Экспортируем сертификаты для клиентов
export_certificates - export certificates for clients

3. Копируем 3 файла на клиента любым удобным способом: 
cert_export_CA.crt 
cert_export_client1-ovpn.crt 
cert_export_client1-ovpn.key 

4. В папке C:\Program Files\OpenVPN\config создаем файл client1.txt с именем и паролем ppp клиента. Первая строка - name, вторая - пароль

5. Создаем файл client1.ovpn на клиента и запускаем OVPN от имени адмнистратора. Администратор нужен для установки маршрутов

6. Запускаем нужный конфиг

Для создания пользователей используем add_new_client.rsc и повторяем пункты 4-6.

НЕ ЗАБЫВАЕМ УДАЛЯТЬ КЛИЕНТСКИЕ СЕРТИФИКАТЫ ИЗ FILES

Отсюда https://habr.com/post/269679/