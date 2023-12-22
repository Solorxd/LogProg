:- ['two.pl'].

flenght([], 0).
flenght([_|L], Len):-
    flenght(L, LenPrev),
    Len is LenPrev + 1.

summlen([],0,0).
summlen([X|L],S,Len):-
    number(X),
    summlen(L,Sprev,Lenprev),
    S is Sprev + X,
    Len is Lenprev + 1.

avgmark(Subject, R):-
    findall(X, grade(_,_,Subject,X), Marks),
    summlen(Marks, S, N),
    R is S/N.

printavgsubj([]).
printavgsubj([Subject|L]):-
    avgmark(Subject, R),
    write(Subject),write(' средняя оценка : '),write(R),nl,
    printavgsubj(L).

printavgmarks:-
    findall(Subject, grade(_,_,Subject,_), SL),
    sort(SL, SubjectSet),
    printavgsubj(SubjectSet).

printeachgroup([]).
printeachgroup([Group|L]):-
    findall(Student, grade(Group,Student,_,2), Failedlist),
    sort(Failedlist, Failedset),
    flenght(Failedset,N),
    write(Group),write(' N = '),write(N),write(' не сдавших'),nl,
    printeachgroup(L).

printfailsgroups:-
    findall(Group, grade(Group,_,_,_), Groupslist),
    sort(Groupslist, Groupsset),
    printeachgroup(Groupsset).

printeachsubj([]).
printeachsubj([Subject|L]):-
    findall(Student, grade(_,Student,Subject,2), Failedlist),
    sort(Failedlist, Failedset),
    flenght(Failedset,N),
    write(Subject),write(' N = '),write(N),write(' не сдавших'),nl,
    printeachsubj(L).

printfailssubjs:-
    findall(Subject, grade(_,_,Subject,_), Subjslist),
    sort(Subjslist, Subjsset),
    printeachsubj(Subjsset).

printanswer:-
    write('1.Не сдавшие по предметам'),nl,
    printfailssubjs,
    nl,write('2.Не сдавшие по группам'),nl,
	printfailsgroups,
    nl,write('3.Средние оценки по предметам'),nl,
	printavgmarks.
