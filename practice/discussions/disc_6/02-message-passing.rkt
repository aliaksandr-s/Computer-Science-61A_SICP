#lang racket/base

(require rackunit)

(define (make-student name grade)
  (lambda (message)
    (cond [(eq? message 'name) name]
          [(eq? message 'grade) grade]
          [else (error "Unknown message")])))

(define (operate op obj)
 (obj op))

(define (get-name student)
  (operate 'name student))

(define (get-grade student)
  (operate 'grade student))

(check-equal? (get-name (make-student 'Joe 55)) 'Joe)
(check-equal? (get-grade (make-student 'Joe 55)) 55)