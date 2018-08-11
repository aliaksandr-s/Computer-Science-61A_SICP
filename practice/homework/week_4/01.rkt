#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (substitute lst old-w new-w)
  (define (replace word)
    (if (equal? old-w word)
        new-w
        word))
  (define (replace-in-list arg)
    (if (list? arg)
        (substitute arg old-w new-w)
        (replace arg)))
  (map replace-in-list lst))

(check-equal? (substitute '((lead guitar) (bass guitar) (rhythm guitar) drums)
                          'guitar 
                          'axe)
              '((lead axe) (bass axe) (rhythm axe) drums))

