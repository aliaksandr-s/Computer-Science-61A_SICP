#lang racket/base

(require rackunit)
(require simply-scheme)

(define (first-word? sent) 
  (empty? (bl sent)))

(define (switch sent) 
  (cond
    [(empty? sent) 
      `()]
    [(and 
      (first-word? sent) 
      (member? (last sent) `(you))
        (sentence (switch (bl sent)) `(i)))]
    [(member? (last sent) `(i me)) 
      (sentence (switch (bl sent)) `(you))]
    [(member? (last sent) `(you)) 
      (sentence (switch (bl sent)) `(me))]
    [else (sentence (switch (bl sent)) (last sent))]))

(check-equal? (switch `(you told me that i should wake you up)) `(i told you that you should wake me up))
(check-equal? (switch `(they told me that i should wake you up)) `(they told you that you should wake me up))