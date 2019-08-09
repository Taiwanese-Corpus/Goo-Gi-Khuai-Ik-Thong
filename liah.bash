#!/bin/bash

#m f j 
#target_kiap="m"
# Huagi: g
# Taigi: m j f  
# Haffa: c h d r z l"
# Tsokgi: "a t b n p"
# English: "e"


#curl "http://163.21.182.5/ez5language/ezlearn/FM/{g,m,j,f,c,h,d,r,z,l,a,t,b,n,p,e}.xml" --create-dirs -o "./xml/#1.xml"


# Convert encoding
mkdir -p utf8_xml

for i in $(file xml/* | grep -v 'UTF-8' | sed 's/:.*//g')
do 
 cat $i | iconv -f big5 -t utf-8 > utf8_${i}
done

for i in $(file xml/* | grep 'UTF-8' | sed 's/:.*//g')
do
  cp $i utf8_${i}
  
  # Remove garbled character
  sed -i "s/$(echo -ne '\ude86')//g" utf8_${i}
done


find utf8_xml/ -type f  -exec bash -c 'grep "<node name=" {} | awk -F "[/\"]" "{print \$2, \$4, \$5,     substr(\$9, 4)}" OFS=, >  {}.csv' \;

exit

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
