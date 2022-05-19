;;;; Projeto de IA 2o fase
;;;; Disciplina de IA - 2020 / 2021
;;;; Autores: Eduardo Ferreira, Andre Nascimento

;;(nega-memo(boardNPieces) 5 3)
;;Copiado do powerpoint onde se ensinava a memoizacao
(let ((tab(make-hash-table)))  ;;Memoizacao do negamax
(defun nega-memo(n time depth)
(or (gethash n tab) (let ((val (funcall #'negamax n depth 1 time)))
(setf (gethash n tab) val)
val))))

;;negamax
;;(negamax (boardNPieces) 4 1 5)
;;Seguindo o Slide 34 de teoria de jogos podemos seguir/ter uma estrutura similar
;;O start-time embora funcione de certa forma, ele nao para no tempo indicado (demora sempre um bocado mais)
;;reverse-counter vai servir como paragem final como forma de possuirmos uma paragem propria para os nos diretamente do no fonte e nao para os nos abaixo dos filhos diretos
(defun negamax (node depth player time &optional (alfa most-negative-fixnum) (beta most-positive-fixnum) (moves nil) (start-time (get-universal-time)) (reverse-counter 1))
  (cond
   ((or (solution (tabuleiro (fill-board moves node))) (equal depth 0) (>= (- (get-universal-time) start-time) time)) (* player (get-board-ready-for-ristic moves node))) ;;caso a solucao seja encontrada, a depth seja 0 ou o tempo se tenha esgotado para o codigo
   (t
    (let* ((sucessors (order-by-player node (runThroughPieces (fill-board moves node) moves) player))  ;encontra os sucessores e ordena-os
           (value most-negative-fixnum))
      (negamax-foreach node depth sucessors player time value alfa beta start-time reverse-counter)))))


;; negamax-foreach
;;Seguindo o Slide 34, isto sera o foreach
(defun negamax-foreach (node depth moves player time value alfa beta start-time reverse-counter) ;;corre os sucessores de negamax e efetua os cortes do tipo fail-soft
  (let* ((value (max value (- (negamax node (- depth 1) (- player) time (- beta) (- alfa) (car moves) start-time (1+ reverse-counter)))))   ;desce de nivel
         (alfa (max alfa value)))
    (cond
     ((>= alfa beta) value) ;O corte a ser efetuado
     ((and (null (cdr moves)) (= reverse-counter 1)) moves) ;O resultado
     ((null (cdr moves)) value)
     (t (negamax-foreach node depth (cdr moves) player time value alfa beta start-time reverse-counter)))))  ;verifica os outros nos do mesmo nivel


;;(remove '(1 2) '((1 2) (1 3)) :test #'equal)
;;(order-by-player (boardNPieces) '(((branca quadrada alta oca) (0 1)) ((preta redonda alta oca) (3 3))) 1)
;;Dependendo do jogador ordena-o corretamente, pegando na lista, vai encontrando os moves e coloca-os numa lista alternativa antes de apagar os valores
(defun order-by-player (node moves player &optional (result nil))
  (cond
   ((null moves) result)
   ((equal player 1)
    (let* ((lowest-move (remove (crescent-order node moves) moves :test #'equal)))
      (order-by-player node lowest-move player (append result (list (crescent-order node moves))))))
   (t (let* ((biggest-move (remove (decrescent-order node moves) moves :test #'equal)))
      (order-by-player node biggest-move player (append result (list (decrescent-order node moves))))))))


;;(crescent-order (boardNPieces) '(((branca quadrada alta oca) (0 1)) ((preta redonda alta oca) (3 3))))
(defun crescent-order (node moves &optional (lesser-node nil))
  (cond
   ((null lesser-node) (crescent-order node (cdr moves) (car moves)))
   ((null moves) lesser-node)
   ((< (get-board-ready-for-ristic lesser-node node) (get-board-ready-for-ristic (car moves) node)) (crescent-order node (cdr moves) lesser-node))
   (t (crescent-order node (cdr moves) (car moves)))
   )
)


;;(decrescent-order (boardNPieces) '(((branca quadrada alta oca) (0 1)) ((preta redonda alta oca) (3 3))))
(defun decrescent-order (node moves &optional (bigger-node nil))
  (cond
   ((null bigger-node) (decrescent-order node (cdr moves) (car moves)))
   ((null moves) bigger-node)
   ((> (get-board-ready-for-ristic bigger-node node) (get-board-ready-for-ristic (car moves) node)) (decrescent-order node (cdr moves) bigger-node))
   (t (decrescent-order node (cdr moves) (car moves)))
   )
)


;;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;;/////////////////////////////////////////////Ignorar, foi tirado da wikipedia para testar se ambos acham o mesmo valor final como forma a testar se on nosso algoritmo funciona//////////////////////////
;;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;;(minimax (boardNPieces))
(defun minimax(node &optional (player t) (moves nil) (depth 3)  (alpha most-negative-fixnum) (beta most-positive-fixnum) (tempo-limite 4000) (start-time (get-universal-time)))
(cond
((or (= depth 0) (>= (- (get-universal-time) start-time) tempo-limite)) (get-board-ready-for-ristic moves node))

((equal player T)
 (let* ((maxEval most-negative-fixnum))
   (dolist (cunny (runThroughPieces node))
     (setf maxEval (max maxEval (minimax node (not player) cunny (1- depth) alpha beta (- (get-universal-time) start-time))))
     (setf alpha (max alpha maxEval))
     (when (>= alpha beta)
            (return))
   )
  maxEval)
)

(t
 (let* ((minEval most-positive-fixnum))
   (dolist (cunny (runThroughPieces node))
      (setf minEval (min minEval (minimax node (not player) cunny (1- depth) alpha beta (- (get-universal-time) start-time))))
      (setf beta (min beta minEval))
      (when (<= beta alpha)
             (return))
   )
   minEval)
)
))
;;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;;/////////////////////////////////////////////Ignorar, foi tirado da wikipedia para testar se ambos acham o mesmo valor final como forma a testar se on nosso algoritmo funciona//////////////////////////
;;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
