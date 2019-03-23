#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (appear ?item () 0)) ))
(run-query '(assert!
             (rule (appear ?item (?item . ?cdr) (s ?count))
                   (appear ?item ?cdr ?count) ) ))
(run-query '(assert!
             (rule (appear ?item (?car . ?cdr) ?count)
                   (and (not (same ?car ?item))
                        (appear ?item ?cdr ?count) ) ) ))

(check-equal? (run-query '(appear 3 (1 2 3 3 2 3) ?result))
                         '((appear 3 (1 2 3 3 2 3) (s (s (s 0))) ) ))
