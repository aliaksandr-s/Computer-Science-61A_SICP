#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (first-name student)
  (car (car student)))

(define (last-name student)
  (cdr (car student)))

(define (student-id student)
  (cdr student))


(define (make-name first last)
  (cons first last))

(define (make-student name sid)
  (cons name sid))

(define students-list '(((brian . harvey) . 176) ((justin . chen) . 205)))

(define (get-last-names records)
  (map (lambda (rec) (last-name rec)) records))

(check-equal? (get-last-names students-list) '(harvey chen))