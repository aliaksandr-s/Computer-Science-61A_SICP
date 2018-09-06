#lang racket/base

(require rackunit)
(require racket/trace)
(require "./bst.rkt")

(define (listify bst)
  (cond [(null? bst) '()] 
        [else (append (listify (left-branch bst)) 
                      (list (entry bst)) 
                      (listify (right-branch bst)))]))

(define tree1
  (make-tree 7
	  (make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	  (make-tree 9 '() (make-tree 11 '() '()))))

(check-equal? (listify tree1) '(1 3 5 7 9 11))