wireguard:
  pkg.installed: []
  service.running:
    - name: wg-quick@wg0
    - enable: true
    - require:
      - file: /etc/wireguard/wg0.conf
      - pkg: wireguard
    - watch:
      - file: /etc/wireguard/wg0.conf

/etc/wireguard/wg0.conf:
 file.managed:
   - source: salt://wireguard/files/wg0.conf
   - template: jinja
   - require:
     - pkg: wireguard
