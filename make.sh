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

preston version

track
build
convert
