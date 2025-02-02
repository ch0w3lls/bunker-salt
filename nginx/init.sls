nginx:
  pkg.installed: []
  service.running:
    - enable: true
    - require:
      - file: /etc/nginx/sites-enabled/default
    - watch:
      - file: /etc/nginx/sites-enabled/default

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://nginx/files/default
  
/var/www/html:
  file.recurse:
    - source: salt://nginx/files/html
