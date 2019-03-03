#lang racket
(require "../../helpers/evaluators/qeury-eval.rkt")

;; Exercise 4.55

;;; a
(run-query '(supervisor ?name (Bitdiddle Ben)))

;'((supervisor (Tweakit Lem E) (Bitdiddle Ben))
;  (supervisor (Fect Cy D) (Bitdiddle Ben))
;  (supervisor (Hacker Alyssa P) (Bitdiddle Ben)))
;
;;; b
(run-query '(job ?name (accounting . ?type)))
;'((job (Cratchet Robert) (accounting scrivener))
;  (job (Scrooge Eben) (accounting chief accountant)))

;;; c
(run-query '(address ?name (Slumerville . ?street-address)))
;'((address (Aull DeWitt) (Slumerville (Onion Square) 5))
;  (address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))
;  (address (Bitdiddle Ben) (Slumerville (Ridge Road) 10)))
