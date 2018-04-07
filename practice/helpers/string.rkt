#lang racket

(require rackunit)
(provide (all-defined-out))


(define (first str) 
  (substring str 0 1))

(check-equal? (first "hello") "h")
;;; -------------------------

(define (butfirst str)
  (substring str 1))

(check-equal? (butfirst "hello") "ello")
;;; -------------------------

(define (last str)
  (substring str (- (string-length str) 1)))

(check-equal? (last "hello") "o")
;;; -------------------------

(define (butlast str)
  (substring str 0 (- (string-length str) 1)))

(check-equal? (butlast "hello") "hell")
;;; -------------------------

(define (vowel? letter)
  (string-contains? "aeiou" letter))

(check-equal? (vowel? "a") #t)
(check-equal? (vowel? "c") #f)
;;; -------------------------
