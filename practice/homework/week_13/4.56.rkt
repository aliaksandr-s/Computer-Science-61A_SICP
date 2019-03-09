#lang racket
(require "../../helpers/evaluators/qeury-eval.rkt")

;;; a
(run-query '(and (supervisor ?name (Bitdiddle Ben))
                 (address ?name ?where)))
;;; b
(run-query '(and (salary ?person ?p-salary)
                 (salary (Bitdiddle Ben) ?ben-salary)
                 (lisp-value < ?p-salary ?ben-salary) ))

;;; c
(run-query '(and (supervisor ?person ?boss)
                 (job ?boss ?job)
                 (not (job ?boss (computer . ?any)))) )
