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
  time preston ls\
| preston plazi-stream\
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

  cat hmw.json\
  | jq --raw-output .name\
  | sort\
  | uniq\
  > names.txt

}

preston version

track
build
convert
create_samples

