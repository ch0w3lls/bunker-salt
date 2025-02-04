nano:
  pkg.removed

vim:
  pkg.installed

screen:
  pkg.installed

/home/chris/.ssh/bunker:
  file.managed:
    - contents_pillar: ssh_private
    - mode: '0600'

/home/chris/.ssh/bunker.pub:
  file.managed:
    - contents_pillar: ssh_public
