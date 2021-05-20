male(bill).
male(bob).
male(mike).
male(rich).
male(sam).

female(mary).
female(kathy).
female(patty).
female(susan).

% parent(X, Y) - "X is a parent of Y"
parent(mary, bill).
parent(bob, bill).
parent(kathy, mary).
parent(mike, mary).
parent(patty, bob).
parent(rich, bob). 
parent(patty, jane).
parent(rich, jane).
parent(susan, rich). 
parent(sam, rich).

% Joel Sare
% Project 1

% child(X, Y) - "X is a child of Y"
child(X,Y) :- 
    parent(Y,X). 

% mother(X, Y) - "X is the mother of Y"
mother(X,Y) :-
    parent(X,Y), female(X). 

% father(X, Y) - "X is the father of Y"
father(X,Y) :-
    parent(X,Y), male(X). 

% son(X, Y) - "X is the son of Y"
son(X,Y) :-
    child(X,Y), male(X).

% daughter(X, Y) - "X is the daughter of Y"
daughter(X,Y) :-
    child(X,Y), female(X).

% ancestor(X, Y) - "X is the list of ancestors of Y"
ancestor(X, Y) :- 
    parent(X, Y).

ancestor(X, Y) :- 
    parent(Z, Y),
    ancestor(X, Z).

% sibling(X, Y) - "X and Y are siblings"
sibling(X, Y) :- 
    parent(Z, X), parent(Z, Y),
    different(X, Y). 
    
equal(X, X).

different(X, Y) :- 
    \+ equal(X, Y).

% "X is the list of all of the unique siblings of Y"
siblings(X,Y) :-
    setof(Y,sibling(X,Y), Z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% "X is a cousin of Y"
cousin(X,Y) :-
    parent(W,X), parent(Z,Y), siblings(W,Z).

% "X is an aunt of Y"
aunt(X,Y) :-
    female(X), parent(Z, Y), siblings(X, Z).

% "X is an uncle of Y"
uncle(X,Y) :-
    siblings(X, Z), male(X), parent(Z, Y).

% "X is the grandmother of Y"
grandmother(X,Y) :-
    female(X), parent(X, Z), parent(Z, Y).

% "X is the grandfather of Y"
grandfather(X,Y) :-
    male(X), parent(X, Z), parent(Z, Y).

% "X is a grandparent of Y"
grandparent(X,Y) :-
    parent(X, Z), parent(Z, Y).

% "X is the list of all of the unique cousins of Y"
cousins(X,Y) :-
    setof(Y,cousin(X,Y), Z).

% "X is the list of all of the unique aunts of Y"
aunts(X,Y) :-
    setof(Y,aunt(X,Y), Z).

% "X is the list of all of the unique uncles of Y"
uncles(X,Y) :-
    setof(Y,uncle(X,Y), Z).

% "X is the list of all of the unique grandmothers of Y"
grandmothers(X,Y) :-
    setof(Y,grandmother(X,Y), Z).

% "X is the list of all of the unique grandfathers of Y"
grandfathers(X,Y) :-
    setof(Y,grandfather(X,Y), Z).

% "X is the list of all of the unique grandparents of Y"
grandparents(X,Y) :-
    setof(X,grandparent(X,Y), X).