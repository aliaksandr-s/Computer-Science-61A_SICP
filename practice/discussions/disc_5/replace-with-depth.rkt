#lang racket/base

(require rackunit)
(require racket/trace)


(define (replace-with-depth lst)
  (define (deep-map cntr lol)
    (if (list? lol)
        (map (lambda (el) (deep-map (+ 1 cntr) el)) lol)
        cntr))
  (deep-map 0 lst))

(check-equal? (replace-with-depth '(hello (my name (is)) garply)) 
              '(1 (2 2 (3)) 1))