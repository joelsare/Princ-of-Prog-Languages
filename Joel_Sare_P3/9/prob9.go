package main

import (
	"fmt"
)

const val = 1000

func isTriplet(a int, b int, c int) bool {
	return (a*a + b*b) == c*c
}

func filter(p func(int, int, int) bool) int {
	num := -1
	for i := 1; i < val; i++ {
		for j := 1; j < val; j++ {
			for k := 1; k < val; k++ {
				if (i + j + k) == 1000 {
					if p(i, j, k) {
						return i * j * k
					}
				}
			}
		}
	}
	return num
}

func main() {
	fmt.Println(filter(isTriplet))
}
