#lang racket

(require rackunit)
(require "../../helpers/string.rkt")

(define (plural wd)
  (if (string=? (last wd) "y")
      (string-append (butlast wd) "ies")
      (string-append wd "s")))

(check-equal? (plural "cat") "cats")
(check-equal? (plural "pony") "ponies")