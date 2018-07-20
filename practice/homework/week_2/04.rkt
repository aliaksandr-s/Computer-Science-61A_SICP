#lang racket

(define (fact n)
  (if (= n 0)
      1
      (* n (fact (- n 1)))))

(fact 5)

((lambda (n)
    (define (iter i current)
      (if (= n i)
        current
        (iter (+ i 1) (* current (+ i 1) ))))
    (if (= n 0)
      1
      (iter 1 1)))
5)
