#lang racket

(require rackunit)
(require "../../helpers/string.rkt")

(define (pigl str)
  (if (vowel? (first str))
      (string-append str "ay")
      (pigl (string-append (butfirst str) (first str)))))

(check-equal? (pigl "hello") "ellohay")
(check-equal? (pigl "pig") "igpay")
(check-equal? (pigl "trash") "ashtray")
