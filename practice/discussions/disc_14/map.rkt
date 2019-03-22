#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (listify ?x (?x) ))))

(run-query '(assert! 
              (rule (map ?proc () ()))))
(run-query '(assert! 
              (rule (map ?proc (?car . ?cdr) (?n-car . ?n-cdr))
                    (and (?proc ?car ?n-car)
                         (map ?proc ?cdr ?n-cdr)) )))

(check-equal? (run-query '(listify 3 ?what))
                         '((listify 3 (3))))

(check-equal? (run-query '(map listify (1 2 3) ?what))
                         '((map listify (1 2 3) ((1) (2) (3)))))

(check-equal? (run-query '(map ?what (1 2 3) ((1) (2) (3))))
                         '((map listify (1 2 3) ((1) (2) (3)))))

