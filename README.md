# letreco
Estudo de ocorrência para ganhar no jogo Letreco

## Wordlist
Usaremos a seguinte wordlist como base: https://www.ime.usp.br/~pf/dicios/br-sem-acentos.txt, filtrando apenas as palavras de 5 caracteres e convertendo tudo para minúsculas:

```
$ curl https://www.ime.usp.br/~pf/dicios/br-sem-acentos.txt | awk 'length($1) == 5 {print tolower($1)}' | sort -u > 5letras.txt
$ wc -l 5letras.txt
5427 letras.txt
```

Com essa lista podemos calcular a incidência de cada letra do alfabeto no conjunto de palavras com 5 caracteres:

```
$ grep -Eo . 5letras.txt  | sort | uniq -c | sort -nr
   4244 a
   2765 o
   2739 e
   2157 i
   2093 r
   1968 s
   1293 m
   1262 u
   1097 t
   1086 c
   1021 l
    868 n
    754 d
    691 p
    598 g
    591 v
    535 b
    530 f
    233 h
    205 j
    201 z
    162 x
     38 q
      4 k

```

Temos que as letras `a`, `o`, `e`, `i` e `r` são as de maior ocorrência no universo. Assim, podemos encontrar palavras nas quais todas as letras estão presentes e testá-las contra o universo para verificar a quantidade de dicas que elas gerariam:

```
$ grep a 5letras.txt | grep o | grep e | grep i
aecio
apeio
apoie
ateio
aveio
ecoai
meiao
odeia
```

Usando o script [letreco.sh](letreco.sh) podemos testar quantas dicas cada palavra entrega quando testada contra a lista toda (ignorando a própria palavra).
Geramos uma lista com palavras contendo `a`, `o`, `e`, `i` e `a`, `o`, `e`, `r`. O resultado foi:


|palavra|dicas verdes|dicas amarelas|total|
|-------|------------|--------------|-----|
|serao|4109|7686|11795|
|rosea|3557|8229|11786|
|meiao|3920|7389|11309|
|aremo|2549|8683|11232|
|moera|2974|8247|11221|
|aureo|3703|7517|11220|
|remoa|3087|8132|11219|
|ateio|2471|8687|11158|
|ecoai|2033|9122|11155|
|aecio|3262|7864|11126|
|reato|3002|8096|11098|
|terao|4066|7018|11084|
|ecoar|1880|9195|11075|
|rotea|3524|7540|11064|
|lerao|4012|7032|11044|
|aereo|3997|7038|11035|
|onera|2021|8870|10891|
|odeia|2083|8769|10852|
|apeio|2452|8330|10782|
|adore|1704|9071|10775|
|eroda|2176|8598|10774|
|doera|2865|7908|10773|
|apoie|1847|8924|10771|
|rodea|3420|7345|10765|
|opera|1936|8779|10715|
|pareo|3977|6725|10702|
|arpoe|2240|8452|10692|
|aveio|2434|8234|10668|
|evora|1838|8768|10606|
|garoe|2957|7641|10598|
|verao|4014|6580|10594|
|afore|1691|8872|10563|
|reboa|2970|7571|10541|
|roera|2990|7469|10459|
|reajo|2678|7566|10244|
|arejo|2435|7808|10243|
|exaro|1941|8266|10207|
