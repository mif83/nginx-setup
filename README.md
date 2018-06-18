### Instruction

- Install nginx
- Replace files `/etc/nginx`
- Create root certificate `$ sudo /etc/nginx/admin/createRoot.sh`, after creating, add file root in `/etc/nginx/ssl/`
- in Google Chrome follow the link `chrome://settings/certificates`, Select tab `authorites`, Push `import` and import root certificate
- add user for nginx `$ sudo adduser --system --no-create-home --group --disabled-login --disabled-password nginx`
- add domain and automatic add domain to hosts `$ sudo /etc/nginx/admin/add.sh`, enter domain name and port
