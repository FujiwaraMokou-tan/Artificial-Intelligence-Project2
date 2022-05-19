# Manual Técnico 

## Inteligência Artificial - Escola Superior de Tecnologia de Setúbal  

<br>

### 2020/2021

<br>

### Problema do Quatro


<br>
Realizado por:

André Nascimento nº160221075

Eduardo Ferreira nº110221031

<br> 

## **Arquitetura do sistema**

Para melhor organização do código correspondente ao problema, foram criados 3 ficheiros:

Algoritm.LISP - Implementa os algoritmos relevantes para a resolução do problema.

Interact.LISP - É a pagina de interação do utilizador.

Jogo.LISP - Contem o jogo em si, juntamente como as peças são colocadas.


## **Entidades e a sua implementação**

Como entidade o nosso negamax tem o Node, que basicamente é o estado atual do jogo.

Tambem temos a entidade depth, que será a profundidade maxima ao descer.

Tambem temos a entidade player, que simboliza qual o jogador que vai efetuar a jogada do nosso sucessor (alternando entre valores de 1 e -1).

Tambem temos a entidade time, que simboliza o tempo que o algoritmo tem para executar a jogada.

Temos tambem o alfa, onde é inicialmente atribuido um número infinito negativo.

Temos tambem o beta, onde é inicialmente atribuido um número infinito positivo.

Temos tambem o moves, onde vão ser guardadas as jogadas efetuadas.

Temos tambem o start_time, que vai servir como cronómetro e quando o tempo chegar ao atributo time que nós temos, o algoritmo fecha.

Para alem desse temos o reverse_counter, que irá servir como condição de paragem final e como forma de segurança para se certificar que todos os nós do gráfo foram avaliados/cortados e termina mesmo no fim.

## **Algoritmos e a sua implementação**

O algoritmo implementado neste projeto foi:

* Negamax (com fail-soft)

### Negamax: ###

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816009956738072576/unknown.png)  
Figura 1: Imagem do teste 1.

<br>

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816010157317685298/unknown.png)  
Figura 2: Resultados do teste 1.

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816010483231359006/unknown.png)  
Figura 3: Imagem do teste 2

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816010661204066344/unknown.png)  
Figura 4: Resultados do teste 2


![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816010885134942218/unknown.png)  
Figura 5: Imagem do algoritmo minmax

Este algoritmo minimax não é para ser avaliado no projeto, foi simplesmente algo que o grupo encontrou na wikipédia e utilizou como forma de testar se o nosso algoritmo negamax conseguiria achar jogadas que tivessem o mesmo valor heuristico que um algoritmo que o grupo tem a certeza está a funcionar perfeitamente. 

Como se pode verificar nas imagens, a peça a ser jogada que o nosso negamax recomenda, assim como as suas coordenadas, acaba por ter o mesmo valor que o minimax encontra.

Estes testes foram efetuados ao alterar o tabuleiro de teste e colocando determinadas peças previamente no tabuleiro para ver como o nosso negamax iria reagir.

## **Descrição das opções tomadas**

Como entidade o nosso negamax tem o Node, que basicamente é o estado atual do jogo.

Tambem temos a entidade depth, que será a profundidade maxima ao descer.

Tambem temos a entidade player, que simboliza qual o jogador que vai efetuar a jogada do nosso sucessor (alternando entre valores de 1 e -1).

Tambem temos a entidade time, que simboliza o tempo que o algoritmo tem para executar a jogada.

Temos tambem o alfa, onde é inicialmente atribuido um número infinito negativo.

Temos tambem o beta, onde é inicialmente atribuido um número infinito positivo.

Temos tambem o moves, onde vão ser guardadas as jogadas efetuadas.

Temos tambem o start_time, que vai servir como cronómetro e quando o tempo chegar ao atributo time que nós temos, o algoritmo fecha.

Para alem desse temos o reverse_counter, que irá servir como condição de paragem final e como forma de segurança para se certificar que todos os nós do gráfo foram avaliados/cortados e termina mesmo no fim.

O algoritmo em si começa com a condição que vai verificar três opções, que são:
 
 - Se a profundidade é 0
 - Se a tabuleiro já encontrou a solução
 - Se o tempo limite já foi ultrapassado

 Caso alguma destas se verifique, então será devolvido o valor.

 De seguida temos um let com a primeira variavel chamada _sucessors_, que irá encontrar os sucessores de um nó e ordená-los apropriadamente.

 Depois temos a variavel _value_, que se inicia como menos infinito. De seguida será utilizado a função negamax-sucessors, esta função secundária irá servir para simular o foreach/loop que se encontra no powerpoint de teoria de jogos, slide 34. 

 Nessa função secundária iremos achar o value (bestValue do power point) que será o max do value com a negação do negamax, após isso, iremos achar o alfa que será o max entre o alfa e o bestValue. Após isso, iremos ter um conjunto de condições para guarantir que o algoritmo corre de uma forma recursiva, essas condições são:

 - (>= alfa beta) serão os nossos cortes.

 - ((and (null (cdr moves)) (= reverse-counter 1)) moves) será a nossa função termino

 - ((null (cdr moves)) value) será a condição de termino para os filhos abaixo dos filhos diretos do nó inicial.

 Após o algoritmo ter sido terminado, irá devolver a melhor jogada que encontrou e caso o utlizador esteja num jogo, será tudo guardado no log.


![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816016992758267944/unknown.png)  
Figura 6: Imagem do log.


## **Limitações técnicas**

A limitação de Stack ainda existe, mas o comando para aumentar a Stack foi incluido na função _iniciar_, para que não seja preciso executa-lo separadamente.
