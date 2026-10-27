% family.pl -- a starter knowledge base to check the toolchain works.
% Load in the REPL with:  ?- [family].   or   ?- consult('family.pl').

% --- Facts -------------------------------------------------------------
parent(hassan, mohammad).
parent(hassan, leila).
parent(maryam, mohammad).
parent(maryam, leila).
parent(mohammad, sara).

male(hassan).
male(mohammad).
female(maryam).
female(leila).
female(sara).

% --- Rules -------------------------------------------------------------
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).

sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.

grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

% Recursion: ancestor is the transitive closure of parent.
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).
