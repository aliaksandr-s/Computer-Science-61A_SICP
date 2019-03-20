#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (interleave () () ()))))
(run-query '(assert!
             (rule (interleave () ?ls ?ls))))
(run-query '(assert!
             (rule (interleave (?car . ?cdr) ?ls (?car . ?r-cdr))
                   (interleave ?ls2 ?cdr ?r-cdr))))

          
(check-equal? (run-query '(interleave (1 2 3) (a b c d) ?what))
                         '((interleave (1 2 3) (a b c d) (1 a 2 b 3 c d))))
