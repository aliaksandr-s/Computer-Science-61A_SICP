#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)


(define (replace word lst-1 lst-2)
  (cond [(empty? lst-1) word]
        [(equal? word (car lst-1)) (car lst-2)]
        [else (replace word (cdr lst-1) (cdr lst-2))]))

(check-equal? (replace 2 '(1 2 3) '(one two three)) 'two)
(check-equal? (replace 5 '(1 2 3) '(one two three)) 5)


(define (substitute lst old-l new-l)
  (define (replace-in-list arg)
    (if (list? arg)
        (substitute arg old-l new-l)
        (replace arg old-l new-l)))
  (map replace-in-list lst))

(check-equal? (substitute '((4 calling birds) (3 french hens) (2 turtle doves))
                          '(1 2 3 4) 
                          '(one two three four))
              '((four calling birds) (three french hens) (two turtle doves)))

