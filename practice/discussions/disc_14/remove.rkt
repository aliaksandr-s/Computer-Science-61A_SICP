#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (remove ?item () ()))))
(run-query '(assert!
             (rule (remove ?item (?item . ?cdr) ?result)
                   (remove ?item ?cdr ?result) )))
(run-query '(assert!
             (rule (remove ?item (?car . ?cdr) (?car . ?r-cdr))
                   (and (not (same ?item ?car))
                        (remove ?item ?cdr ?r-cdr)) )))
          



(check-equal? (run-query '(remove 3 (1 2 3 4 3 2) ?what))
                         '((remove 3 (1 2 3 4 3 2) (1 2 4 2))))
