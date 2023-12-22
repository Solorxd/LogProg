flenght([], 0).
flenght([_|L], Len):-
    flenght(L, LenPrev),
    Len is LenPrev + 1.

is_member(X,[Y]):-!,X\=Y,fail.
is_member(X, [X|_]).
is_member(X, [_|L]):-
    is_member(X, L).


fappend([],L2,L2).
fappend([X|L1], L2, [X|L_res]):-
    append(L1, L2, L_res).

fadd_one(L1, X, L_res):- append(L1, [X], L_res).


fremove(_,[],[]).
fremove(X,[X|L],L):-!.
fremove(X,[Y|L],[Y|L_res]):-
    fremove(X,L,L_res).

fselect(X, [X|L], L).
fselect(X, [Y|L], [Y|Lres]):-
    fselect(X, L, Lres).


fpermute([], []).
fpermute([X|Rest], L) :-
    fpermute(Rest, L1),
    fselect(X, L, L1).

compareliststart([],_):- !.
compareliststart([X|L],[X|L2]):-
    compareliststart(L,L2).

fsublist(Lsub,L):-compareliststart(Lsub,L),!.
fsublist(Lsub,[_|L]):-
    fsublist(Lsub,L).

count(_,[],0):- !.
count(X,[X|L],N):-
    count(X,L,Nprev),
    N is Nprev + 1,!.
count(X,[_|L],N):-
    count(X,L,Nprev),
    N is Nprev.

countstd(X,L,N):-
    findall(X,append(_,[X|_],L),Xs),
    flenght(Xs,N).

findmax([X],X).
findmax([X|L], Max):-
    findmax(L,Maxprev),
    X > Maxprev,
    Max is X.
findmax([X|L], Max):-
    findmax(L,Maxprev),
    X =< Maxprev,
    Max is Maxprev.

maxlist([],0).

maxlist([Head|Tail],Max) :-
    maxlist(Tail,TailMax),
    Head > TailMax,
    Max is Head.

maxlist([Head|Tail],Max) :-
    maxlist(Tail,TailMax),
    Head =< TailMax,
    Max is TailMax.

findmaxstd(L,X):-
    sort(L,Ys),
    write(Ys),
    last(Ys,X).
