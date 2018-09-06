#lang racket/base

(require rackunit)
(require racket/trace)
(require "./bst.rkt")

(define (width-of tree)
  (+ (width-of-left tree) 
     (width-of-right tree)))

(define (width-of-left tree)
  (if (null? (left-branch tree)) 
      0 
      (+ 1 (width-of-left (left-branch tree)))))

(define (width-of-right tree)
  (if (null? (right-branch tree)) 
      0 
      (+ 1 (width-of-right (right-branch tree)))))

(define tree1
  (make-tree 7
	  (make-tree 3
	    (make-tree 1 '() '())
	    (make-tree 5 '() '()))
	  (make-tree 9 '() (make-tree 11 '() '()))))

(check-equal? (width-of tree1) 4)