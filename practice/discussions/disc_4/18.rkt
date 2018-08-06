#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (first-name student)
  (cdr (car student)))

(define (last-name student)
  (car (car student)))

(define (student-id student)
  (cdr (car student)))

(define (student-gpa student)
  (cdr (cdr student)))


(define (make-name first last)
  (cons last first))

(define (make-student name sid gpa)
  (cons name (cons sid gpa)))

(define brian (make-student (make-name 'brian 'harvey) 176 5))
(define justin (make-student (make-name 'justin 'chen) 205 4))
(define students-list (list brian justin))

(define (get-gpa records)
  (map (lambda (rec) (student-gpa rec)) records))

(check-equal? (get-gpa students-list) '(5 4))