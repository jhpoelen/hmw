# hmw
Machine readable version of Handbook of the Mammals of the World

:warning: experimental - please use at own risk.

[`methods`](#methods) / [`results`](#results) / [`summary statistics`](#summary-statistics) / [`example record`](#example-record) / [`R example`](#r-example) / [`funding`](#funding) / [`references`](#references)

Physical copies of Handbook of the Mammals of the World are a valuable taxonomic resource for mammals. This repository uses Plazi digitized taxonomic treatment versions of these physical copies to generate [hmw.json](hmw.json),  and [hmw.csv](hmw.csv). For your convenience, the first 10 records can be found [hmw-sample.json](hmw-sample.json), [hmw-sample-pretty.json](hmw-sample-pretty.json) and [hmw-sample.csv](hmw-sample.csv). The json and files are derived from a Preston tracked version of Plazi's treatment bank available via https://github.com/plazi/treatments-xml. You can find a copy of a tracked copy of this in the [Releases](../releases) section of this repository.

This work originates from the Biodiversity Data Hub working group of the CETAF Covid19 . For more information see https://globalbioticinteractions.org/covid19 .


# Methods

The csv and json files are roughly generated via:

```
# get the recent version of Plazi's treatments in xml format from https://tb.plazi.org/dumps
preston track https://tb.plazi.org/dumps/plazi.xml.zip https://tb.plazi.org/dumps/plazi.xml.monthly.zip https://tb.plazi.org/dumps/plazi.xml.weekly.zip  https://tb.plazi.org/dumps/plazi.xml.daily.zip

# transform only HMW treatments into json using preston
preston ls | preston plazi-stream | grep "Handbook of the Mammals of the World" > hmw.json 

# convert json into csv
cat hmw.json | [some magic] > hmw.csv
```

The csv files are generated using [jq](https://stedolan.github.io/jq/) using [schema.jq](schema.jq) and Miller (https://miller.readthedocs.io/en/latest/). 

See [make.sh](make.sh) for more details on how these files were generated. 

If you'd like you can generate your own files by running make.sh after installing the dependencies [preston](https://github.com/bio-guoda/preston), [jq](https://stedolan.github.io/jq/), and Miller (https://miller.readthedocs.io/en/latest/).

# Results

The following results were generated on 2022-07-20 :

| filename | description | contentId |
| --- | --- | --- |
| names.txt | all included species name in alphabetical order | hash://sha256/333a1ee211077efdcf282989ff9f5212409faa1a62e28f947fe19351e70d6794 | 
| [hmw.csv](hmw.csv) | all extracted mammal descriptions in comma-separated values (CSV) | hash://sha256/987bed74c31a206a515f8ea5551ada5660577e88521886dc6cf71d1f30280299 | 
| [hmw.json](hmw.json) | extracted mammal description in [line-json](https://en.wikipedia.org/wiki/JSON_streaming#Line-delimited_JSON) | hash://sha256/96883965cce8729ec087d0c2587dc9f527054b2cee0585a4f7f32394fd46e6af
| [hmw-sample.csv](hmw-sample.csv) | header + first 10 records | hash://sha256/7bb19ea2496a9175d45a427c9ceab985bc9dc2cdc60f031923c42d5ac6bfca83
| [hmw-sample.json](hmw-sample.json) | first 10 [line-json](https://en.wikipedia.org/wiki/JSON_streaming#Line-delimited_JSON) records | hash://sha256/7bb19ea2496a9175d45a427c9ceab985bc9dc2cdc60f031923c42d5ac6bfca83 
| [hmw-sample-pretty.json](hmw-sample-pretty.json) | first 10 json record pretty printed | hash://sha256/7bb19ea2496a9175d45a427c9ceab985bc9dc2cdc60f031923c42d5ac6bfca83

# Summary Statistics

[hmw.csv](hmw.csv) contains 6218 lines, including the header. This suggests that the hmw.csv contains at most 6217 mammal species descriptions, but probably less, because higherlevel taxa are also included as individual records. 

# Example Record

An example record describing _Rhinolophus sinicus_ generated using:

```
cat hmw.json | grep "Rhinolophus sinicus" | jq . 
```

is shown below in JSON format:

```json
{
  "http://www.w3.org/ns/prov#wasDerivedFrom": "zip:hash://sha256/15afc61b5914e4b6899b43a5eda355497d5c5d0c4b401c884c8056f418c9665b!/treatments-xml-main/data/88/58/87/885887A2FFE18A06F899F4EFF9BFD35B.xml",
  "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": "application/plazi+xml",
  "docId": "885887A2FFE18A06F899F4EFF9BFD35B",
  "docName": "hbmw_9_Rhinolophidae.pdf.imf",
  "docOrigin": "Handbook of the Mammals of the World – Volume 9 Bats, Lynx Edicions",
  "docMasterId": "hash://md5/7461ffdaffcf8a29ffccffa1ff85d963",
  "docISBN": "978-84-16728-19-0",
  "docPageNumber": "325",
  "verbatimText": "93 . Chinese Rufous Horseshoe Bat Rhinolophus sinicus French: Rhinolophe de Chine I German: Rotbraune. China-Hufeisennase / Spanish: Herradura rufo de China Other common names: Chinese Horseshoe Bat, Little Nepalese Horseshoe Bat Taxonomy. Rhinolophus rouxi [sic] sinicus K. Andersen, 1905 , “ Chin Tah , Anhwei [= Anhui Province ], Lower Yangtse [River ],” China . Rhinolophus sinicus is included in the rouxii species group and appears to be sister to R. thomasi . True R. sinicus is composed of three genetic lineages in the eastern, central, and Hainan portion ofits distribution while R.s. septentrionalis is sister to. thomasi , suggesting that the former is distinct at the species level. Rhinolophus sinicus was previously included in R rouxii , but shows substantial morphological, genetic, and karyological differences. There appears to be some ambiguity regarding the distribution of this species and R rouxii in published records: north Indian records previously attributed to. rouxii are now considered to refer to R.sinicus . There may also be some ambiguity regarding the distribution of this species in South-east Asia, as it is often confused with R. thomasi . Validity of races needs to be tested. Two subspecies are currently recognized, although they likely represent two distinct species, pending further revision. Subspecies and Distribution. R . s. sinicus K .Andersen, 1905 - N India ( Himachal Pradesh , Uttarakhand , Sikkim , West Bengal , Meghalaya , Arunachal Pradesh , and Nagaland ), Nepal , N Myanmar ,, S & SE China ( Xizang , Sichuan , Guizhou , Hubei , Jiangsu , Anhui , Zhejiang , Fujian , Guangdong , and Hainan I), and N & C Vietnam . On following pages: 94. Thomas's Horseshoe Bat ( Rhinolophus thomasi ); 95. Lesser Horseshoe Bat ( Rhinolophus hipposideros ); 96. rancis's Woolly Horseshoe Bat ( Rhinolophus trancisi); 97. Lesser Woolly Horseshoe Bat ( Rhinolophus sedulus ); 98. Trefoil Horseshoe Bat ( Rhinolophus trifoliatus ); 99. Northern Woolly Horseshoe Bat ( Rhinolophus perniger ); 100. Selangor Woolly Horseshoe Bat ( Rhinolophus luctoides ); 101. Malaysian Woolly Horseshoe Bat ( Rhinolophus mono ); 102. Great Woolly Horseshoe Bat ( Rhinolophus luctus ); 1.03. Beddome's Woolly Horseshoe Bat ( Rhinolophus beddomei ); 104. Formosan Woolly Horseshoe Bat ( Rhinolophus formosaë ); 105. Thailand Horseshoe Bat ( Rhinolophus thailandensis ); 106. Dobson's Horseshoe Bat ( Rhinolophus yunanensis ); 107. Chiew Kwee's Horseshoe Bat ( Rhinolophus chiewkweeae ); 108. Pearson's Horseshoe Bat ( Rhinolophus pearsonii ); 109. Mitred Horseshoe Bat ( Rhinolophus mitratus ). R .s. septentrionalis Sanborn , 1939 — S China ( Yunnan ). Descriptive notes. Head-body 43-53' 5 mm , tail 21- 5—30 mm , ear 15- 8-20 mm , hindfoot 7- 5-10 mm , forearm 43-56 mm ; weight 8-9-10- 9 g . Dorsal pelage is wood brown, occasionally with reddish tint; ventral pelage is slightly lighter. Ears are small. Noseleaf has hastate lancet that constricts before variably long to short tip; connecting process is rounded, as in the Indian Rufous Horseshoe Bat (. rouxii ) ; sella is virtually parallelsided, and widely rounded off at tip; horseshoe is relatively wide (8-1-8- 2 mm ) but does not completely cover muzzle, and there are usually clearly visible and well developed lateral leaflets. Lower lip has three mental grooves. Skull is massive and robust (zygomatic width is always much larger than mastoid width); anterior median swellings are relatively small; posterior swellings are moderately developed; rostral profile is concave; sagittal crest is moderate to high; frontal depression is shallow; supraorbital crests are low but visible. C1 is well developed and long; P2 is moderate in size and within tooth row or slightly extruded from it; P3 is medium-sized to small and partly to fully extruded from tooth row; P2 and P4 are touching or almost touching. Chromosomal complement has 2n = 36 and FNa = 60 (mainland China and Hainan ). Habitat . The Chinese Rufous Horseshoe Bat is typically a forest species, occurring in montane forests with heavy rainfall. It has been reported from disturbed forests in Nepal and from thick moist tropical forest with some bamboo in Myanmar . Recorded at elevations of 500-2769 m , being commonest at higher altitudes. Food and Feeding . The Chinese Rufous Horseshoe Bat forages for insects by aerialhawking and occasionally perch-hunting. Breeding. No information. Activity patterns. Chinese Rufous Horseshoe Bats roost in caves, old disused tunnels, temples, houses, wells, and hollows in trees. They leave their roosts just after dusk to forage through the night. In colder portions of their range, they hibernate through the winter. Calls are FM/CF/FM shaped with a peak GF recorded at c.79-87 kHz across China and Hainan , and at 80 kHz in Vietnam . Movements, Home range and Social organization. The Chinese Rufous Horseshoe Bat roosts singly ( usually males) or in colonies varying in size from a few individuals to several hundred. During the breeding season, females form large maternity colonies that can consist of several hundred bats. Status and Conservation. Classified as Least Concern on The IUCN Red List. The Chinese Rufous Horseshoe Bat is widespread and relatively common throughout its distribution, and does not seem to be facing any major threats currently. It may be locally threatened by roost disturbance and general habitat loss. Bibliography. Ao Lei et al. (2007), Bates & Harrison (1997), Bates, Csorba, Molur & Srinivasulu (2008a), Bates, Thi Mar-Mar et al. (2004), Csorba et al. (2003), Francis (2008a), Kruskop (2013a), Mao Xiuguang, Dong Ji et al. (2014), Mao Xiuguang, He Guimei et al. (2013), Mao Xiuguang, Tsagkogeorga et al. (2019), Molur et al. (2002), Smith &XieYan (2008), Stoffberg et al . (2010), Wu Yi & Harada (2005), Wu Yi , Harada & LiYanhong (2004), Wu Yi, Motokawa et al. (2009), Xie Lifen et al. (2017), Zhang Lin et al. (2018), Zhang Weidao (1985).",
  "taxonomy": "Rhinolophus rouxi [sic] sinicus K. Andersen, 1905 , “ Chin Tah , Anhwei [= Anhui Province ], Lower Yangtse [River ],” China . Rhinolophus sinicus is included in the rouxii species group and appears to be sister to R. thomasi . True R. sinicus is composed of three genetic lineages in the eastern, central, and Hainan portion ofits distribution while R.s. septentrionalis is sister to. thomasi , suggesting that the former is distinct at the species level. Rhinolophus sinicus was previously included in R rouxii , but shows substantial morphological, genetic, and karyological differences. There appears to be some ambiguity regarding the distribution of this species and R rouxii in published records: north Indian records previously attributed to. rouxii are now considered to refer to R.sinicus . There may also be some ambiguity regarding the distribution of this species in South-east Asia, as it is often confused with R. thomasi . Validity of races needs to be tested. Two subspecies are currently recognized, although they likely represent two distinct species, pending further revision.",
  "commonNames": "Chinese Rufous Horseshoe Bat @en | China-Hufeisennase @en | Herradura rufo de China @es | Chinese Horseshoe Bat @en | Little Nepalese Horseshoe Bat @en",
  "interpretedAuthorityName": "K. Andersen",
  "interpretedAuthorityYear": "1905",
  "interpretedClass": "Mammalia",
  "interpretedFamily": "Rhinolophidae",
  "interpretedGenus": "Rhinolophus",
  "interpretedKingdom": "Animalia",
  "interpretedOrder": "Chiroptera",
  "interpretedPageId": "46",
  "interpretedPageNumber": "325",
  "interpretedPhylum": "Chordata",
  "interpretedRank": "species",
  "interpretedSpecies": "sinicus",
  "name": "Rhinolophus sinicus",
  "subspeciesAndDistribution": "R . s. sinicus K .Andersen, 1905 - N India ( Himachal Pradesh , Uttarakhand , Sikkim , West Bengal , Meghalaya , Arunachal Pradesh , and Nagaland ), Nepal , N Myanmar ,, S & SE China ( Xizang , Sichuan , Guizhou , Hubei , Jiangsu , Anhui , Zhejiang , Fujian , Guangdong , and Hainan I), and N & C Vietnam . On following pages: 94. Thomas's Horseshoe Bat ( Rhinolophus thomasi ); 95. Lesser Horseshoe Bat ( Rhinolophus hipposideros ); 96. rancis's Woolly Horseshoe Bat ( Rhinolophus trancisi); 97. Lesser Woolly Horseshoe Bat ( Rhinolophus sedulus ); 98. Trefoil Horseshoe Bat ( Rhinolophus trifoliatus ); 99. Northern Woolly Horseshoe Bat ( Rhinolophus perniger ); 100. Selangor Woolly Horseshoe Bat ( Rhinolophus luctoides ); 101. Malaysian Woolly Horseshoe Bat ( Rhinolophus mono ); 102. Great Woolly Horseshoe Bat ( Rhinolophus luctus ); 1.03. Beddome's Woolly Horseshoe Bat ( Rhinolophus beddomei ); 104. Formosan Woolly Horseshoe Bat ( Rhinolophus formosaë ); 105. Thailand Horseshoe Bat ( Rhinolophus thailandensis ); 106. Dobson's Horseshoe Bat ( Rhinolophus yunanensis ); 107. Chiew Kwee's Horseshoe Bat ( Rhinolophus chiewkweeae ); 108. Pearson's Horseshoe Bat ( Rhinolophus pearsonii ); 109. Mitred Horseshoe Bat ( Rhinolophus mitratus ). R .s. septentrionalis Sanborn , 1939 — S China ( Yunnan ).",
  "distributionImageURL": "https://zenodo.org/record/3750096/files/figure.png",
  "bibliography": "Ao Lei et al. (2007) | Bates & Harrison (1997) | Bates, Csorba, Molur & Srinivasulu (2008a) | Bates, Thi Mar-Mar et al. (2004) | Csorba et al. (2003) | Francis (2008a) | Kruskop (2013a) | Mao Xiuguang, Dong Ji et al. (2014) | Mao Xiuguang, He Guimei et al. (2013) | Mao Xiuguang, Tsagkogeorga et al. (2019) | Molur et al. (2002) | Smith &XieYan (2008) | Stoffberg et al . (2010) | Wu Yi & Harada (2005) | Wu Yi , Harada & LiYanhong (2004) | Wu Yi, Motokawa et al. (2009) | Xie Lifen et al. (2017) | Zhang Lin et al. (2018) | Zhang Weidao (1985)",
  "foodAndFeeding": "The Chinese Rufous Horseshoe Bat forages for insects by aerialhawking and occasionally perch-hunting.",
  "breeding": "No information.",
  "activityPatterns": "Chinese Rufous Horseshoe Bats roost in caves, old disused tunnels, temples, houses, wells, and hollows in trees. They leave their roosts just after dusk to forage through the night. In colder portions of their range, they hibernate through the winter. Calls are FM/CF/FM shaped with a peak GF recorded at c.79-87 kHz across China and Hainan , and at 80 kHz in Vietnam .",
  "movementsHomeRangeAndSocialOrganization": "The Chinese Rufous Horseshoe Bat roosts singly ( usually males) or in colonies varying in size from a few individuals to several hundred. During the breeding season, females form large maternity colonies that can consist of several hundred bats.",
  "statusAndConservation": "Classified as Least Concern on The IUCN Red List. The Chinese Rufous Horseshoe Bat is widespread and relatively common throughout its distribution, and does not seem to be facing any major threats currently. It may be locally threatened by roost disturbance and general habitat loss.",
  "descriptiveNotes": "Head-body 43-53' 5 mm , tail 21- 5—30 mm , ear 15- 8-20 mm , hindfoot 7- 5-10 mm , forearm 43-56 mm ; weight 8-9-10- 9 g . Dorsal pelage is wood brown, occasionally with reddish tint; ventral pelage is slightly lighter. Ears are small. Noseleaf has hastate lancet that constricts before variably long to short tip; connecting process is rounded, as in the Indian Rufous Horseshoe Bat (. rouxii ) ; sella is virtually parallelsided, and widely rounded off at tip; horseshoe is relatively wide (8-1-8- 2 mm ) but does not completely cover muzzle, and there are usually clearly visible and well developed lateral leaflets. Lower lip has three mental grooves. Skull is massive and robust (zygomatic width is always much larger than mastoid width); anterior median swellings are relatively small; posterior swellings are moderately developed; rostral profile is concave; sagittal crest is moderate to high; frontal depression is shallow; supraorbital crests are low but visible. C1 is well developed and long; P2 is moderate in size and within tooth row or slightly extruded from it; P3 is medium-sized to small and partly to fully extruded from tooth row; P2 and P4 are touching or almost touching. Chromosomal complement has 2n = 36 and FNa = 60 (mainland China and Hainan ).",
  "habitat": "The Chinese Rufous Horseshoe Bat is typically a forest species, occurring in montane forests with heavy rainfall. It has been reported from disturbed forests in Nepal and from thick moist tropical forest with some bamboo in Myanmar . Recorded at elevations of 500-2769 m , being commonest at higher altitudes."
}
```

For more examples, see [hmw-sample.csv](hmw-sample.csv) or [hmw-sample-pretty.json](hmw-sample-pretty.json).


# Code Examples 

## R Example

```R
# get the data
hmw <- read.csv('https://github.com/jhpoelen/hmw/raw/main/hmw.csv')

# list first 10 names
head(hmw$name)
#[1] "Geomys pinetis"        "Heterogeomys hispidus" "Orthogeomys grandis"
#[4] "Zygogeomys trichopus"  "Heterogeomys cavator"  "Heterogeomys lanius"

# list descriptive notes for "Rhinolophus sinicus"
hmw[hmw$name == "Rhinolophus sinicus",]$descriptiveNotes
# [1] "Head-body 43-53' 5 mm, tail 21- 5—30 mm, ear 15- 8-20 mm, hindfoot 7- 5-10 mm, forearm 43-56 mm; weight 8-9-10- 9 g. Dorsal pelage is wood brown, occasionally with reddish tint; ventral pelage is slightly lighter. Ears are small. Noseleaf has hastate lancet that constricts before variably long to short tip; connecting process is rounded, as in the Indian Rufous Horseshoe Bat (. rouxii); sella is virtually parallelsided, and widely rounded off at tip; horseshoe is relatively wide (8-1-8- 2 mm) but does not completely cover muzzle, and there are usually clearly visible and well developed lateral leaflets. Lower lip has three mental grooves. Skull is massive and robust (zygomatic width is always much larger than mastoid width); anterior median swellings are relatively small; posterior swellings are moderately developed; rostral profile is concave; sagittal crest is moderate to high; frontal depression is shallow; supraorbital crests are low but visible. C1 is well developed and long; P2 is moderate in size and within tooth row or slightly extruded from it; P3 is medium-sized to small and partly to fully extruded from tooth row; P2 and P4 are touching or almost touching. Chromosomal complement has 2n = 36 and FNa = 60 (mainland Chinaand Hainan)."

# list the available columns names
names(hmw)
#[1] "docId"
#[2] "docOrigin"
#[3] "docISBN"
#[4] "docName"
#[5] "docMasterId"
#[6] "docPageNumber"
#[7] "derivedFrom"
#[8] "name"
#[9] "interpretedGenus"
#[10] "interpretedSpecies"
#[11] "interpretedAuthorityName"
#[12] "interpretedAuthorityYear"
#[13] "commonNames"
#[14] "taxonomy"
#[15] "subspeciesAndDistribution"
#[16] "descriptiveNotes"
#[17] "habitat"
#[18] "foodAndFeeding"
#[19] "breeding"
#[20] "activityPatterns"
#[21] "movementsHomeRangeAndSocialOrganization"
#[22] "statusAndConservation"
#[23] "bibliography"
#[24] "distributionImageURL"
#[25] "verbatimText"
#
```

# Related Data

Please see release attachment ```preston-data.zip``` for underlying data.

# Funding 

OAC 1839201 from the National Science Foundation, 1-R21-AI164268-01 from the National Institutes of Health

# References

```
$ preston history
<urn:uuid:0659a54f-b713-4f86-a917-5be166a14110> <http://purl.org/pav/hasVersion> <hash://sha256/a965b45916bcffb49aa572675970f002e4e839cead8c1957dc5ba638c838b9b6> .
```

and other content ids include:

```
$ preston ls\
| grep -o -E "hash://sha256/[0-9a-f]{64}"\
| sort\
| uniq
hash://sha256/15afc61b5914e4b6899b43a5eda355497d5c5d0c4b401c884c8056f418c9665b
```
