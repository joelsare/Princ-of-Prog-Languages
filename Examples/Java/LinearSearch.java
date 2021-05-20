public class LinearSearch {

    public static boolean containsV0(int x, int[]xs) {
        for (int obj:xs) { //we don't know EXACTLY when this loop will terminate
            if (obj == x) {
                return true;
            }
        }
        return false;
    }

    //variable i keeps track of position in array
    //relate index positions to time ... "what element am I looking at"
    //we can reason about the behavior of the algorithm
    public static boolean containsV1(int x, int[]xs) {
        for (int i = 0; i < xs.length; i++) {
            if (xs[i] == x) {
                return true;
            }
        }
        return false;
    }


    //PROGRAM THAT REPRESENTS ALGORITHM MOST "CORRECTLY"

    //loop tells us when it's going to terminate (given as boolean proposition)
    //when we found what we're looking for or we're out of bounds
    public static boolean containsV2(int x, int[]xs) {
        // found = true iff x belongs to xs[0,i]
        boolean found = false;
        // variable i "monotonically increases"
        int i = 0;

        while (!found && (i < xs.length)) {
            if (xs[i] == x) {
                found = true;
            }
            else {
                i++;
            }
        }

        // BOOLEAN PROPOSITION:
        // at the end of iteration #1, does found satisfy this property?
        // found = true iff x belongs to xs[0,i]


        //ALGORITHM
        // (0) {found <- false and i <- 0}     (initialization)
        // (1) found = true iff x belongs to xs[0, xs.length]
        //
        // (2) termination: (found = true or i = xs.length)
        //
        //algorithm: (0) and (1) and eventually (2)
        return found;
    }
}

/*
indices help us define slices within the array. let i be an index position,
xs[0,i] denotes the slice of the array from position 0 up to but not including i.

xs = [a, b, c, d, e, f, g, h]
is = [0, 1, 2, 3, 4, 5, 6, 7]

*/

(define (contains xs x )
    (cond
        [(null? xs) #f]
        [(= (car xs) x) #t]
        [else (contains (cdr xs) x)]))x
