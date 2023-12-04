#!/bin/bash 
NUM_REQUESTS=$(( ( RANDOM % 5 )  + 20 ))
./hey -n $NUM_REQUESTS -c 4 -m GET https://inventory-ksxygpjupa-uc.a.run.app/newproducts