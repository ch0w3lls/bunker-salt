/usr/share/keyrings/cloudflare-main.gpg:
  file.managed:
    - source: salt://cloudflared/files/cloudflare-main.gpg
    - makedirs: true

/etc/apt/sources.list.d/cloudflared.list:
  file.managed:
    - source: salt://cloudflared/files/cloudflared.list

update cloudflared sources:
  cmd.run:
    - name: apt-get update
    - require:
      - file: /usr/share/keyrings/cloudflare-main.gpg
      - file: /etc/apt/sources.list.d/cloudflared.list
    
cloudflared:
  pkg.installed: []
  service.running:
    - enable: true
    - require:
      - cmd: update cloudflared sources
