#lang racket
(define (factorial-v0 N)
  (cond
    [(= N 0) 1]
    [else (* N (factorial-v0 (- N 1)))]))


(define (factorial-v1 N)
  (define (factorial-acc N acc)
    (cond
        [(= N 0) acc]
        [else (factorial-acc (- N 1) (* N acc))]))
    (factorial-acc N 1))



    