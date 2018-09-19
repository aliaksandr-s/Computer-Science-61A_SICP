#lang racket/base

(require rackunit)
(require racket/trace)
(require simply-scheme)
(require "./tags.rkt")
(require "./table.rkt")

; type tags

(define (make-student-Kevin first-name last-name grade)
  (make-tagged-record 'Kevin (cons (cons last-name first-name) grade)))

(define (make-student-Phil first-name last-name grade)
  (make-tagged-record 'Phil (cons (word (first first-name) (first last-name)) grade)))

(define (get-first-name-tt record)
  (cond [(eq? (type-tag record) 'Kevin) 
          (cdar (content record))]
        [(eq? (type-tag record) 'Phil) 
          (first (car (content record)))]
        [else (error "Unknown type")]))

(define (get-last-name-tt record)
  (cond [(eq? (type-tag record) 'Kevin) 
          (caar (content record))]
        [(eq? (type-tag record) 'Phil) 
          (last (car (content record)))]
        [else (error "Unknown type")]))


(check-equal? (get-first-name-tt (make-student-Kevin 'George 'Bush 10)) 'George)
(check-equal? (get-last-name-tt (make-student-Kevin 'George 'Bush 10)) 'Bush)
(check-equal? (get-first-name-tt (make-student-Phil 'George 'Bush 10)) "G")
(check-equal? (get-last-name-tt (make-student-Phil 'George 'Bush 10)) "B")

; ddp

(put 'Kevin 'first-name (lambda (record) (cdar (content record))))
(put 'Kevin 'last-name (lambda (record) (caar (content record))))
(put 'Phil 'first-name (lambda (record) (first (car (content record)))))
(put 'Phil 'last-name  (lambda (record) (last (car (content record)))))

(define (get-first-name-dd record)
  (operate 'first-name record))

(define (get-last-name-dd record)
  (operate 'last-name record))

(define (operate op obj)
  (let ((proc (get (type-tag obj) op)))
    (if proc
        (proc (content obj))
        (error "Unknown operator"))))

(check-equal? (get-first-name-tt (make-student-Kevin 'George 'Bush 10)) 'George)
(check-equal? (get-last-name-tt (make-student-Kevin 'George 'Bush 10)) 'Bush)
(check-equal? (get-first-name-tt (make-student-Phil 'George 'Bush 10)) "G")
(check-equal? (get-last-name-tt (make-student-Phil 'George 'Bush 10)) "B")