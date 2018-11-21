#lang racket

(require rackunit)
(require racket/stream)
(require mischief/stream)
(require racket/trace)

(define (inverted-index folder)
  (define files-list 
          (map (lambda (file-name) (cons (string-append folder "/" file-name) file-name))
               (map path->string 
                    (directory-list folder))))

  (define words-list
          (foldl append 
                 '()
                  (map (lambda (file)
                      (map (lambda (word) (cons word (cdr file))) 
                            (file->list (car file)))) 
                        files-list)))

  (define (in-stream? value stream)
    (cond [(stream-empty? stream) #f]
          [(equal? value (car (stream-first stream))) #t]
          [else (in-stream? value (stream-rest stream))]))

  (define (build-list val list)
    (map cdr (filter (lambda (el) (equal? val (car el))) list)))

  (define (update-stream value stream words)
    (cond [(in-stream? (car value) stream) stream]
          [else (stream-cons (cons (car value) 
                                   (cons (cdr value) 
                                         (build-list (car value) words))) stream)]))

  (define (process-words w-list result)
    (cond [(empty? w-list) result]
          [else (process-words (cdr w-list) (update-stream (car w-list) result (cdr w-list)))]))

  (process-words words-list (stream)))

(define test-result (list 
                     (cons 'seashore '("Doc3.txt"))
                     (cons 'gigantic '("Doc3.txt" "Doc2.txt"))
                     (cons 'end '("Doc4.txt" "Doc3.txt" "Doc2.txt"))
                     (cons 'army '("Doc4.txt" "Doc2.txt" "Doc1.txt"))
                     (cons 'smile '("Doc4.txt" "Doc1.txt"))
                    ))
                     
(check-equal? (stream-take (inverted-index "folder") 5) test-result)