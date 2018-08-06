#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (first-name student)
  (cdr (car student)))

(define (last-name student)
  (car (car student)))

(define (student-id student)
  (cdr student))


(define (make-name first last)
  (cons last first))

(define (make-student name sid)
  (cons name sid))

(define brian (make-student (make-name 'brian 'harvey) 176))
(define justin (make-student (make-name 'justin 'chen) 205))
(define students-list (list brian justin))

(define (get-last-names records)
  (map (lambda (rec) (last-name rec)) records))

(check-equal? (get-last-names students-list) '(harvey chen))