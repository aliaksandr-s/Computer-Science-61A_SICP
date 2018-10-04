#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(provide (all-defined-out))

(define place%
  (class object%
    (init-field name
                [directions-and-neighbors '()]
                [things '()]
                [people '()] 
                [entry-procs '()]
                [exit-procs '()])
    (super-new)
    (define/public (get-name) name)
    (define/public (get-things) things)
    (define/public (get-people) people)
    (define/public (get-exit-procs) exit-procs)
    (define/public (type) 'place)
    (define/public (neighbors) (map cdr directions-and-neighbors))
    (define/public (exits) (map car directions-and-neighbors))
    (define/public (look-in direction)
      (let ((pair (assoc direction directions-and-neighbors)))
        (if (not pair)
	          '()                     ;; nothing in that direction
	          (cdr pair))))           ;; return the place object
    (define/public (appear new-thing)
      (when (memq new-thing things)
	          (error "Thing already in this place" (list name new-thing)))
      (set! things (cons new-thing things))
      'appeared)
    (define/public (enter new-person)
      (when (memq new-person people)
	          (error "Person already in this place" (list name new-person)))
      (set! people (cons new-person people))
      (for-each (lambda (proc) (proc)) entry-procs)
      (for-each (lambda (person) (send person notice new-person)) (delete new-person people))
      'appeared)
    (define/public (gone thing)
      (when (not (memq thing things))
	          (error "Disappearing thing not here" (list name thing)))
      (set! things (delete thing things)) 
      'disappeared)
    (define/public (exit person)
      (for-each (lambda (proc) (proc)) exit-procs)
        (when (not (memq person people))
	            (error "Disappearing person not here" (list name person)))
        (set! people (delete person people)) 
        'disappeared)

    (define/public (new-neighbor direction neighbor)
        (when (assoc direction directions-and-neighbors)
              (error "Direction already assigned a neighbor" (list name direction)))
        (set! directions-and-neighbors
              (cons (cons direction neighbor) directions-and-neighbors))
        'connected)

    (define/public (add-entry-procedure proc)
      (set! entry-procs (cons proc entry-procs)))
    (define/public (add-exit-procedure proc)
      (set! exit-procs (cons proc exit-procs)))
    (define/public (delete-entry-procedure proc)
      (set! entry-procs (delete proc entry-procs)))
    (define/public (delete-exit-procedure proc)
      (set! exit-procs (delete proc exit-procs)))
    (define/public (clear-all-procs)
      (set! exit-procs '())
      (set! entry-procs '())
      'cleared) ))

(define person%
  (class object%
    (init-field name place
                [possessions '()]
                [saying ""])
    (super-new)
    (send place enter this)
    (define/public (get-name) name)
    (define/public (type) 'person)
    (define/public (get-possessions) possessions)
    (define/public (get-place) place)
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
        (cond ((null? new-place)
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


(define thing%
  (class object%
    (init-field name
                [possessor 'no-one])
    (super-new)
    (define/public (get-possessor) possessor)
    (define/public (get-name) name)
    (define/public (type) 'thing)
    (define/public (change-possessor new-possessor) 
      (set! possessor new-possessor)) ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Implementation of thieves for part two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define *foods* '(pizza potstickers coffee))

(define (edible? thing)
  (member? (send thing name) *foods*))

;;; TODO: edit later to make it work with racket

;;; (define-class (thief name initial-place)
;;;   (parent (person name initial-place))
;;;   (instance-vars
;;;    (behavior 'steal))
;;;   (method (type) 'thief)

;;;   (method (notice person)
;;;     (if (eq? behavior 'run)
;;; 	(ask self 'go (pick-random (ask (usual 'place) 'exits)))
;;; 	(let ((food-things
;;; 	       (filter (lambda (thing)
;;; 			 (and (edible? thing)
;;; 			      (not (eq? (ask thing 'possessor) self))))
;;; 		       (ask (usual 'place) 'things))))
;;; 	  (if (not (null? food-things))
;;; 	      (begin
;;; 	       (ask self 'take (car food-things))
;;; 	       (set! behavior 'run)
;;; 	       (ask self 'notice person)) )))) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility procedures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
  (and (object? obj)
       (member? (send obj type) '(person police thief))))

(define (thing? obj)
  (and (object? obj)
       (eq? (send obj type) 'thing)))