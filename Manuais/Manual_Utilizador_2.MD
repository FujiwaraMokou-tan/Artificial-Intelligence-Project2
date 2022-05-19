# Manual de Utilizador

Inteligência Artificial - Escola Superior de Tecnologia de Setúbal  
2020/2021

André Nascimento nº160221075

Eduardo Ferreira nº110221031

## **Acrónimos e Conveções usadas**

Nega-memo - Memoização que vai chamar o algoritmo negamax e vai guardar o resultado na hash table.

## **Introdução**

Este manual servirá de guia para a execução e resolução do problema do Quatro, proposto ambita da unidade curricular de Inteligencia Artificial (IA).

Este é constituido por um tabuleiro de 4x4 casas, juntamente com um conjunto de peças, podendo ter até 16 peças dependendo do problema, estas podem ter algumas caracteristicas na forma de formato(cheia ou oca) e cor (brancas ou pretas).

O problema proposto tem como objetivo, a aplicação de algoritmos relacionados com a teoria de jogos, lecionada nas aulas teoricas da unidade curricular de Inteligencia Artificial(IA).


## **Instalação e utilização**

1. O utilizador começa por abrir o LispWorks, de seguida vai abrir no _editor_ o ficheiro _interact.lisp_ e depois clica no botão _compile buffer_ que vai compilar todas as funções necessárias para correr o projeto.
2. voltar para o _listener_ e executa o comando _(iniciar).
3. Após ter sido iniciado, o programa interage com o utilizador, perguntando-lhe se é humano ou computador, o utlizador terá de escolher entre uma dessas opções. Caso o utilizador escolher "humano", este poderá jogar contra o computador, no caso de escolher "Computador" então o computador irá jogar contra si mesmo.
4. De seguida será depois também perguntado se o utilizador deseja jogar em primeiro lugar ou em segundo lugar.
5. Após ter sido escolhida a ordem de jogadores, ser-lhe-à pedido o tempo de processamento que o algoritmo deverá ter.
6. Após ter sido escolhido o tempo limite, tambem será pedido qual a profundidade que deverá avaliar o algoritmo.
7. Após ter a profundidade ter sido escolhida, o jogo começa.
 
## **Input/Output**

Quado o programa é executado, o utilizador primeiro escolhe se vai jogar contra o computador ou se o computador vai jogar contra outro computador.
As jogadas, as peças e o tabuleiro vão ser mostrados ao longo do jogo, assim como irão ser todas guardadas no documento _log.dat_.

Após o jogo terminar, o resultado será guardado no ficheiro _log.dat_.


## **Exemplo de aplicação**

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816006589571924028/unknown.png)  
Figura 1: Exemplo da execução do programa.

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816006853355896862/unknown.png)  
Figura 2: Exemplo de como inserir as peças.

![Compile](https://cdn.discordapp.com/attachments/501453248688029697/816007181085442108/unknown.png)  
Figura 3: Peças inseridas após o cpmputador ter terminado a resposta.
