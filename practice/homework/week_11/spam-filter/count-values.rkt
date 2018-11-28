#lang racket

(require "../../../helpers/mapreduce/mapreduce-single.rkt")
(require "dataSet.rkt")
(require rackunit)

(define (mapper data)
    (map (lambda (value) (make-kv-pair value 1)) (list (caddr (kv-value data)))))

(define ans (mapreduce mapper + 0 dataSet))
ans

(define sorted (sort ans (lambda (x y) (> (kv-value x) (kv-value y)))))
sorted