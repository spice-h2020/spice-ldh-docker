#!/bin/bash
echo "*** INSTALLING MONGODB POLICIES DATA ***"
mongoimport --db=spice --collection=spice_policies --file=/home/policies_array.json --jsonArray 
echo "*** POLICIES DATA IMPORTED ***"