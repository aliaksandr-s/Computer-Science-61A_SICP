#lang sicp

(define (lookup ls table)
  (let ((one-dim? (null? (cdr ls)))) 
    (if one-dim? 
        (let ((record (assoc (car ls) (cdr table))))
              (if record
                  (cdr record)
                  false))
        (let ((subtable (assoc (car ls) (cdr table))))
          (if subtable
            (let ((record (assoc (cadr ls) (cdr subtable))))
              (if record
                (cdr record)
                false))
            false)) )))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! ls value table)
  (let ((key-1 (car ls)) 
        (one-dim? (null? (cdr ls)))) 
        
  (if one-dim?
      (let ((record (assoc key-1 (cdr table))))
        (if record
            (set-cdr! record value)
            (set-cdr! table
                      (cons (cons key-1 value) (cdr table)))))
      (let ((subtable (assoc key-1 (cdr table)))         
            (key-2 (cadr ls)))
        (if subtable
          (let ((record (assoc key-2 (cdr subtable))))
        (if record
          (set-cdr! record value)
          (set-cdr! subtable
            (cons (cons key-2 value)
                  (cdr subtable)))))
          (set-cdr! table
            (cons (list key-1
                        (cons key-2 value))
                  (cdr table)))))  )
'ok))

(define (make-table)
  (list '*table*))

(define t1 (make-table))
(insert! '(a) 0 t1)
(lookup '(a) t1)
(insert! '(b c) 1 t1)
(insert! '(b d) 2 t1)
(insert! '(b d) 22 t1)
(lookup '(b c) t1)
(lookup '(b d) t1)