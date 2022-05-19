(load "E:/Project_AI2/algoritmo.lisp" :if-does-not-exist nil)
(load "E:/Project_AI2/jogo.lisp" :if-does-not-exist nil)

;;;Funcao Iniciar
;;;(iniciar)
;;;Esta funcao e a funcao que devera ser corrida para por o projeto a funcionar
(defun iniciar()
(extend-current-stack 1000)
(progn
(format t "Human or Computer?~%")
(let ((typeGame (read)))
(cond
((equal typeGame 'Human)
(format t "1st or 2nd (write 1 or 2)?~%")
(let ((first-move (read)))
(format t "Time the machine has to play?~%")
(let ((time (read)))
(format t "Desired depth?~%")
(let ((depth (read)))
  (cond
   ((and (equal typeGame 'human) (equal first-move 1)) (write-start depth time) (play (boardNPieces) -1 time depth))    ;Caso seja Humano
   (t (write-start depth time) (play (boardNPieces) 1 time depth))  ;Inicia o log
   )))))
(t                                             ;Caso seja Computer
(format t "Time the machine has to play?~%")
(let ((time (read)))
(format t "Desired depth?~%")
(let ((depth (read)))
  (write-start depth time) (Comp-play (boardNPieces) -1 time depth)  ;Inicia o log
)))))))


;;(Comp-play (boardNPieces) -1 5 depth)
(defun Comp-play (board player time depth &optional (counter 0))
(show-board (tabuleiro board))
(pieces-left (reserva board))
(cond
((solution (tabuleiro board)) (write-end (- player)))   ;existe um vencedor
((equal counter 16) (write-end))  ;Empate
(t 
(let* ((result (nega-memo board time depth))   ; recebe a jogada efetuada
       (newboard (operador (car (car (cdr (car result)))) (car (cdr (car (cdr (car result))))) (car (car result)) board))  ; coloca a jogado no tabuleiro
       )
(write-to-log (car (car (cdr (car result)))) (car (cdr (car (cdr (car result))))) (car (car result)) newboard)   ;Escreve para o log
(Comp-play newboard (- player) time depth (+ counter 1)))  ;Prossegue com o jogo
)))

;;(play (boardNPieces) -1 5 3)
;;(play (boardNPieces) 1 5 3)
;;
(defun play (board player time depth &optional (counter 0))
(cond
((solution (tabuleiro board)) (write-end (- player)))   ;existe um vencedor
((equal counter 16) (write-end))   ;Empate
((equal player -1) (play (human-play board) (- player) time (+ counter 1)))
(t 
(let* ((result (nega-memo board time depth)) ; recebe a jogada efetuada
       (newboard (operador (car (car (cdr (car result)))) (car (cdr (car (cdr (car result))))) (car (car result)) board)) ; coloca a jogado no tabuleiro
       )
(write-to-log (car (car (cdr (car result)))) (car (cdr (car (cdr (car result))))) (car (car result)) newboard) ;Escreve para o log
(play newboard (- player) time depth (+ counter 1)) ;Prossegue com o jogo
)))
)

;;;(human-play (boardNPieces))
;;;Define as jogadas do utilizador
(defun human-play(board)
(progn
(show-board (tabuleiro board))
(pieces-left (reserva board))
(format t "Qual a Peca que deseja jogar?~%")
(let ((piece (read)))
(format t "~%Qual a Coordenada X?~%")
(let ((valorx (read)))
  (format t "Qual a Coordenada Y?~%")
  (let* ((valory (read))
         (newboard (operador valorx valory piece board ))  ;O novo estado do tabuleiro
         )
    (write-to-log valorx valory piece newboard)    ;Escreve para o log
    newboard     ;mostra o novo tabuleiro
))))
)

;;;(write-to-log 1 1 '(branca quadrada alta cheia) (boardNPieces))
;;;Regista as jogadas efetuadas
(defun write-to-log(xcord ycord piece board)
(with-open-file (str "E:/Project_AI2/log.dat"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create
                 )
 (format str  "~% Peca: ~a Coordenada X: ~a Coordenada Y ~a" piece xcord ycord)
 (format str  "~% Tabuleiro ~a~%~%" board)
 
)
)

;;;(write-start 3 5)
;;;Quando o jogo comecar vai mostrar as estatisticas escolhidas
(defun write-start(depth time)
(with-open-file (str "E:/Project_AI2/log.dat"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create
                 )

    (format str "~% Inicio do jogo:~%")
    (format str "~% Profundidade escolhida ~a:" depth)
    (format str "~% Tempo limite escolhido ~a~%" time)
))

;;;(write-end)
;;;Quando o jogo acabar devera indicar quem ganhou (ou se empatou)
(defun write-end( &optional (player nil))
(with-open-file (str "E:/Project_AI2/log.dat"
                     :direction :output
                     :if-exists :append
                     :if-does-not-exist :create
                 )

    (format str "~% Fim do Jogo:~%")
    (cond
    ((equal player nil) (format str "~% O jogo terminou em Empate:~%")) ;se for nil entao nao houve vencedor (empate)
    (t (format str "~% O vencedor Foi: ~a~%" player)) 
)
))

