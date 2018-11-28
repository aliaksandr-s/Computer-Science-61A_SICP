#lang racket

(require "mapreduce-single.rkt")
(require "bible-data-small.rkt")

(define (mapper input-kv-pair)
    ;;; (println input-kv-pair)
    (map (lambda (wd) 
                 (begin ;(println wd)
                        (make-kv-pair wd 1))) 
         (kv-value input-kv-pair)))

(define start (current-inexact-milliseconds))
(define ans (mapreduce mapper + 0 data))
;;; (displayln (- (current-inexact-milliseconds) start))