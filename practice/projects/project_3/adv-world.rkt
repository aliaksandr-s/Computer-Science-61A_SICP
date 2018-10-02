;;;  Data for adventure game.  This file is adv-world.scm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; setting up the world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./adv.rkt")

(provide (all-defined-out))

(define Soda (new place% [name 'Soda]))
(define BH-Office (new place% [name 'BH-Office]))
(define MJS-Office (new place% [name 'MJS-Office]))
(define art-gallery (new place% [name 'art-gallery]))
(define Pimentel (new place% [name 'Pimentel]))
(define 61A-Lab (new place% [name '61A-Lab]))
(define Sproul-Plaza (new place% [name 'Sproul-Plaza]))
(define Telegraph-Ave (new place% [name 'Telegraph-Ave]))
(define Noahs (new place% [name 'Noahs]))
(define Intermezzo (new place% [name 'Intermezzo]))
(define s-h (new place% [name 'sproul-hall]))

(can-go Soda 'up art-gallery)
(can-go art-gallery 'down Soda)
(can-go art-gallery 'west BH-Office)
(can-go BH-Office 'east art-gallery)
(can-go art-gallery 'east MJS-Office)
(can-go MJS-Office 'west art-gallery)
(can-go Soda 'south Pimentel)
(can-go Pimentel 'north Soda)
(can-go Pimentel 'south 61A-Lab)
(can-go 61A-Lab 'north Pimentel)
(can-go 61A-Lab 'west s-h)
(can-go s-h 'east 61A-Lab)
(can-go Sproul-Plaza 'east s-h)
(can-go s-h 'west Sproul-Plaza)
(can-go Sproul-Plaza 'north Pimentel)
(can-go Sproul-Plaza 'south Telegraph-Ave)
(can-go Telegraph-Ave 'north Sproul-Plaza)
(can-go Telegraph-Ave 'south Noahs)
(can-go Noahs 'north Telegraph-Ave)
(can-go Noahs 'south Intermezzo)
(can-go Intermezzo 'north Noahs)

;; Some people.
; MOVED above the add-entry-procedure stuff, to avoid the "The computers
; seem to be down" message that would occur when hacker enters 61A-Lab
; -- Ryan Stejskal

(define Brian (new person% [name 'Brian] [place BH-Office]))
(define hacker (new person% [name 'hacker] [place 61A-Lab]))
;;; (define nasty (new thief 'nasty sproul-plaza)) TODO: uncoment when thief is implemented

(define (sproul-hall-exit)
   (error "You can check out any time you'd like, but you can never leave"))

(define (bh-office-exit)
  (print "What's your favorite programming language?")
  (let ((answer (read)))
    (if (eq? answer 'scheme)
	(print "Good answer, but my favorite is Logo!")
	(begin (newline) (bh-office-exit)))))
    

(send s-h add-entry-procedure
 (lambda () (print "Miles and miles of students are waiting in line...")))
(send s-h add-exit-procedure sproul-hall-exit)
(send BH-Office add-exit-procedure bh-office-exit)
(send Noahs add-entry-procedure
 (lambda () (print "Would you like lox with it?")))
(send Noahs add-exit-procedure
 (lambda () (print "How about a cinnamon raisin bagel for dessert?")))
(send Telegraph-Ave add-entry-procedure
 (lambda () (print "There are tie-dyed shirts as far as you can see...")))
(send 61A-Lab add-entry-procedure
 (lambda () (print "The computers seem to be down")))
(send 61A-Lab add-exit-procedure
 (lambda () (print "The workstations come back to life just in time.")))

;; Some things.

(define bagel (new thing% [name 'bagel]))
(send Noahs appear bagel)

(define coffee (new thing% [name 'coffee]))
(send Intermezzo appear coffee)