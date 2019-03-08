#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (deep-member ?item (?item . ?cdr))) ))
(run-query '(assert!
             (rule (deep-member ?item (?car . ?cdr)) 
                   (deep-member ?item ?cdr)) ))
(run-query '(assert!
             (rule (deep-member ?item (?car . ?cdr)) 
                   (deep-member ?item ?car)) ))

(check-equal? (run-query '(deep-member 4 (1 2 3 4 5)) )
                         '((deep-member 4 (1 2 3 4 5))) )

(check-equal? (run-query '(deep-member 3 (4 5 6)) )
                         '() )

(check-equal? (run-query '(deep-member 3 (1 2 (3 4) 5)) )
                         '((deep-member 3 (1 2 (3 4) 5))) )


