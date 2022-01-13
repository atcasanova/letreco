#!/bin/bash
for palpite in $* ; do
  (( ${#palpite} != 5 )) && continue
  totalv=0
  totala=0
  while read resposta; do
    verde=0
    amarelo=0
    [[ "$palpite" == "$resposta" ]] && continue
    palpite_=( $(sed 's/./ \0/g' <<< $palpite) )
    resposta_=( $(sed 's/./ \0/g' <<< $resposta) )
    for (( i=0; i<=4; i++ )) {
      [[ "${palpite_[$i]}" == "${resposta_[$i]}" ]] && {
        let verde++
        continue
      } || {
        grep -q ${palpite_[$i]} <<< ${resposta} && {
          let amarelo++
        }
      }
    }
    let totalv+=$verde
    let totala+=$amarelo
  done < 5letras.txt
  echo "[$palpite] $totalv verdes $totala amarelas"
done
