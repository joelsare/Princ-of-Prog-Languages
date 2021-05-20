#lang racket
;; a=x^2-y^2
;; b=2xy
;; c=x^2+y^2

(define N 1000)

(define (triplet x y a b c)
  (cond
    [(= (+ a b c) N) (* a b c)]
    [(= y N) (triplet (+ 1 x) (+ 1 x) (- (* y y) (* x x)) (* 2 x y) (+ (* x x) (* y y)))]
    [else (triplet x (+ 1 y) (- (* y y) (* x x)) (* 2 x y) (+ (* x x) (* y y)))]))

(triplet 1 1 1 1 1)