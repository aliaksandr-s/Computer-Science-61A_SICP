#lang racket/base

(require rackunit)
(require racket/trace)
(require simply-scheme)
(require "./tags.rkt")

(define (make-student-record name grade) (cons name grade))
(define (make-name first last) (cons first last))
(define (make-grade total-points) total-points)

(define (get-name student) (car student))
(define (get-grade student) (cdr student))
(define (get-first-name name) (car name))
(define (get-last-name name) (cdr name))

(define (convert-to-colleen-format records)
  (define (convert record)
    (make-tagged-record 'Colleen 
                        (make-student-record (make-name (get-first-name (get-name record)) 
                                                        (get-last-name (get-name record))) 
                                             (make-grade (get-grade record)))))
  (map convert records))

(define records '(((Bill . Gates) . 30) ((Mark . Zuker) . 3) ((Joe . Nover) . 53)))
(define res-records '((Colleen . ((Bill . Gates) . 30)) (Colleen . ((Mark . Zuker) . 3)) (Colleen . ((Joe . Nover) . 53))))
(check-equal? (convert-to-colleen-format records) res-records)