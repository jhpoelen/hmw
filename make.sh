#!/bin/bash
#
# Tracks, builds, and converts Handbook of the Mammals of the World (HMW) portion of 
# Plazi's Treatment Bank into HMW specific json, and csv files.
#
#

set -x

function track { 
  # get the recent version of Plazi's treatments in xml format from https://tb.plazi.org/dumps
  preston track \
   https://tb.plazi.org/dumps/plazi.xml.zip \
   https://tb.plazi.org/dumps/plazi.xml.monthly.zip \
   https://tb.plazi.org/dumps/plazi.xml.weekly.zip \
   https://tb.plazi.org/dumps/plazi.xml.daily.zip
}

function build {
  # convert a versioned copy of Plazi's Treatments-XML into JSON (Javascript Object Notation)
  preston plazi-stream \
  | grep "Handbook of the Mammals of the World"\
  > hmw-old-and-current.json
}

function keep_newest {
  # treatments may have been updated in monthly/ weeky/ daily dumps
  # keep only the most recent version to avoid outdated treatments
  cat hmw-old-and-current.json \
    | jq --raw-output .docId \
    | sort \
    | uniq -c \
    | sort -nr \
    | grep -Ev "^[ ]+1" \
    | grep -Eo '[A-F0-9]{3,}' \
    | sort \
    | uniq \
    > docIds-with-updates.txt

  cat docIds-with-updates.txt \
    | xargs -I{} sh -c 'cat hmw.json | grep {} | tail -1' \
    > hmw.json

  cat hmw-old-and-current.json \
    | grep -v -f docIds-with-updates.txt \
    >> hmw.json
}

function convert {
  # converts Preston generated json into tabular csv
  time cat hmw.json\
    | jq -f schema.jq\
    | mlr --ijson --ocsv cat\
    > hmw.csv
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
    | xargs -I{} sh -c 'cat hmw.csv | head -n1 > hmw-volume-{}.csv'

  seq 1 9\
    | xargs -I {} sh -c 'cat hmw.csv | grep "Volume {}" >> hmw-volume-{}.csv'

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

time track

preston head\
  | preston cat\
  | tee hmw-prov.nq\
  | build

keep_newest
convert
create_samples

echo number of records found with unexpected empty field values:
check

