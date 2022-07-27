#!/bin/bash 
#
# script checks for unexpected empty values for Handbook of Mammals of the World properties
#

# The following non-family records have one or more missing fields that should be available via Handbook of the Mammals of the World.

grep -v "verbatimText\":\"Family"\
 | jq --compact-output -f check.jq 


