slice(L,M,N,[]) :-                  %empty interval: S = []
    M==N;
    M>N.

slice(L,M,N,S) :-                   %non-empty interval: start recursion
    slicehelper(L,M,N,S).

slicehelper(_,0,0,[]).              %base case

slicehelper([H|T],M,N,S):-          %recursive call
    M>0, 
    M<N, 
    slicehelper(T,M-1,N-1,S).

slicehelper([H|T],M,N,[H|Tt]):-     %recursive call
    M<N,
    N1 is N-1, 
    slicehelper(T,0,N1,Tt).


