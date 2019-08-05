#!/bin/bash

#m f j 
#target_kiap="m"
# Huagi: g
# Taigi: m j f  
# Haffa: c h d r z l"
# Tsokgi: "a t b n p"
# English: "e"

target_kiap="g m j f c h d r z l a t b n p e"

for kiap in $target_kiap
do
  echo $kiap
  mkdir -p "${kiap}_files"

  for num in $(seq -f "%03g" 1 206)
  do
    url="http://163.21.182.5/ez5language/ezlearn/FM/${kiap}_files/${num}.mp3"
    wget --directory-prefix=./${kiap}_files ${url}
  done

done
