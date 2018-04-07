#lang racket

(require rackunit)
(require simply-scheme)

(define (dupls-removed sent)
  (cond ((empty? sent) sent)
        ((member? (first sent) (bf sent)) 
                  (dupls-removed (bf sent)))
        (else (sentence (first sent) (dupls-removed (bf sent))))))

(check-equal? (dupls-removed `(a b c a e d e b)) `(c a d e b))
(check-equal? (dupls-removed `(a b c)) `(a b c))
(check-equal? (dupls-removed `(a a a a b a a)) `(b a))