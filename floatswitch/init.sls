/etc/systemd/system/floatswitch.service:
  file.managed:
    - source: salt://floatswitch/files/floatswitch.service

floatswitch:
  service.running:
    - enable: true
    - require:
      - file: /etc/systemd/system/floatswitch.service
      - pkg: python3-rpi.gpio
    - watch:
      - file: /usr/local/bin/floatswitch.py

python3-rpi.gpio:
  pkg.installed: []

/usr/local/bin/floatswitch.py:
  file.managed:
    - source: salt://floatswitch/files/floatswitch.py
    - mode: '0755'
    - template: jinja

/usr/local/bin/sendsms.sh:
  file.managed:
    - source: salt://floatswitch/files/sendsms.sh
    - mode: '0755'
    - template: jinja
    - context:
      numbers: {{ pillar['numbers']|join(" ") }}
