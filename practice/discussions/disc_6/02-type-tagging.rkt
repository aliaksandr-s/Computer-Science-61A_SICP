#lang racket/base

(require rackunit)
(require racket/trace)
(require "./tags.rkt")

(provide (combine-out make-student-list make-student-pair))

(define (make-student-list name grade)
  (make-tagged-record 'student-list (list name grade)))

(define (make-student-pair name grade)
  (make-tagged-record 'student-pair (cons name grade)))

(define (get-name record)
  (cond [(eq? (type-tag record) 'student-list) 
          (car (content record))]
        [(eq? (type-tag record) 'student-pair) 
          (car (content record))]
        [else (error "Unknown type")]))

(define (get-grade record)
  (cond [(eq? (type-tag record) 'student-list) 
          (cadr (content record))]
        [(eq? (type-tag record) 'student-pair) 
          (cdr (content record))]
        [else (error "Unknown type")]))

(check-equal? (get-name (make-student-list 'joe 10)) 'joe)
(check-equal? (get-name (make-student-pair 'joe 10)) 'joe)
(check-equal? (get-grade (make-student-list 'joe 10)) 10)
(check-equal? (get-grade (make-student-pair 'joe 10)) 10)