package main

import (
	"fmt"
	"math"
)

const val = 600851475143

func isPrime(x int) bool {
	if x == 2 {
		return true
	}
	if x%2 == 0 {
		return false
	}

	for i := 3; i <= int(math.Sqrt(float64(x))); i += 2 {
		if x%i == 0 {
			return false
		}
	}
	return true
}

func filter(p func(int) bool) chan int {
	ch := make(chan int)
	go func() {
		for i := 0; i < int(math.Sqrt(float64(val))); i++ {
			if p(i) {
				ch <- i
			}
		}
		close(ch)
	}()
	return ch
}

func largest(in chan int) int {
	lrg := 2
	for i := range in {
		if val%i == 0 {
			if i > lrg {
				lrg = i
			}
		}
	}
	return lrg
}

func largestPrime(x int) int {
	primeValues := filter(isPrime)
	return largest(primeValues)
}

func main() {
	fmt.Printf("%d\n", largestPrime(val))
}
