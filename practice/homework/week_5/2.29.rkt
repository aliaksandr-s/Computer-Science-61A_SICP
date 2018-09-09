#lang racket/base

(require rackunit)
(require racket/trace)

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

(define (torque branch)
  (* (branch-length branch)
     (branch-weight branch) ))

(define (branch-weight branch)
  (+ (total-weight (branch-structure branch))))

(define (total-weight mobile)
  (cond [(number? mobile) mobile]
        [else (+ (total-weight (branch-structure (left-branch mobile)))
                 (total-weight (branch-structure (right-branch mobile))))]))

(define (balanced? mobile)
  (cond [(not (number? (branch-structure (left-branch mobile))))
          (balanced? (branch-structure (left-branch mobile)))]
        [(not (number? (branch-structure (right-branch mobile))))
          (balanced? (branch-structure (right-branch mobile)))]
        [else (= (torque (left-branch mobile)) 
                 (torque (right-branch mobile)))]))

(define test-mobile
  (make-mobile (make-branch 1 2)
               (make-branch 3 (make-mobile (make-branch 4 5) 
                                           (make-branch 6 7)))))
(define test-mobile-1
  (make-mobile (make-branch 1 2)
               (make-branch 3 4)))

(define test-mobile-balanced
  (make-mobile (make-branch 1 10)
               (make-branch 1 (make-mobile (make-branch 5 1) 
                                           (make-branch 5 1)))))
(define test-mobile-unbalanced
  (make-mobile (make-branch 2 4)
               (make-branch 1 (make-mobile (make-branch 2 4) 
                                           (make-branch 2 1)))))

(check-equal? (left-branch test-mobile-1) (make-branch 1 2))
(check-equal? (right-branch test-mobile-1) (make-branch 3 4))
(check-equal? (branch-length (make-branch 1 2)) 1)
(check-equal? (branch-structure (make-branch 1 2)) 2)

(check-equal? (total-weight test-mobile) 14)

(check-equal? (torque (left-branch test-mobile)) 2)
(check-equal? (torque (right-branch test-mobile)) 36)

(check-equal? (balanced? test-mobile-balanced) #t)
(check-equal? (balanced? test-mobile-unbalanced) #f)