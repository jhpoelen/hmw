#!/bin/bash
#
# Tracks, builds, and converts Handbook of the Mammals of the World (HMW) portion of 
# Plazi's Treatment Bank into HMW specific json, and csv files.
#
#

set -x

function track { 
  preston track https://github.com/plazi/treatments-xml/archive/master.zip
}

function build {
  preston plazi-stream\
| grep "Handbook of the Mammals of the World"\
> hmw.json
}

function convert {
  time cat hmw.json\
| jq -f schema.jq\
| mlr --ijson --ocsv cat\
| tee hmw.csv
}

function create_samples {
  cat hmw.csv\
  | head -n11\
  > hmw-sample.csv
  
  cat hmw.json\
  | head -n10\
  | tee hmw-sample.json\
  | jq .\
  > hmw-sample-pretty.json

  seq 1 9\
  | xargs -L1 -I {} sh -c 'cat hmw.csv | head -n1 > hmw-volume-{}.csv'

  seq 1 9\
  | xargs -L1 -I {} sh -c 'cat hmw.csv | grep "Volume {}" >> hmw-volume-{}.csv'

  cat hmw.json\
  | jq --raw-output .name\
  | sort\
  | uniq\
  > names.txt

}

function check {
  cat hmw.json\
  | ./check.sh\
  | wc -l
}

preston version

time track\
| tee hmw-prov.nq\
| build

convert
create_samples

echo number of records found with unexpected empty field values:
check

