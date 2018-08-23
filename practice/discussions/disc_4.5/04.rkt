#lang racket/base

(require rackunit)
(require racket/trace)

(define (pokemon type level experience)
  (list type level experience))

(define type car)
(define level cadr)
(define experience caddr)

(define pikachu (pokemon 'electro 10 1000))
(check-equal? (type pikachu) 'electro)
(check-equal? (level pikachu) 10)
(check-equal? (experience pikachu) 1000)

(define (pokemon-battle poke1 poke2)
  (cond [(>= (- (level poke1) (level poke2)) 5) poke1]
        [(>= (- (level poke2) (level poke1)) 5) poke2]
        [(super-effective (type poke1) (type poke2)) poke1]
        [(super-effective (type poke2) (type poke1)) poke2]
        [(> (experience poke1) (experience poke2)) poke1]
        [(> (experience poke2) (experience poke1)) poke2]))

(define (super-effective type1 type2)
  (if (equal? type1 'water) #t #f))

(check-equal? (pokemon-battle (pokemon 'electro 5 1000) 
                              (pokemon 'electro 10 5000))
              (pokemon 'electro 10 5000))

(check-equal? (pokemon-battle (pokemon 'electro 5 1000) 
                              (pokemon 'water 5 1000))
              (pokemon 'water 5 1000))

(check-equal? (pokemon-battle (pokemon 'electro 5 1000) 
                              (pokemon 'electro 5 2000))
              (pokemon 'electro 5 2000))

            
(define (pokemon-2 type level experience)
  (list (cons level experience) type))

(define type-2 cadr)
(define level-2 caar)
(define experience-2 cdar)

(define pika (pokemon-2 'electro 10 1000))
(check-equal? (type-2 pika) 'electro)
(check-equal? (level-2 pika) 10)
(check-equal? (experience-2 pika) 1000)