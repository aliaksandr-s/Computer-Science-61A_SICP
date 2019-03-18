#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (append () ?ls2 ?ls2) )))
(run-query '(assert!
             (rule (append (?car . ?cdr) ?ls2 (?car . ?r-cdr))
                   (append ?cdr ?ls2 ?r-cdr)) ))

(run-query '(assert!
             (rule (reverse () ()))))
(run-query '(assert!
             (rule (reverse (?car . ?cdr) ?reversed-ls)
                   (and (reverse ?cdr ?r-cdr)
                        (append ?r-cdr (?car) ?reversed-ls))) ))



(check-equal? (run-query '(reverse (1 2 3) ?x))
                         '((reverse (1 2 3) (3 2 1))))
