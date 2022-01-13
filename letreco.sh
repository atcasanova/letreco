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
      if [[ "${palpite_[$i]}" == "${resposta_[$i]}" ]]; then
        let verde++
        resposta=${resposta:0:$i}${resposta:$i+1}
        continue
      elif grep -q ${palpite_[$i]} <<< $resposta; then
          let amarelo++
          resposta=$(sed "s/${palpite_[$i]}//" <<< $resposta)
      fi
    }
    let totalv+=$verde
    let totala+=$amarelo
  done < 5letras.txt
  echo "[$palpite] $totalv verdes $totala amarelas ($((totala+totalv)))"
done
