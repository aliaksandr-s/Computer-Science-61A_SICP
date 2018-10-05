;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;


#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(provide (all-defined-out))

;;; this next procedure is useful for moving around
(define (move-loop who)
  (newline)
  (print (send who exits))
  (display "?  > ")
  (let ((dir (read)))
    (if (equal? dir 'stop)
	(newline)
	(begin (print (send who go dir))
	       (move-loop who)))))


;; One-way paths connect individual places.

(define (can-go from direction to)
  (send from new-neighbor direction to))


(define (announce-take name thing)
  (newline)
  (display name)
  (display " took ")
  (display (send thing get-name))
  (newline))

(define (announce-move name old-place new-place)
  (newline)
  (newline)
  (display name)
  (display " moved from ")
  (display (send old-place get-name))
  (display " to ")
  (display (send new-place get-name))
  (newline))

(define (have-fit p)
  (newline)
  (display "Yaaah! ")
  (display (send p get-name))
  (display " is upset!")
  (newline))

(define (pick-random set)
  (list-ref set (random (length set)) ))

(define (delete thing stuff)
  (cond ((null? stuff) '())
	((eq? thing (car stuff)) (cdr stuff))
	(else (cons (car stuff) (delete thing (cdr stuff)))) ))

(define (person? obj)
  (send obj person?))

(define (thing? obj)
  (send obj thing?))

(define (place? obj)
  (send obj place?))

(define (whereis person)
  (send (send person get-place) get-name))

(define (owner thing)
  (let ([possessor (send thing get-possessor)])
    (if (object? possessor) 
        (send possessor get-name) 
        possessor)))

(define (owner-things owner) 
          (map (lambda (thing) (send thing get-name)) 
        (send owner get-possessions)))