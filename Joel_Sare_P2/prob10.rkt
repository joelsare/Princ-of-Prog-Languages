#lang racket

(define N 2000000)

(define (sum xs)
  (define (sum-acc xs acc)
    (cond
      [(null? xs) acc]
      [else (sum-acc (cdr xs) (+ (car xs) acc))]))
  (sum-acc xs -1))

(define (is-prime? a)
  (define (is-prime-acc a acc)
    (cond
      [(< a (* acc acc)) #t]
      [(= (modulo a acc) 0) #f]
      [else (is-prime-acc a (+ 1 acc))]))
  (is-prime-acc a 2))

(sum (filter is-prime? (range 1 N)))

