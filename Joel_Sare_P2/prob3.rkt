#lang racket
(define N 600851475143)

(define (largest-prime n)
  (define (largest-prime-acc n acc)
    (cond
      [(>= n acc) acc]
      [(= (modulo acc n) 0) (largest-prime-acc n (/ acc n))]
      [else (largest-prime-acc (+ n 1) acc)]))
  (largest-prime-acc 2 n))

(largest-prime N)
    
