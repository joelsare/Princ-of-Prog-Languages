package main

import (
	"fmt"
)

func sum(ch chan int) int {
	sum := 0
	for i := range ch {
		sum += i
	}
	return sum
}

func factorial(n int) int {
	if n == 0 {
		return 1
	}
	return n * factorial(n-1)
}

func separate(fac int, ch chan int) {
	if fac == 0 {
		close(ch)
		return
	}
	ch <- fac % 10
	separate(fac/10, ch)
}

func main() {
	N := 10
	num := factorial(N)
	ch := make(chan int)
	go separate(num, ch)
	summation := sum(ch)
	fmt.Println(summation)
}
