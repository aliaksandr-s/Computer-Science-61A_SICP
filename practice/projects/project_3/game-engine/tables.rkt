;;; Section 3.3.3 -- Tables

;;; One-dimensional tables

#lang racket

(require rackunit)
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(provide (all-defined-out))

(define (lookup key table)
  (let ((record (massoc key (mcdr table))))
    (if (not record)
        #f
        (mcdr record))))

(define (insert! key value table)
  (let ((record (massoc key (mcdr table))))
    (if (not record)
        (set-mcdr! table
                  (mcons (mcons key value) (mcdr table)))
        (set-mcdr! record value)))
  'ok)

(define (make-table)
  (mlist '*table*))

;;; (define my-table (make-table))
;;; (insert! 'key 'value my-table)
;;; (insert! 'key #f my-table)
;;; (lookup 'key my-table)