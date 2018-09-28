#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define question%
  (class object%
    (init-field q a hint weight
                [current-answer '()]
                [current-grade 0]
                [current-password 'redrum])
    (super-new) 
    (define/public (read) 
      q)
    (define/public (answer phrase) 
      (set! current-answer phrase)
      (if (equal? phrase a) 
          (set! current-grade weight) 
          (set! current-grade 0))
      '(answer accepted))
    (define/public (cur-answer) 
      current-answer)
    (define/public (grade) 
      current-grade)
    (define/public (get-hint password) 
      (if (equal? current-password password) 
          hint 
          '(wrong password!))) ))

(define q1 (new question% [q '(what is 2+2?)]
                          [a '(5)]
                          [hint '(a radiohead song)]
                          [weight 10]))
                      
(check-equal? (send q1 read) '(what is 2+2?))
(check-equal? (send q1 answer '(17)) '(answer accepted))
(check-equal? (send q1 cur-answer) '(17))
(check-equal? (send q1 grade) 0)
(check-equal? (send q1 answer '(5)) '(answer accepted))
(check-equal? (send q1 grade) 10)
(check-equal? (send q1 get-hint 'some-password) '(wrong password!))
(check-equal? (send q1 get-hint 'redrum) '(a radiohead song))

(define bonus-question%
  (class question%
    (super-new [a '()]
               [hint '(a bonus question gives no hints)]
               [weight 0])))

(check-equal? (send (new bonus-question% [q '(explain the popularity of Twilight)]) get-hint 'redrum) 
              '(a bonus question gives no hints))

(define midterm%
  (class object%
    (init-field q-ls)
    (super-new)
    (define/public (get-q n) 
      (if (> n (- (length q-ls) 1)) 
          '(you are done) 
          (list-ref q-ls n)))
    (define/public (grade) 
      (foldr + 0 (map (lambda (q) (send q grade)) q-ls))) ))

(define q3 (new question% [q '(what is 2+2?)]
                          [a '(4)]
                          [hint '(a radiohead song)]
                          [weight 10]))

(define q4 (new question% [q '(what is 3+3?)]
                          [a '(6)]
                          [hint '(a radiohead song)]
                          [weight 30]))
                          
(define m (new midterm% [q-ls (list q3 q4)]))
(check-equal? (send q4 read) (send (send m get-q 1) read))
(check-equal? (send m grade) 0)
(check-equal? (send q4 answer '(6)) '(answer accepted))
(check-equal? (send m grade) 30)

(define proctor%
  (class object%
    (init-field name)
    (super-new)
    (define/public (answer msg) 
      (append (list name ':) msg))
    (define/public (get-time) 
      (random 100))
    (define/public (how-much-time-left?) 
      (send this answer (list (send this get-time))))
    (define/public (clarify q) 
      (send this answer (send q get-hint 'redrum))) ))

(define eric (new proctor% [name 'eric]))
(check-equal? (send eric clarify q3) '(eric : a radiohead song))

(define professor%
  (class proctor%
    (super-new)
    (define/override (get-time) 
      30)
    (define/override (clarify q)
      (send this answer '(the question is perfect as written))) ))

(define colleen (new professor% [name 'colleen]))
(check-equal? (send colleen how-much-time-left?) '(colleen : 30))
(check-equal? (send colleen clarify q3) '(colleen : the question is perfect as written))

(define ta%
  (class proctor%
    (super-new)
    (init-field temper
                [current-temper 0])
    (define/override (how-much-time-left?)
      (set! current-temper (+ 1 current-temper))
      (if (<= current-temper temper) 
          (super how-much-time-left?) 
          '(how the hell would I know))) ))

(define kevin (new ta% [name 'kevin] [temper 3]))
(send kevin how-much-time-left?)
(send kevin how-much-time-left?)
(send kevin how-much-time-left?)
(check-equal? (send kevin how-much-time-left?) '(how the hell would I know))

(define lenient-proctor%
  (class proctor%
    (super-new)
    (init-field p1 p2)
    (define/override (get-time) 
      (let ([t1 (send p1 get-time)] [t2 (send p2 get-time)])
           (max t1 t2))) ))

(define phill (new lenient-proctor% [name 'phill] [p1 colleen] [p2 eric]))
(send phill how-much-time-left?)