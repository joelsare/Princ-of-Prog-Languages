#lang racket
(require racket/trace)
(define (iota N)
  (define (iota-helper from to)
    (cond
      [(< from to) (cons from (iota-helper (+ from 1) to))]
      [else '()]))
  (iota-helper 0 N))

(define (f N)
  (sumdigits (factorial N)))

(define (factorial N)
  (cond
    [(= N 0) 1]
    [else (* N (factorial (- N 1)))]))

(define (sumdigits x)
  (define (sumdigits-acc x acc)
  (cond
    [(= x 0) acc]
    [else (sumdigits-acc (/ (- x (modulo x 10)) 10) (+ acc (modulo x 10)))]))
  (sumdigits-acc x 0))