#lang racket/base

(require rackunit)
(require racket/trace)
(require simply-scheme)
(require "./tags.rkt")
(require "./table.rkt")

; type tags

(define (make-student-Eric name grade)
  (make-tagged-record 'Eric (cons name grade)))

(define (make-student-Steph name grade)
  (make-tagged-record 'Steph (cons name grade)))

(define (get-total-points-tt record)
  (cond [(eq? (type-tag record) 'Eric)
         (cdr (content record))]
        [(eq? (type-tag record) 'Steph)
         (foldr + 0 (map cadr (cdr (content record))))]
        [else (error "Unknown type")]))

(check-equal? (get-total-points-tt (make-student-Eric 'Joe 55)) 55)
(check-equal? (get-total-points-tt (make-student-Steph 'Joe '((math 20) (biology 20) (cs 15)))) 55)

; ddp

(put 'Eric 'get-total-points (lambda (record) (cdr (content record))))
(put 'Steph 'get-total-points (lambda (record) (foldr + 0 (map cadr (cdr (content record))))))

(define (get-total-points-dd record)
  ((get (type-tag record) 'get-total-points) record))

(check-equal? (get-total-points-dd (make-student-Eric 'Joe 55)) 55)
(check-equal? (get-total-points-dd (make-student-Steph 'Joe '((math 20) (biology 20) (cs 15)))) 55)
