#const n = 1.
#const required_rooms = n.
#const rows = 4.
#const cols = 4.
 
room(2..18). %rooms
 
room_flag(18,initial).
room_flag(2,boss).
room_flag(3,treasure).
room_flag(4,treasure).
 
flag_bounds(initial,1,1).
flag_bounds(boss,1,1).
flag_bounds(treasure,0,1).
 
room_door(18,north).
room_door(6,north).
room_door(7,north).
room_door(10,north).
room_door(11,north).
room_door(12,north).
room_door(14,north).
room_door(16,north).
room_door(17,north).
 
room_door(2,south).
room_door(6,south).
room_door(7,south).
room_door(8,south).
room_door(9,south).
room_door(12,south).
room_door(15,south).
room_door(16,south).
room_door(17,south).
 
room_door(3,west).
room_door(5,west).
room_door(7,west).
room_door(9,west).
room_door(10,west).
room_door(13,west).
room_door(14,west).
room_door(15,west).
room_door(16,west).
 
room_door(4,east).
room_door(5,east).
room_door(7,east).
room_door(8,east).
room_door(11,east).
room_door(13,east).
room_door(14,east).
room_door(15,east).
room_door(17,east).
 
 
delta(north,-1, 0).     delta(west,  0,-1).
delta(south, 1, 0).     delta(east,  0, 1).
opposite(north,south).  opposite(west,east).
opposite(south,north).  opposite(east,west).
 
 
{assign(X,Y,nil); assign(X,Y,R) : room(R)} = 1 :- X = 1..rows, Y = 1..cols.
 
assign(0,     Y,     nil) :- Y = 0..cols+1.
assign(rows+1,Y,     nil) :- Y = 0..cols+1.
assign(X,     0,     nil) :- X = 0..rows+1.
assign(X,     cols+1,nil) :- X = 0..rows+1.
 
:- #count{X,Y : assign(X,Y,R), R != nil} != required_rooms.
 
:- assign(X,Y,R), room_door(R,L), delta(L,DX,DY), assign(X+DX,Y+DY,R'), opposite(L,L'), not room_door(R',L').
 
:- flag_bounds(F,MIN,MAX), not MIN <= #count{X,Y : assign(X,Y,R), room_flag(R,F)} <= MAX.
 
reachable(X,Y) :- room_flag(R,initial), assign(X,Y,R).
reachable(X+DX,Y+DY) :- reachable(X,Y), assign(X,Y,R), room_door(R,L), delta(L,DX,DY).
:- assign(X,Y,R), R != nil, not reachable(X,Y).
 
spawn_hp_potion(R) :- room_flag(R,initial), hp <= 2.
 
 
 
 
#show.
#show assign(X,Y,R) : assign(X,Y,R), R != 0.
%#show roomInDungeon(R) :  roomInDungeon(R).