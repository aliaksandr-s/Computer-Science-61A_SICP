#lang racket
(provide box-and-pointer-diagram!)

; Generic (mutable and immutable) pair ops
(require scheme/mpair)
(define (gcar x)
  (cond [(mpair? x) (mcar x)]
        [(pair? x)  (car x)]))

(define (gcdr x)
  (cond [(mpair? x) (mcdr x)]
        [(pair? x)  (cdr x)]))

(define (gpair? x)
  (or (pair? x) (mpair? x)))

; External interface
(define target '())
(define (box-and-pointer-diagram! x)
  (if (not (gpair? x))
      (error (format "~a is not a pair!" x))
      (set! target x)))

; A cell
(define tracked-poses (make-hasheq))
(struct pos
  (x y dx dy)
  #:mutable
  #:transparent)

; Drawing, physics, etc.
(define (track! pr suggested-pos)
  (begin
    (hash-set! tracked-poses pr suggested-pos)
    suggested-pos))

(define (pos-iter! a-pos)
  (begin
    (set-pos-x! a-pos
                (+ (pos-x  a-pos)
                   (pos-dx a-pos)))
    (set-pos-y! a-pos
                (+ (pos-y  a-pos)
                   (pos-dy a-pos)))
    (set-pos-dx! a-pos (* (pos-dx a-pos) 0.2))
    (set-pos-dy! a-pos (* (pos-dy a-pos) 0.2))))

(define (pos-repel! p1 p2 [k (/ 1 10)])
  (define dist
    (sqrt (+ (expt (- (pos-x p1) (pos-x p2)) 2)
             (expt (- (pos-y p1) (pos-y p2)) 2))))
  (when (not (= dist 0))
    (define rate
      (/ k
         (sqrt (+ (expt (- (pos-x p1) (pos-x p2)) 2)
                  (expt (- (pos-y p1) (pos-y p2)) 2)))))
    (define x-dir (- (pos-x p1) (pos-x p2)))
    (define y-dir (- (pos-y p1) (pos-y p2)))
    
    (begin
      (set-pos-dx! p1 (+ (pos-dx p1) (* x-dir rate)))
      (set-pos-dy! p1 (+ (pos-dy p1) (* y-dir rate))))))

(define (pos-attract! p1 p2 [k (/ 1 10000)])
  (when (not (equal? p1 p2))
    (define rate
      (* +1 k (- 70 (sqrt (+ (expt (- (pos-x p1) (pos-x p2)) 2)
                             (expt (- (pos-y p1) (pos-y p2)) 2))))))
    (define x-dir (- (pos-x p1) (pos-x p2)))
    (define y-dir (- (pos-y p1) (pos-y p2)))
    
    (begin
      (set-pos-dx! p1 (+ (pos-dx p1) (* x-dir rate)))
      (set-pos-dy! p1 (+ (pos-dy p1) (* y-dir rate))))))

(define (draw-pair dc pr visited [suggested-pos (pos 0 0 0 0)] #:root [root #f])
  (or (hash-ref visited pr #f)
      (let ([mpos (or
                   (hash-ref tracked-poses pr #f)
                   (track! pr suggested-pos))])
        (begin
          (if root
              (send dc set-pen "black" 2 'solid)
              (send dc set-pen "black" 1 'solid))
          (send dc draw-rectangle
                (floor (pos-x mpos))
                (floor (pos-y mpos))
                100 50)
          
          (send dc draw-line
                (+ 50 (pos-x mpos))
                (+ 00 (pos-y mpos))
                (+ 50 (pos-x mpos))
                (+ 50 (pos-y mpos) -2))
          
          (if (gpair? (gcar pr))
              (let ([npos (draw-pair dc (gcar pr) visited
                                     (pos
                                      (- (pos-x mpos) 10)
                                      (+ (pos-y mpos) 5)
                                      0
                                      0))])
                (pos-attract! mpos npos)
                (pos-attract! npos mpos)
                (send dc draw-line
                      (+ 25 (pos-x mpos))
                      (+ 25 (pos-y mpos))
                      (+ 50 (pos-x npos))
                      (+ 25 (pos-y npos))))
              (draw-pict [text (format "~a" (gcar pr))]
                         dc (+ (pos-x mpos)) (pos-y mpos)))
          
          (if (gpair? (gcdr pr))
              (let ([npos (draw-pair dc (gcdr pr) visited
                                     (pos
                                      (+ (pos-x mpos) 10)
                                      (+ (pos-y mpos) 5)
                                      0
                                      0))])
                (pos-attract! mpos npos)
                (pos-attract! npos mpos)
                (send dc draw-line
                      (+ 50 25 (pos-x mpos))
                      (+ 25 (pos-y mpos))
                      (+ 50 (pos-x npos))
                      (+ 25 (pos-y npos))))
              (draw-pict [text (format "~a" (gcdr pr))]
                         dc (+ 50 (pos-x mpos)) (pos-y mpos)))
          (hash-set! visited pr mpos)
          mpos
          ))))


; GUI management
(require racket/gui)
(require pict)

(define win
  (new frame%
       [label "Box-and-pointer diagram"]
       [width 500]
       [height 300]))

(define (render-bpd dc)
  (begin
    (hash-map tracked-poses (λ (k v) (pos-iter! v)))
    (hash-map tracked-poses
              (λ (k p1)
                (hash-map tracked-poses
                          (λ (k p2)
                            (pos-repel! p1 p2)))))
    (when (not (hash-empty? tracked-poses))
      (begin
        (define minx (apply min (hash-map tracked-poses (λ (k v) (pos-x v)))))
        (define miny (apply min (hash-map tracked-poses (λ (k v) (pos-y v)))))
        (send dc set-origin (- 10 minx) (- 10 miny))))
    (send dc set-brush "black" 'transparent)
    (define visited (make-hasheq))
    (when (gpair? target)
      (draw-pair dc target visited #:root #t))
    (set! tracked-poses visited)
    (send win set-label
          (format "Box-and-pointer diagram [~a boxes]"
                  (hash-count tracked-poses)))))

(define can
  (new canvas%
       [parent win]
       [stretchable-height #t]
       [stretchable-width #t]
       [paint-callback
        (λ (can dc)
          (render-bpd dc))]))

(send win show #t)

(define t
  (new timer%
       [notify-callback
        (λ ()
          (send can refresh))]
       [interval 12]))