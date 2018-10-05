#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./tables.rkt")
(require "./utils.rkt")
(require "./basic-object.rkt")
(require "./thing.rkt")

(provide (all-defined-out))

(define place%
  (class basic-object%
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
    (define/public (may-enter? person) #t)
    (define/public (enter new-person)
      (when (memq new-person people)
	          (error "Person already in this place" (list name new-person)))
      (when (not (send this may-enter? new-person))
            (error "Place is locked. You can't enter"))
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

(define locked-place%
  (class place%
    (init-field [locked? #t])
    (super-new)
    (define/override (may-enter? person) (not locked?))
    (define/public (unlock) 
      (set! locked? #f)
      'unlocked) ))

(define garage%
  (let ([counter 0])
    (class place%
      (super-new)
      (init-field [ticket-table (make-table)])
      (inherit-field things)
      (define/public (park a-car)
        (when (not (memq a-car things))
              (error "Car is not in the garage"))
        (let ([ticket (new ticket% [name 'ticket] [sn counter])]
              [owner (send a-car get-possessor)]) 
             (set! counter (+ 1 counter))
             (insert! (send ticket get-sn) a-car ticket-table)
             (send owner lose a-car)
             (send this appear ticket)
             (send owner take ticket)))
      (define/public (unpark ticket) 
        (when (not (eq? (send ticket get-name) 'ticket))
              (error "You need to provide a ticket")) 
        (let ([a-car (lookup (send ticket get-sn) ticket-table)]
              [owner (send ticket get-possessor)]) 
          (when (not a-car) 
                (error "Ticket with this s/n not found"))
          (send owner lose ticket)
          (send owner take a-car)
          (insert! (send ticket get-sn) #f ticket-table))) )))