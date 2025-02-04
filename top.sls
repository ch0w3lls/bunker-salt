# install salt
# https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/linux-deb.html

# check out to /srv/salt
# check out pillars to /srv/pillar
# sudo salt-call --local state.apply

base:
  '*':
    - general
    - network
    - nginx
    - floatswitch
    - unifi
    - cloudflared
    - wireguard
