#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (last-pair (?x) (?x)))))

(run-query '(assert!
             (rule (last-pair (?x . ?y) (?z))
                   (last-pair ?y (?z)))))

(check-equal? (run-query '(last-pair (3) ?x))
                         '((last-pair (3) (3))))

(check-equal? (run-query '(last-pair (1 2 3) ?x))
                         '((last-pair (1 2 3) (3))))

(check-equal? (run-query '(last-pair (2 ?x) (3)))
                         '((last-pair (2 3) (3))))

;; This won't return as there are infinite solutions
;; (run-query '(last-pair ?x (3)))
