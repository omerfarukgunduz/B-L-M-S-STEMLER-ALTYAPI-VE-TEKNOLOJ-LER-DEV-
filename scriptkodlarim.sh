#!/bin/bash

hostname=localhost
kullaniciVeDb=postgres

inotifywait -m -e create -e delete --format '%e %f' /home/ubuntu/Masaüstü/bsm | while read file; do

  now=$(date -Iseconds)

  if [[ $file = "CREATE" ]]; then

    psql -h $hostname -U $kullaniciVeDb -d $kullaniciVeDb -c "INSERT INTO tablo1 (name, tarih) VALUES ('$(echo "$file" | cut -d' ' -f2)', '$now');"

  elif [[ $file = "DELETE" ]]; then

    psql -h $hostname -U $kullaniciVeDb -d $kullaniciVeDb -c "UPDATE tablo1 SET deleted=true, silinme_tarihi='$now' WHERE name='$(echo "$file" | cut -d' ' -f2)';"
  fi
done
