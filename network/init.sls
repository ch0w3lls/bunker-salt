# FIXME add rfkill country in raspi-config

bridge-utils:
  pkg.installed

wifi country GB:
  cmd.run:
    - name: raspi-config nonint do_wifi_country GB
    - unless: raspi-config nonint get_wifi_country | grep GB

unmask_hostapd:
  cmd.run:
    - name: systemctl unmask hostapd
    - onlyif: systemctl status hostapd | grep -q "masked"
    - require:
      - pkg: hostapd

hostapd:
  pkg.installed: []
  service.running:
    - enable: true
    - require:
      - file: /etc/hostapd/hostapd.conf
    - watch:
      - file: /etc/hostapd/hostapd.conf
    - require:
      - cmd: wifi country GB
      - cmd: unmask_hostapd

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
