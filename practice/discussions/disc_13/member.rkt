#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (member ?item (?item . ?cdr))) ))
(run-query '(assert!
             (rule (member ?item (?car . ?cdr)) 
                   (member ?item ?cdr)) ))

(check-equal? (run-query '(member 4 (1 2 3 4 5)) )
                         '((member 4 (1 2 3 4 5))) )

(check-equal? (run-query '(member 3 (4 5 6)) )
                         '() )

(check-equal? (run-query '(member 3 (1 2 (3 4) 5)) )
                         '() )


