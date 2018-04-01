#lang racket

(require rackunit)

(define (first str) 
  (substring str 0 1))

(define (butfirst str)
  (substring str 1))

(define (vowel? letter)
  (string-contains? "aeiou" letter))

(define (pigl str)
  (if (vowel? (first str))
      (string-append str "ay")
      (pigl (string-append (butfirst str) (first str)))))

(check-equal? (first "hello") "h")

(check-equal? (butfirst "hello") "ello")

(check-equal? (vowel? "a") #t)
(check-equal? (vowel? "c") #f)

(check-equal? (pigl "hello") "ellohay")
(check-equal? (pigl "pig") "igpay")
(check-equal? (pigl "trash") "ashtray")
