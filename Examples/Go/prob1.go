/*
 * sum of multiples of 3 or 5 below 1000
 */

package main

import "fmt"

const max = 1000

func desiredTerm(x int) bool {
	return x%5 == 0 || x%3 == 0
}

func summationV1(bound int) int {
	sum := 0
	for i := 0; i < bound; i++ {
		if desiredTerm(i) {
			sum += i
		}
	}
	return sum
}

func summationV2(bound int, p func(int) bool) int {
	sum := 0
	for i := 0; i < bound; i++ {
		if p(i) {
			sum += i
		}
	}
	return sum
}

func boundedNaturals(bound int) chan int {
	ch := make(chan int)
	go func() {
		for i := 0; i < bound; i++ {
			ch <- i
		}
		close(ch)
	}()
	return ch
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

func summation(in chan int) int {
	sum := 0
	for i := range in {
		sum += i
	}
	return sum
}

func solutionV3(bound int) int {
	naturals := boundedNaturals(bound)
	terms := filter(desiredTerm, naturals)
	return summation(terms)
}

func main() {
	fmt.Printf("solution 1: %d\n", summationV1(max))
	fmt.Printf("solution 2: %d\n", summationV2(max, desiredTerm))
	fmt.Printf("solution 3: %d\n", solutionV3(max))
}
