% derivative(F, DF) - "DF is the derivative of the univariate polynomial F"


derivative(F, DF) :-
    general_derivative(F, GDF),
    simplified_form(GDF, DF).

% general_derivative(F, GDF) - "GDF is the general derivative (not simplified) 
% of the univariate F"

general_derivative(N, 0) :-
    number(N).

general_derivative(x, 1).

general_derivative(-x, 1).

general_derivative(F^0, 0).

general_derivative(F^N, N*F^M*DF) :-
    N >= 1,
    M is N - 1,
    general_derivative(F, DF).

general_derivative(E1*E2, E1*DE2 + E2*DE1) :-
    general_derivative(E1, DE1),
    general_derivative(E2, DE2).

general_derivative(E1+E2, DE1 + DE2) :-
    general_derivative(E1, DE1),
    general_derivative(E2, DE2).

general_derivative(E1-E2, DE1 + DE2) :-
    general_derivative(E1, DE1),
    general_derivative(E2, DE2).

general_derivative(-(E), DE) :-
    general_derivative((-1)*E, DE).

% simplified_form(GDF, DF) - "DF is the simplified form of the 
% general derivative GDF"

simplified_form(GDF, DF) :-
    transform_to_list(GDF, LF),
    combine_similar_terms(LF, LF1),
    remove_zero_terms(LF1, LF2),
    polynomial_sort(LF2, LF3),
    transform_to_term(LF3, DF).

transform_to_list(C, [[C,0]]) :-
    integer(C).

transform_to_list(x, [[1,1]]).

transform_to_list(-x, [[-1,1]]).

transform_to_list(A*B, L) :-
    transform_to_list(A, LA),
    transform_to_list(B, LA),
    multiply_through(LA, LB, L).

transform_to_list(A^N, L) :-
    transform_to_list(A, LA),
    multiply_through(LA, N, L).

transform_to_list(A+B, L) :-
    transform_to_list(A, LA),
    transform_to_list(B, LA),
    append(LA, LB, L).

transform_to_list(A-B, L) :-
    transform_to_list(A, LA),
    transform_to_list(-B, LA),
    append(LA, LB, L).

transform_to_list(-(A), L) :-
    transform_to_list((-1)*A, L).


multiply_through([], _, []).

multiply_through([H1|T1], L2, L) :-
    multiply_one_through(H1, L2, Temp1),
    multiply_through(T1, Temp1, Temp2),
    append(Temp1, Temp2, L).

multiply_one_through(_, [], []).

multiply_one_through([C1, N1], [[C2,N2]|T1], [[C,N]|T]) :-
    C is C1 * C2,
    N is N1 + N2,
    multiply_one_through([C1,N1], T1, T).