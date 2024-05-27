#!/bin/bash

declare -a StringArray=(
  "co_conc"    "dust"       "nh3_conc"   "nmvoc_conc" "no2_conc"   "no_conc"    "o3_conc"    "pans_conc"
  "pm10_conc"  "pm2p5_conc" "pmwf_conc"  "sia_conc"   "so2_conc"
)

for val in ${StringArray[@]}; do
  `Rscript displayData.R $val`
done

exit 0
