#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./2.2.rkt")

;;; First implemantation

(define (make-rect-1 start-point lengths) (cons start-point lengths))
(define (rect-lenghts rect) (cdr rect))

(define (rect-width-1 rect) (width (rect-lenghts rect)))
(define (rect-height-1 rect) (height (rect-lenghts rect)))

(define (make-lenghts height width) (cons height width))
(define (height lengths) (car lengths))
(define (width lengths) (cdr lengths))

; Perimeter and area calculations are identical for both implementations
(define (calc-per rect calc-height calc-width)
  (* 2 (+ (calc-height rect) (calc-width rect))))

(define (calc-area rect calc-height calc-width)
  (* (calc-height rect) (calc-width rect)))

(check-equal? (calc-per (make-rect-1 (make-point 0 0) (make-lenghts 3 6))
                        rect-height-1
                        rect-width-1) 18)
(check-equal? (calc-area (make-rect-1 (make-point 0 0) (make-lenghts 3 6))
                          rect-height-1
                          rect-width-1) 18)

;;; Second implementation

(define (make-rect-2 bottom-side left-side) (cons bottom-side left-side))
(define bottom-side car)
(define left-side cdr)

(define (rect-width-2 rect) (- (x-point (end-segment (bottom-side rect))) 
                             (x-point (start-segment (bottom-side rect)))))
(define (rect-height-2 rect) (- (y-point (end-segment (left-side rect))) 
                              (y-point (start-segment (left-side rect)))))


(check-equal? (calc-per (make-rect-2 (make-segment (make-point 0 0) (make-point 6 0)) 
                                     (make-segment (make-point 0 0) (make-point 0 3)))
                        rect-height-2
                        rect-width-2) 
              18)
(check-equal? (calc-area (make-rect-2 (make-segment (make-point 0 0) (make-point 6 0)) 
                                     (make-segment (make-point 0 0) (make-point 0 3)))
                         rect-height-2
                         rect-width-2) 
              18)