node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,e).
edge(a,b).
edge(b,c).
edge(c,d).
edge(e,c).
edge(e,d).



path(X,Y):-
    path(X,Y,[]).

path(X, Y, L):- 
    (edge(X, Z)),
    not(member(Z, L)), (Z = Y; path(Z, Y, [X|L])).

cyclic():-
    path(A,B), path(B,A).