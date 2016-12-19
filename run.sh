#!/bin/bash
echo "Starting InfluxDb......"
#exec /usr/bin/influxd -config /etc/influxdb/influxdb.conf &
#exec influxd &
echo "About to create the Database riemann"
 if [ -f "/var/lib/influxdb/data/riemann" ]; then
         echo "=> Database had been created before, skipping ..."
else
RET=1
        while [[ RET -ne 0 ]]; do
            echo "=> Waiting for confirmation of InfluxDB service startup ..."
            sleep 3
            curl -k http://localhost:8086/ping 2> /dev/null
            RET=$?
        done
        echo "Influx Started"

#sleep 5

#echo "=> Creating admin user"
#influx -host=localhost -port=8086 -execute="CREATE USER root WITH PASSWORD 'root' WITH ALL PRIVILEGES"
echo "=> Creating database: riemann"
             exec  influx -execute 'create database riemann'

fi
