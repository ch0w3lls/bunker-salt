/etc/apt/keyrings/docker.asc:
  file.managed:
    - source: salt://unifi/files/docker.asc
    - makedirs: true

/etc/apt/sources.list.d/docker.list:
  file.managed:
    - source: salt://unifi/files/docker.list

update docker sources:
  cmd.run:
    - name: apt-get update
    - require:
      - file: /etc/apt/keyrings/docker.asc
      - file: /etc/apt/sources.list.d/docker.list

docker packages:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - docker-ce-rootless-extras
      - docker-compose-plugin

start unifi docker:
  cmd.run:
    - name: |
        docker run -d --init \
        --restart=unless-stopped \
        -p 8080:8080 -p 8443:8443 -p 3478:3478/udp \
        -e TZ='Europe/London' \
        -v /unifi:/unifi \
        --user unifi \
        --name unifi \
        jacobalberty/unifi
    - unless: docker ps | grep jacobalberty | grep Up
    - require:
      - pkg: docker packages
