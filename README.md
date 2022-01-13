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

Temos que as letras `a`, `o`, `e`, e `i` são as de maior ocorrência no universo. Assim, podemos encontrar palavras nas quais todas as letras estão presentes e testá-las contra o universo para verificar a quantidade de dicas que elas gerariam:

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

Usando o script [letreco.sh](letreco.sh) podemos testar quantoas dicas cada palavra entrega quando testada contra a lista toda (ignorando a própria palavra):

```
$ ./letreco.sh aecio apeio apoie ateio aveio ecoai meiao odeia
[aecio] 3262 verdes 7864 amarelas (11126)
[apeio] 2452 verdes 8330 amarelas (10782)
[apoie] 1847 verdes 8924 amarelas (10771)
[ateio] 2471 verdes 8687 amarelas (11158)
[aveio] 2434 verdes 8234 amarelas (10668)
[ecoai] 2033 verdes 9122 amarelas (11155)
[meiao] 3920 verdes 7389 amarelas (11309)
[odeia] 2083 verdes 8769 amarelas (10852)

```
De onde deduzimos que o melhor palpite para iniciar o jogo é `meiao`

