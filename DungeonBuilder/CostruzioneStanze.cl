#const required_rooms = 8.
#const rows = 4.
#const cols = 4.

room(0..17). %rooms
treasureRoom(3..4).

door(1,north).
door(6,north).
door(7,north).
door(10,north).
door(11,north).
door(12,north).
door(14,north).
door(16,north).
door(17,north).

door(2,south).
door(6,south).
door(7,south).
door(8,south).
door(9,south).
door(12,south).
door(15,south).
door(16,south).
door(17,south).

door(3,west).
door(5,west).
door(7,west).
door(9,west).
door(10,west).
door(13,west).
door(14,west).
door(15,west).
door(16,west).

door(4,east).
door(5,east).
door(7,east).
door(8,east).
door(11,east).
door(13,east).
door(14,east).
door(15,east).
door(17,east).


opposite(north,south).
opposite(east,west).
opposite(X,Y) :- opposite(Y,X).

shift(north,-1,0).
shift(south,1,0).
shift(east,0,1).
shift(west,0,-1).


grid(1..rows,1..cols).

% fake walls all around
position(0,0..cols+1,0).
position(rows+1,0..cols+1,0).
position(0..rows+1,0,0).
position(0..rows+1,cols+1,0).

{position(X,Y,R) : room(R)} = 1 :- grid(X,Y).

%Treasure Rooms
treasureRoomInDungeon(R) :- position(X,Y,R), treasureRoom(R).
:- #count{R : treasureRoomInDungeon(R)} > 1.

%Stanza iniziale
:- #count{X,Y : position(X,Y,1)} != 1.
%Stanza boss
:- #count{X,Y : position(X,Y,2)} != 1.

:- position(X,Y,R), door(R,D), shift(D,X1,Y1), position(X+X1,Y+Y1,R1), opposite(D,D1), not door(R1,D1).

reach(X,Y) :- position(X,Y,1).
reach(X+X1,Y+Y1) :- reach(X,Y), position(X,Y,R), door(R,D), shift(D,X1,Y1).
:- position(X,Y,R), R != 0, not reach(X,Y).

:- #count{X,Y : position(X,Y,R), R != 0} != required_rooms.

:- room(R), #count{X,Y : position(X,Y,R), R != 0} > 1.

%roomInDungeon(R) :- position(X,Y,R), R != 0.

#show.
#show position(X,Y,R) : position(X,Y,R), R != 0.
%#show roomInDungeon(R) :  roomInDungeon(R).