% time

#const horizon = 3.

time(0..horizon).

% blocks

block(a).
block(b).
block(c).
block(d).
block(e).

% location

location(table).

location(B) :- block(B).

% on(B,L) - read as "block B is on location L"

inertial_fluent(on(B,L)) :-
    block(B), location(L), B != L.

fluent(F) :- inertial_fluent(F).

fluent(occupied(B)) :- block(B).

% move(B,L) - read as "move block B onto location L"

action(move(B,L)) :-
    block(B), location(L), B != L.

% moving a block B to location L causes B to be on L

holds(on(B,L), T) :-
    occurs(move(B,L), T - 1),
    fluent(on(B,L)),
    action(move(B,L)),
    time(T), time(T - 1).

-holds(on(B,L2), T) :-
    holds(on(B,L1), T),
    fluent(on(B,L1)),
    fluent(on(B,L2)),
    L1 != L2,
    time(T).

% it is impossible to move an occupied block

holds(occupied(B), T) :-
    holds(on(A,B), T),
    block(A), block(B),
    time(T).

-holds(occupied(B), T) :-
    not holds(occupied(B), T),
    fluent(occupied(B)),
    time(T).

:- occurs(move(B,L), T), holds(occupied(B), T),
   action(move(B,L)), fluent(occupied(B)), time(T).

% holds(F,T) - read as "fluent F holds at time T"

holds(on(a,table), 0).
holds(on(b,table), 0).
holds(on(c,a), 0).
holds(on(d,b), 0).
holds(on(e,d), 0).

% goal specification

goal(T) :-
    holds(on(e,table), T),
    holds(on(a,e), T),
    holds(on(c,table), T),
    holds(on(d,c), T),
    holds(on(b,d), T),
    time(T).

goal_met :-
     goal(T),
     time(T).

:- not goal_met.

% planning module
% changing it to 1{}2, it will go crazy

1{occurs(A,T) : action(A)}1 :- time(T), not goal(T).

% inertia axioms

holds(F, T) :-
    holds(F, T - 1),
    not -holds(F, T),
    inertial_fluent(F),
    time(T), time(T - 1).

-holds(F, T) :-
    -holds(F, T - 1),
    not holds(F, T),
    inertial_fluent(F),
    time(T), time(T - 1).

% domain history

occurs(move(c,table), 0).

#show occurs/2.
