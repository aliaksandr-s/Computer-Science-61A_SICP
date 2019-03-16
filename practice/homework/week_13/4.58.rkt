#lang racket
(require "../../helpers/evaluators/qeury-eval.rkt")


(run-query '(assert! (rule (independent ?person ?dept-p) 
                           (and (job ?person (?dept-p . ?tittle-p))
                                (supervisor ?person ?boss) 
                                (job ?boss (?dept-b . ?tittle-b))
                                (not (same ?dept-p ?dept-b))  )) ))

(run-query '(independent ?who ?where))
