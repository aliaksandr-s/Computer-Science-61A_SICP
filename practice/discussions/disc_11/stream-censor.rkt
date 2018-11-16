#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)

(define (stream-censor s replacements)
  (stream-map (lambda (stream-el) 
                      (define match (assoc stream-el replacements))
                      (if match 
                          (cadr match) 
                          stream-el) ) s))

(define s1 (stream "hello" "you" "weirdo"))
(define t1 '(("you" "I-am") ("weirdo" "an-idiot")))
(define s-expected (stream "hello" "I-am" "an-idiot"))
(check-equal? (stream->list (stream-censor s1 t1)) '("hello" "I-am" "an-idiot"))