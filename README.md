# hmw
Machine readable version of Handbook of the Mammals of the World

:warning: experimental - please use at own risk.

Physical copies of Handbook of the Mammals of the World are a valuable taxonomic resource for mammals.

This repository uses Plazi digitized taxonomic treatment versions of these physical copies to generate [hmw.json](hmw.json),  and [hmw.csv](hmw.csv). For your convenience, the first 10 records can be found [hmw-sample.json](hmw-sample.json), [hmw-sample-pretty.json](hmw-sample-pretty.json) and [hmw-sample.csv](hmw-sample.csv). The json and files are derived from a Preston tracked version of Plazi's treatment bank available via https://github.com/plazi/treatments-xml. You can find a copy of a tracked copy of this in the [Releases](../releases) section of this repository.
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

# Related Data

Please see release attachment ```preston-data.zip``` for underlying data.

# References

```
$ preston history
<urn:uuid:0659a54f-b713-4f86-a917-5be166a14110> <http://purl.org/pav/hasVersion> <hash://sha256/d6da1046ce43d4fc1faf5aae720e29959e3040c9e39c23b146a73388efd2e33d> .
<hash://sha256/42acbae7c1795639c62d2250a0e88b3c701cae09dcaa5decc20dd954686e6811> <http://purl.org/pav/previousVersion> <hash://sha256/d6da1046ce43d4fc1faf5aae720e29959e3040c9e39c23b146a73388efd2e33d> .
<hash://sha256/8afcba2b406223349e3fac8deb089c088c590b44c5ea8a09f6868dca886127c5> <http://purl.org/pav/previousVersion> <hash://sha256/42acbae7c1795639c62d2250a0e88b3c701cae09dcaa5decc20dd954686e6811> .
```

and other content ids include:

```
$ preston ls\
| grep -o -E "hash://sha256/[0-9a-f]{64}"\
| sort\
| uniq
hash://sha256/42acbae7c1795639c62d2250a0e88b3c701cae09dcaa5decc20dd954686e6811
hash://sha256/5146700132c798f057756c6fde84a3d4c426bdc372dbec6ba18ce4125aa8353b
hash://sha256/669b07bf81a1e35383e3d83458751684d7416b0b75f4f425f8476a44b1119f42
hash://sha256/d6da1046ce43d4fc1faf5aae720e29959e3040c9e39c23b146a73388efd2e33d
```
