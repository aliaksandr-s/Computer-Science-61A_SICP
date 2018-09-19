#lang racket/base

(require rackunit)
(require "./table.rkt")
(require "./tags.rkt")
(require "./02-type-tagging.rkt")

(put 'student-list 'name (lambda (record) (car record)))
(put 'student-list 'grade (lambda (record) (cadr record)))
(put 'student-pair 'name (lambda (record) (car record)))
(put 'student-pair 'grade (lambda (record) (cdr record)))

(define (get-name record)
  (operate 'name record))

(define (get-grade record)
  (operate 'grade record))

(define (operate op obj)
  (let ((proc (get (type-tag obj) op)))
    (if proc
        (proc (content obj))
        (error "Unknown operator"))))

(check-equal? (get-name (make-student-list 'joe 10)) 'joe)
(check-equal? (get-name (make-student-pair 'joe 10)) 'joe)
(check-equal? (get-grade (make-student-list 'joe 10)) 10)
(check-equal? (get-grade (make-student-pair 'joe 10)) 10)