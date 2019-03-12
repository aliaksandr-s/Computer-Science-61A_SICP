#lang racket
(require "../../helpers/evaluators/qeury-eval.rkt")


(run-query '(assert!
             (rule (can-replace ?person-1 ?person-2)
                   (and (job ?person-1 ?job-1)
                        (job ?person-2 ?job-2)
                        (not (same ?person-1 ?person-2))
                        (or (same ?job-1 ?job-2)
                            (can-do-job ?job-1 ?job-2))))))

;;; a
(run-query '(can-replace ?person-1 (Fect Cy D)))

;; b
(run-query '(and (can-replace ?x ?y)
                 (salary ?x ?x-salary)
                 (salary ?y ?y-salary)
                 (lisp-value > ?y-salary ?x-salary)))
