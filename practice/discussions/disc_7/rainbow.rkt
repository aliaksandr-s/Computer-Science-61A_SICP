#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define skittle%
  (class object%
    (super-new)
    (init-field color)
    (define/public (get-color) color)))

(define bag%
  (class object%
    (super-new)
    (init-field [skittles '()])
    (define/public (tag-line) 'taste-the-rainbow)
    (define/public (add s) 
      (set! skittles (cons s skittles)))
    (define/public (take) 
      (let ([skitl (car skittles)])
        (set! skittles (cdr skittles))
        skitl))
    (define/public (take-color color) 
      (let ([skitl (findf (lambda (s) (eq? (send s get-color) color)) skittles)])
        (set! skittles (remove skitl skittles))
        skitl)) ))

(check-equal? (send (new skittle% [color 'red]) get-color) 'red)

(define my-bag (new bag%))
(send my-bag add (new skittle% [color 'red]))
(send my-bag add (new skittle% [color 'yellow]))
(send my-bag add (new skittle% [color 'green]))
(send my-bag add (new skittle% [color 'blue]))

(check-equal? (send (send my-bag take) get-color) 'blue)
(check-equal? (send (send my-bag take-color 'yellow) get-color) 'yellow)
(check-equal? (send my-bag take-color 'ruby) #f)