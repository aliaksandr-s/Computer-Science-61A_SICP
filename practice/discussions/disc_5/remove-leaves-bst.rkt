#lang racket/base

(require rackunit)
(require racket/trace)
(require "./bst.rkt")

(define (remove-leaves bst)
  (cond [(null? bst) '()]
        [(and (null? (right-branch bst)) 
              (null? (left-branch bst))) '()]
        [else (make-tree (entry bst) 
                         (remove-leaves (left-branch bst)) 
                         (remove-leaves (right-branch bst)))]))

(define tree1
  (make-tree 7
	  (make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	  (make-tree 9 '() (make-tree 11 '() '()))))

(define tree2
  (make-tree 7
	  (make-tree 3 '() '())
	  (make-tree 9 '() '())))

(check-equal? (remove-leaves tree1) tree2)