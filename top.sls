install_apache:
  pkg.installed:
    - name: apache2

apache_service:
  service.running:
    - name: apache2
    - require:
      - pkg: install_apache
