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


Analisando a aplicação do Letreco foi possível extrair toda a lista de palavras consideradas por eles, que é consideravelmente maior do que a utilizada anteriormente e contém centenas de palavras que sequer constam no [VOLP](https://www.academia.org.br/nossa-lingua/busca-no-vocabulario).
Aplicando a mesma anàlise à essa lista, temos:


|palavra|dicas verdes|dicas amarelas|total|
|-------|------------|--------------|-----|
|oreia|9134|30910|40044|
|areio|9743|30282|40025|
|oreai|7944|32063|40007|
|aiemo|9467|29108|38575|
|oleia|8597|29967|38564|
|maeio|11478|27081|38559|
|meiao|12308|26247|38555|
|ameio|8831|29723|38554|
|amoie|7220|31329|38549|
|oleai|7407|31126|38533|
|aleio|9206|29326|38532|
|eolia|11144|27320|38464|
|ecoai|7012|31051|38063|
|aecio|10906|27104|38010|
|aneio|8990|28941|37931|
|erosa|7386|30510|37896|
|rosea|11142|26744|37886|
|soera|10023|27858|37881|
|aroes|9609|28270|37879|
|serao|12190|25684|37874|
|sorea|12220|25620|37840|
|saroe|10192|27635|37827|
|ateio|8719|29014|37733|
|areao|11066|26631|37697|
|areou|6666|30632|37298|
|aureo|11925|25337|37262|
|odeia|8188|28712|36900|
|opaie|6429|30441|36870|
|apeio|8697|28155|36852|
|apoie|7086|29763|36849|
|adioe|7629|29204|36833|
|emaro|6974|29426|36400|
|olare|5841|30549|36390|
|eramo|7424|28964|36388|
|rameo|11133|25243|36376|
|aremo|8184|28191|36375|
|arelo|8223|28152|36375|
|eloar|6505|29866|36371|
|olear|6608|29759|36367|
|orela|7614|28752|36366|
|arome|6573|29787|36360|
|areol|6340|30013|36353|
|moera|10281|26069|36350|
|lerao|11970|24380|36350|
|maore|8770|27576|36346|
|orlea|9773|26546|36319|
|morea|12478|23827|36305|
|ofaie|6367|29757|36124|
|feiao|11856|24254|36110|
|afeio|8635|27453|36088|
|eivao|10562|25519|36081|
|aveio|8662|27406|36068|
|eroca|7643|28228|35871|
|ecoar|6213|29651|35864|
|acore|6206|29657|35863|
|acero|7817|28044|35861|
|recao|11226|24632|35858|
|racoe|9228|26611|35839|
|coera|10499|25332|35831|
|earco|10317|25497|35814|
|ocrea|9405|26401|35806|
|corea|12696|23102|35798|
|caroe|10668|25121|35789|
|erano|7576|28198|35774|
|onera|7284|28488|35772|
|enora|7181|28588|35769|
|areno|8336|27423|35759|
|ornea|10002|25715|35717|
|erato|7845|27729|35574|
|orate|6337|29231|35568|
|tearo|9390|26168|35558|
|terao|12223|23300|35523|
|atreo|9819|25689|35508|
|rotea|11206|24299|35505|
|ajoie|6938|28523|35461|
|ozeia|7977|27425|35402|
|zoeia|10289|25107|35396|
|ozeai|6787|28597|35384|
|aereo|11977|23345|35322|
|erado|7639|27088|34727|
|eroda|7687|27026|34713|
|adero|7700|27013|34713|
|doera|9585|25124|34709|
|adore|6089|28620|34709|
|rodea|10882|23805|34687|
|obera|7016|27671|34687|
|arode|6788|27899|34687|
|opera|6991|27695|34686|
|poare|8581|26103|34684|
|apero|7600|27073|34673|
|apore|5989|28681|34670|
|dorea|11782|22863|34645|
|pareo|12537|22104|34641|
|arpoe|7422|27208|34630|
|peroa|11302|23327|34629|
|gearo|9103|25414|34517|
|orega|7467|27043|34510|
|regao|10884|23623|34507|
|regoa|9779|24697|34476|
|garoe|9938|24499|34437|
|afero|7538|26384|33922|
|afore|5927|27994|33921|
|evora|6853|27049|33902|
|revoa|9474|24413|33887|
|ervoa|8174|25702|33876|
|verao|11672|22193|33865|
|arvoe|7275|26588|33863|
|faroe|9998|23858|33856|
|aroer|7166|26503|33669|
|roera|9852|23724|33576|
|orear|7145|26396|33541|
|hoare|7603|25670|33273|
|rejao|10456|22815|33271|
|exaro|6810|26460|33270|
|oxera|6961|26302|33263|
|exora|6858|26402|33260|
|arejo|7811|25448|33259|
|roxea|10605|22644|33249|
|arjoe|7152|26081|33233|
|rezao|10424|22794|33218|
|haroe|9431|23773|33204|
|ozear|5988|27214|33202|
|razoe|8426|24769|33195|

