package main

import (
	"fmt"
	"math"
)

const m = 2000000

func summation(in chan int) int {
	sum := 0
	for i := range in {
		sum += i
	}
	return sum
}

func filter(p func(int) bool, in chan int) chan int {
	ch := make(chan int)
	go func() {
		for i := range in {
			if p(i) {
				ch <- i
			}
		}
		close(ch)
	}()
	return ch
}

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

func getNums(bound int) chan int {
	ch := make(chan int)
	go func() {
		for i := 2; i < bound; i++ {
			ch <- i
		}
		close(ch)
	}()
	return ch
}

func sumOfPrimes(x int) int {
	nums := getNums(m)
	primes := filter(isPrime, nums)
	return summation(primes)
}

func main() {
	fmt.Println(sumOfPrimes(m))
}
