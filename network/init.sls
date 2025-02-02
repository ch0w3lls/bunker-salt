# FIXME add rfkill country in raspi-config

bridge-utils:
  pkg.installed

hostapd:
  pkg.installed: []
  service.running:
    - enable: true
    - require:
      - file: /etc/hostapd/hostapd.conf
    - watch:
      - file: /etc/hostapd/hostapd.conf

/etc/hostapd/hostapd.conf:
  file.managed:
    - source: salt://network/files/hostapd.conf

/etc/network/interfaces:
  file.managed:
    - source: salt://network/files/interfaces

ifupdown:
  pkg.installed: []

network-manager:
  pkg.removed: []
