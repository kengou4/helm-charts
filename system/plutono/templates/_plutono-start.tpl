#!/bin/bash

function process_config {

  mkdir /var/lib/plutono/etc
  cp /plutono-etc/plutono.ini /var/lib/plutono/etc/plutono.ini
  cp /plutono-etc/ldap.toml /var/lib/plutono/etc/ldap.toml

}

function start_application {

  # Set cluster region
  export CLUSTER_REGION={{.Values.global.region}}
  # Set Plutono admin/local username & password
  export PL_SECURITY_ADMIN_USER={{.Values.plutono.admin.user}}
  export PL_SECURITY_ADMIN_PASSWORD={{.Values.plutono.admin.password}}
  export PLUTONO_LOCAL_USER={{.Values.plutono.local.user}}
  export PLUTONO_LOCAL_PASSWORD={{.Values.plutono.local.password}}

  # install some pluginsa - this is just for reference as external plugins do not work with plutono and we will most probably drop them
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/agenty-flowcharting-panel-0.9.1.zip -O /tmp/agenty-flowcharting-panel-0.9.1.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/agenty-flowcharting-panel-0.9.1.zip; rm -f /tmp/agenty-flowcharting-panel-0.9.1.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/blackmirror1-statusbygroup-panel-1.1.2.zip -O /tmp/blackmirror1-statusbygroup-panel-1.1.2.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/blackmirror1-statusbygroup-panel-1.1.2.zip; rm -f /tmp/blackmirror1-statusbygroup-panel-1.1.2.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/briangann-datatable-panel-1.0.3.zip -O /tmp/briangann-datatable-panel-1.0.3.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/briangann-datatable-panel-1.0.3.zip; rm -f /tmp/briangann-datatable-panel-1.0.3.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/digrich-bubblechart-panel-1.2.1.zip -O /tmp/digrich-bubblechart-panel-1.2.1.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/digrich-bubblechart-panel-1.2.1.zip; rm -f /tmp/digrich-bubblechart-panel-1.2.1.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/flant-statusmap-panel-0.5.1.zip -O /tmp/flant-statusmap-panel-0.5.1.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/flant-statusmap-panel-0.5.1.zip; rm -f /tmp/flant-statusmap-panel-0.5.1.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/grafana-piechart-panel-1.6.4.zip -O /tmp/grafana-piechart-panel-1.6.4.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/grafana-piechart-panel-1.6.4.zip; rm -f /tmp/grafana-piechart-panel-1.6.4.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/grafana-worldmap-panel-1.0.3.zip -O /tmp/grafana-worldmap-panel-1.0.3.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/grafana-worldmap-panel-1.0.3.zip; rm -f /tmp/grafana-worldmap-panel-1.0.3.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/jdbranham-diagram-panel-1.7.3.zip -O /tmp/jdbranham-diagram-panel-1.7.3.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/jdbranham-diagram-panel-1.7.3.zip; rm -f /tmp/jdbranham-diagram-panel-1.7.3.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/marcusolsson-json-datasource-1.3.2.zip -O /tmp/marcusolsson-json-datasource-1.3.2.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/marcusolsson-json-datasource-1.3.2.zip; rm -f /tmp/marcusolsson-json-datasource-1.3.2.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/natel-discrete-panel-0.1.1.zip -O /tmp/natel-discrete-panel-0.1.1.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/natel-discrete-panel-0.1.1.zip; rm -f /tmp/natel-discrete-panel-0.1.1.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/vonage-status-panel-1.0.11.zip -O /tmp/vonage-status-panel-1.0.11.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/vonage-status-panel-1.0.11.zip; rm -f /tmp/vonage-status-panel-1.0.11.zip)
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/yesoreyeram-boomtable-panel-1.4.1.zip -O /tmp/yesoreyeram-boomtable-panel-1.4.1.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/yesoreyeram-boomtable-panel-1.4.1.zip; rm -f /tmp/yesoreyeram-boomtable-panel-1.4.1.zip)
  ## install sapcc/grafana-prometheus-alertmanager-datasource
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/grafana_prometheus_alertmanager_datasource-master.zip -O /tmp/grafana_prometheus_alertmanager_datasource-master.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/grafana_prometheus_alertmanager_datasource-master.zip; rm -f /tmp/grafana_prometheus_alertmanager_datasource-master.zip)
  ## install sapcc/Grafana_Status_panel
  #wget -nv https://repo.eu-de-1.cloud.sap/grafana-plugins/grafana_status_panel-master.zip -O /tmp/grafana_status_panel-master.zip
  #(cd /var/lib/plutono/plugins; unzip /tmp/grafana_status_panel-master.zip; rm -f /tmp/grafana_status_panel-master.zip)
  #echo "installed plugins:"
  #plutono-cli plugins ls

  # setup the datasources and dashboards if the setup script exists
  # wait a moment until plutono is up and write to stdout and logfile in parallel
  if [ -f /plutono-bin/plutono-initial-setup ]; then
  # no ss commnd in the new plutono container, so we have to use curl to check ...
  #  (while ss -lnt | awk '$4 ~ /:{{.Values.plutono.port.public}}$/ {exit 1}'; do sleep 5; done; bash /plutono-bin/plutono-initial-setup ) 2>&1 | tee /var/log/plutono/initial-setup.log &
  # no curl commnd in the new plutono container, so we have to use wget to check ...
  #  (while [ `curl -s http://localhost:3000 > /dev/null ; echo $?` != "0" ]; do sleep 5; done; bash /plutono-bin/plutono-initial-setup ) 2>&1 | tee /var/log/plutono/initial-setup.log &
    (while ! wget -q -O /dev/null http://localhost:3000; do sleep 5; done; bash /plutono-bin/plutono-initial-setup ) 2>&1 | tee /var/log/plutono/initial-setup.log &
  fi
  while [ ! -d /git/plutono-content/datasources-config ]; do
    echo "waiting 5 more seconds for the plutono-content to be mounted and synced via git-sync ..."
    sleep 5
  done
  # create an auto provisioning dir for plutono and copy the content from the git to it
  # the cp is required in order to be able to modify the datasources below, the dashboard
  # config references back to the dashboard-sources dir in the git repo directly
  mkdir -p /var/lib/plutono/provisioning
  # do not do the above if the are in author more - then we do not provision anything
  # TODO: without dashboards initially
  #if [ "{{.Values.plutono.mode}}" != "author" ]; then
  #  rm -rf /var/lib/plutono/provisioning/dashboards
  #  cp -r /git/plutono-content/dashboards-config-{{.Values.plutono.mode}} /var/lib/plutono/provisioning/dashboards
  #fi
  rm -rf /var/lib/plutono/provisioning/datasources
  mkdir -p /var/lib/plutono/provisioning/datasources
  cd /git/plutono-content/datasources-config
  for i in * ; do
    grep -qw "    tlsAuthWithCACert: true" $i
    ADD_CERTS_YN_LC=$?
    grep -qw "    tlsAuthWithCACert: True" $i
    ADD_CERTS_YN_UC=$?
    if [ "$ADD_CERTS_YN_LC" = "0" ] || [ "$ADD_CERTS_YN_UC" = "0" ]; then
      cat $i | grep -v "json object of data that will be encrypted" | grep -v secureJsonData > /var/lib/plutono/provisioning/datasources/$i
      echo "  # <string> json object of data that will be encrypted." >> /var/lib/plutono/provisioning/datasources/$i
      echo "  secureJsonData:" >> /var/lib/plutono/provisioning/datasources/$i
      if [ -f /plutono-secrets/cacert.crt ]; then
        echo '    tlsCACert: |' >> /var/lib/plutono/provisioning/datasources/$i
        cat /plutono-secrets/cacert.crt | sed 's/^/      /' >> /var/lib/plutono/provisioning/datasources/$i
      fi
      if [ -f /plutono-secrets/sso.crt ]; then
        echo '    tlsClientCert: |' >> /var/lib/plutono/provisioning/datasources/$i
        cat /plutono-secrets/sso.crt | sed 's/^/      /' >> /var/lib/plutono/provisioning/datasources/$i
      fi
      if [ -f /plutono-secrets/sso.key ]; then
        echo '    tlsClientKey: |' >> /var/lib/plutono/provisioning/datasources/$i
        cat /plutono-secrets/sso.key | sed 's/^/      /' >> /var/lib/plutono/provisioning/datasources/$i
      fi
    else
      cp -a $i /var/lib/plutono/provisioning/datasources
    fi
  done
  sed -i 's,__ELK_PASSWORD__,{{.Values.authentication.elk_password}},g' /var/lib/plutono/provisioning/datasources/*
  sed -i 's,__METISDB_PASSWORD__,{{.Values.authentication.metisdb_password}},g' /var/lib/plutono/provisioning/datasources/*
  sed -i 's,__OPENSEARCH_PASSWORD__,{{.Values.authentication.opensearch_password}},g' /var/lib/plutono/provisioning/datasources/*
  sed -i 's,__ALERTMANAGER_PASSWORD__,{{.Values.alertmanager.password}},g' /var/lib/plutono/provisioning/datasources/*
  sed -i 's,__PROMETHEUS_REGION__,{{.Values.global.region}},g' /var/lib/plutono/provisioning/datasources/*

  cd /usr/share/plutono
  exec /usr/share/plutono/bin/plutono-server -config /var/lib/plutono/etc/plutono.ini --homepath /usr/share/plutono cfg:default.log.mode=console
}

process_config

start_application
