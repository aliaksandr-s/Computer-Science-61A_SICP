#lang racket 

(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

 ;; left to righ 
 (define (list-of-values1 exps env) 
   (if (no-operands? exps) 
       '() 
       (let* ((first (eval (first-operand exps) env)) 
              (rest (eval (rest-operands exps) env))) 
         (cons first rest)))) 
  
;; right to left 
 (define (list-of-values2 exps env) 
   (if (no-operands? exps) 
       '() 
       (let* ((rest (eval (rest-operands exps) env)) 
              (first (eval (first-operand exps) env))) 
         (cons first second))))