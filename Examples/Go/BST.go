package main

import (
	"fmt"
	"math/rand"
)

//node not exported ("private") because it's lowercase
type node struct {
	datum int
	left  *node
	right *node
}

//BinarySearchTree exported ("public") because it's capitalized
//but bst is not exported
type bst struct {
	root *node
}

func (tree *bst) insert(x int) {
	tree.root = insert(tree.root, x)
}

func insert(root *node, x int) *node {
	if root == nil {
		root = &node{x, nil, nil}
	} else if x < root.datum {
		root.left = insert(root.left, x)
	} else {
		root.right = insert(root.right, x)
	}
	return root
}

func (tree *bst) traverse(ch chan int) {
	traverse(tree.root, ch)
}

func traverse(root *node, ch chan int) {
	if root != nil {
		traverse(root.left, ch)
		ch <- root.datum
		traverse(root.right, ch)
	}
}

//transport contents of tree into channel
func toChannel(t *bst) <-chan int {
	ch := make(chan int)
	go func() {
		t.traverse(ch)
		close(ch)
	}()
	return ch
}

func equivalent(t1, t2 *bst) bool {
	c1, c2 := toChannel(t1), toChannel(t2)
	for {
		x, ok1 := <-c1
		y, ok2 := <-c2
		if !ok1 || !ok2 {
			return ok1 == ok2
		}
		if x != y {
			return false
		}
	}
}

func randomTree(n, k int) *bst {
	tree := &bst{nil}
	for _, v := range rand.Perm(n) {
		tree.insert((1 + v) * k)
	}
	return tree
}

func main() {
	t1 := randomTree(100, 1)
	fmt.Println(equivalent(t1, randomTree(100, 1)), "Same Contents")
	fmt.Println(equivalent(t1, randomTree(99, 1)), "Differing Sizes")
	fmt.Println(equivalent(t1, randomTree(100, 2)), "Differing Values")
	fmt.Println(equivalent(t1, randomTree(101, 2)), "Dissimilar")
}
