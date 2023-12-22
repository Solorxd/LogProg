male('муж').
male('отец жены').
male('сын').

female('жена').
female('сестра мужа').

parent('жена','сын').
parent('муж','сын').
parent('отец жены','жена').

sister('сестра мужа', 'муж').

father(X,Y):-
    male(X),
    parent(X,Y).

mother(X,Y):-
    female(X),
    parent(X,Y).

grandfather(X,Z):-
    parent(Y,Z),
    father(X,Y).

bloodrelated(X,Y):-X\=Y,
    parent(X,Y);
    parent(Y,X);
    grandfather(X,Y);
    grandfather(Y,X);
    sister(X,Y);
    sister(Y,X).

engeneer(X):-
    (female(X)),
    sister(X,_).

teacherandlawyer(X, Y):-
    (male(X);female(X)),
    (male(Y);female(Y)),
    X \= Y,
    not(engeneer(X)),
    not(engeneer(Y)),
    not(bloodrelated(X,Y)),
    male(X),female(Y).

economistandlocksmith(X,Y):-
    (male(X);female(X)),
    (male(Y);female(Y)),
    X \= Y,
    not(engeneer(X)),
    not(engeneer(Y)),
    not(teacherandlawyer(X,_)),
    not(teacherandlawyer(_,X)),
    not(teacherandlawyer(Y,_)),
    not(teacherandlawyer(_,Y)),
    (parent(X,Y);grandfather(X,Y)).

printanswer:-
    engeneer(Eng),
    write('Инженер : '),write(Eng),nl,
    teacherandlawyer(Teach,Law),
    write('Учитель : '),write(Teach),nl,
    write('Юрист : '),write(Law),nl,
    economistandlocksmith(Econ,Lock),
    write('Экономист : '),write(Econ),nl,
    write('Слесарь : '),write(Lock),nl,!.
