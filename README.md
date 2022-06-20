# hmw
Machine readable version of Handbook of the Mammals of the World

:warning: experimental - please use at own risk.

Physical copies of Handbook of the Mammals of the World are a valuable taxonomic resource for mammals.

This repository uses Plazi digitized versions of these physical copies to generate [hmw.json](hmw.json),  and [hmw.csv](hmw.csv). For your convenience, the first 10 records can be found [hmw-sample.json](hmw-sample.json), [hmw-sample-pretty.json](hmw-sample-pretty.json) and [hmw-sample.csv](hmw-sample.csv). The json and files are derived from a Preston tracked version of Plazi's treatment bank available via https://github.com/plazi/treatments-xml. You can find a copy of a tracked copy of this in the [Releases](../releases) section of this repository.
The csv files are generated using  [jq](https://stedolan.github.io/jq/) using [schema.jq](schema.jq) and Miller (https://miller.readthedocs.io/en/latest/). 


```bash
function track { 
  preston track https://github.com/plazi/treatments-xml/archive/master.zip
}

function build {
  time preston ls\
| preston plazi-stream\
| grep "Handbook of the Mammals of the World"\
| gzip\
> hmw.json.gz
}

function convert {
  time cat hmw.json.gz\
| gunzip\
| jq -f schema.jq\
| mlr --ijson --ocsv cat\
| tee hmw.csv
}
```
