cross_river([[Ludl1,Misl1],[Ludr1,Misr1],Boat1],[[Ludl2,Misl2],[Ludr2,Misr2],Boat2]):- 
    (Boat1 is 1;Boat1 is -1),
    between(0,3,Misb),Ludmax is 3-Misb,between(0,Ludmax,Ludb),(Ludb + Misb > 0),
    (Boat2 is -Boat1),Ludl2 is Ludl1 - Boat1*Ludb,Ludr2 is Ludr1 + Boat1*Ludb,Misl2 is Misl1 - Boat1*Misb, Misr2 is Misr1 + Boat1*Misb,
    bagof(_, (Misr2 is 0;Misr2 >= Ludr2), _),between(0,3,Ludr2),between(0,3,Misr2),bagof(_, (Misl2 is 0;Misl2 >= Ludl2), _),between(0,3,Ludl2),between(0,3,Misl2).

pathwide(X,Y,P):-widesearch([[X]],Y,P).

pathdfs(X,Y,P):-dfs([X],Y,P).

/*search_id(Start,Finish,Path,DepthLimit) :-
    depth_id([Start],Finish,Path,DepthLimit).
*/

search_id(Start,Finish,Path,LevelMax):-
    between(1,LevelMax,Level),
    depth_id([Start],Finish,Path,Level).

prolong([X|T],[Y,X|T]):-
    cross_river(X,Y),
    not(member(Y,[X|T])).

flenght([], 0).
flenght([_|L], Len):-
    flenght(L, LenPrev),
    Len is LenPrev + 1.

dfs([X|T],X,[X|T]).
dfs(P,Y,R):-
    prolong(P,P1),
    dfs(P1,Y,R).


widesearch([[X|T]|_],X,[X|T]).
widesearch([P|QI],X,R) :-
    findall(Z,prolong(P,Z),T),
    append(QI,T,QO),!,
    widesearch(QO,X,R).
widesearch([_,T],Y,L) :- widesearch(T,Y,L).

depth_id([Finish|T],Finish,[Finish|T],0).
depth_id(Path,Finish,R,N):-N>0,
    prolong(Path,NewPath),N1 is N - 1,
    depth_id(NewPath, Finish, R, N1).

printsystemstate([[Ll,Ml],[Lr,Mr],B], N):-
    write(N),write(':'),
    write('__'),
    (between(1,Ll,_),write('Л'),fail);(Ll > 0,Ml > 0,write(','),fail);(between(1,Ml,_),write('М'),fail);
    write('__'),
    ((B is 1,write('~~|_._._/ ~~~~~~~~~~~~'));(B is -1,write('~~~~~~~~~~~~ \\_._._|~~'))),
    write('__'),
	(between(1,Lr,_),write('Л'),fail);(Lr > 0,Mr > 0,write(','),fail);(between(1,Mr,_),write('М'),fail);
    write('__'),nl,nl.
                                                                                
printhumanreadable([],0).
printhumanreadable([X|L],N):-
    printhumanreadable(L,Nprev),
    N is Nprev + 1,
    printsystemstate(X,N).
    

printanswer:-
    search_id([[3,3],[0,0],1],[[0,0],[3,3],-1],R,11),!,
    printhumanreadable(R,N),
    write('длина пути :'),
    write(N),nl.
