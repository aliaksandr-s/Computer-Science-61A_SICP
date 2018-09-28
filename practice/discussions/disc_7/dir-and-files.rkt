#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define directory%
  (class object%
    (init-field name
                [content '()])
    (super-new)
    (define/public (get-name) 
      name)
    (define/public (type) 
      'directory)
    (define/public (ls) 
      (map (lambda (el) (send el get-name)) content))
    (define/public (add file) 
      (set! content 
            (cons file content)))
    (define/public (mkdir folder-name)
      (set! content 
            (cons (new directory% [name folder-name]) 
                  content)))
    (define/public (cd folder-name)
      (findf (lambda (el) 
               (eq? (send el get-name) folder-name)) 
             content))
    (define/public (mv file-name folder-name)
      (let ([folder (cd folder-name)]
            [eq-file-name? (lambda (el) (eq? (send el get-name) file-name))])
           (send folder add (findf eq-file-name? content))
           (set! content 
                 (filter (lambda (el) (not (eq-file-name? el))) content))))
    (define/public (length)
      (foldr (lambda (el acc) (+ acc (send el length))) 0 content)) ))

(define file%
  (class object%
    (init-field name content)
    (super-new)
    (define/public (type) 'file)
    (define/public (get-name) name)
    (define/public (length)
      (let ([quotes-count 2]) 
        (- (string-length (~a content)) quotes-count))) ))

(define root (new directory% [name 'root]))
(define hw1 (new file% [name 'hw1.scm] 
                       [content '(I have no idea how to do this)]))
(define hw2 (new file% [name 'hw2.scm] 
                       [content '(please have mercy on me)]))
(define proj1-soln (new file% [name 'proj1.scm] 
                              [content '(my dad is going to kill me)]))

(check-equal? (send root ls) '())
(send root add hw1)
(send root add hw2)
(check-equal? (send root ls) '(hw2.scm hw1.scm))
(send root mkdir 'proj1)
(define proj1 (send root cd 'proj1))
(send proj1 add proj1-soln)
(send root mv 'hw1.scm 'proj1)
(check-equal? (send proj1 ls) '(hw1.scm proj1.scm))
(check-equal? (send root ls) '(proj1 hw2.scm))
(check-equal? (send hw1 length) 29)
(check-equal? (send root length) 78)