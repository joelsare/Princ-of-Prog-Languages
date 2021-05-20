% basic_part/1
% basic_part(X) - read as "X is a basic part"

basic_part(rim).
basic_part(nut).
basic_part(spoke).
basic_part(frame).
basic_part(brakes).
basic_part(tire).

% component/2
% component(X,Y) - read as "Y is the list of components need to assemble X"

component(bike, [[wheel,2], [frame,1], [steering,1]]).
component(wheel, [[spoke,4], [tire,1], [nut,5]]).
component(steering, [[brakes,2], [nut,10]]).

% parts_required/3
% parts_required(N,X,XS) - read as "XS is the list of parts required to assemble
% N objects of type X"

parts_required(N, P, [[P,N]]) :-
    basic_part(P).

