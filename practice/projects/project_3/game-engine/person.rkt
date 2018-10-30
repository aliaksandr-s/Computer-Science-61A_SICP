#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./utils.rkt")
(require "./basic-object.rkt")

(provide (all-defined-out))

(define person%
  (class basic-object%
    (init-field name place
                [possessions '()]
                [saying ""])
    (super-new)
    (send place enter this)
    (define/public (get-name) name)
    (define/public (type) 'person)
    (define/public (get-possessions) possessions)
    (define/public (get-place) place)
    (define/override (person?) #t)
    (define/public (look-around)
      (map (lambda (obj) (send obj get-name))
	           (filter (lambda (thing) (not (eq? thing this)))
		           (append (send place get-things) (send place get-people)))))
    (define/public (take thing)
      (cond ((not (thing? thing)) 
              (error "Not a thing" thing))
	          ((not (memq thing (send place get-things)))
	            (error "Thing taken not at this place"
		          (list (send place get-name) thing)))
	          ((memq thing possessions) 
              (error "You already have it!"))
	          (else
	            (announce-take name thing)
	            (set! possessions (cons thing possessions))
	       
              ;; If somebody already has this object...
              (for-each
                (lambda (pers)
                  (when (and (not (eq? pers this)) ; ignore myself
                             (memq thing (send pers get-possessions)))
                    (begin
                      (send pers lose thing)
                      (have-fit pers))))
                (send place get-people))
                  
              (send thing change-possessor this)
              'taken)))
    (define/public (take-all) 
      (let ([things (send place get-things)]) 
           (define available-things 
                   (filter (lambda (thing) 
                           (eq? (send thing get-possessor) 'no-one)) 
                   things))
           (for-each (lambda (thing) (send this take thing)) 
                     available-things) ))
    (define/public (lose thing)
      (set! possessions (delete thing possessions))
      (send thing change-possessor 'no-one)
      'lost)
    (define/public (talk) (print saying))
    (define/public (set-talk string) (set! saying string))
    (define/public (exits) (send place exits))
    (define/public (notice person) (send this talk))
    (define/public (go direction)
      (let ((new-place (send place look-in direction)))
        (cond ((or (null? new-place) 
                   (not (send new-place may-enter? this)))
              (error "Can't go" direction))
        (else
          (send place exit this)
          (announce-move name place new-place)
          (for-each (lambda (p)
                            (send place gone p)
                            (send new-place appear p))
                    possessions)
          (set! place new-place)
          (send new-place enter this))))) ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define *foods* '(pizza potstickers coffee))

(define (edible? thing)
  (member? (send thing name) *foods*))

(define thief%
  (class person%
    (super-new)
    (init-field initial-place
                [behavior 'steal])
    (inherit-field place)
    (define/override (type) 'thief)
    (define/override (notice person)
      (if (eq? behavior 'run)
	        (send this go (pick-random (send place exits)))
	    (let ((food-things
	        (filter (lambda (thing)
			 (and (edible? thing)
			      (not (eq? (send thing possessor) this))))
		       (send place things))))
	  (when (not (null? food-things))
	      (begin
	       (send this take (car food-things))
	       (set! behavior 'run)
	       (send this notice person)) )))) )