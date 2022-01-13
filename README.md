# letreco
Estudo de ocorrência para ganhar no jogo Letreco

## Wordlist
Usaremos a seguinte wordlist como base: https://www.ime.usp.br/~pf/dicios/br-sem-acentos.txt, filtrando apenas as palavras de 5 caracteres e convertendo tudo para minúsculas:

```$ curl https://www.ime.usp.br/~pf/dicios/br-sem-acentos.txt | awk 'length($1) == 5 {print tolower($1)}' > 5letras.txt
$ wc -l 5letras.txt
6026 letras.txt
```

Com essa lista podemos calcular a incidência de cada letra do alfabeto no conjunto de palavras com 5 caracteres:

```
$ grep -Eo . 5letras.txt  | sort | uniq -c | sort -nr
   5004 a
   2955 o
   2941 e
   2377 i
   2356 r
   2122 s
   1370 m
   1362 u
   1247 c
   1233 t
   1130 l
    977 n
    834 d
    772 p
    669 g
    664 v
    592 b
    590 f
    271 h
    227 j
    215 z
    178 x
     40 q
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

Usando o script [letreco.sh](letreco.sh) podemos testar quantos palpites cada palavra entrega quando testada contra a lista toda:

```
$ ./letreco.sh aecio apeio apoie ateio aveio ecoai meiao odeia
[aecio] 3540 verdes 8854 amarelas (12394)
[apeio] 2677 verdes 9283 amarelas (11960)
[apoie] 2083 verdes 9877 amarelas (11960)
[ateio] 2695 verdes 9701 amarelas (12396)
[aveio] 2651 verdes 9194 amarelas (11755)
[ecoai] 2159 verdes 10235 amarelas (12394)
[meiao] 4176 verdes 8306 amarelas (12482)
[odeia] 2658 verdes 9365 amarelas (12023)
```
De onde deduzimos que o melhor palpite para iniciar o jogo é `meiao`

