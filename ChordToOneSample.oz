
%Additionne les samples qui se trouvent dans le chord. Si les listes de samples ne sont pas de meme longueurs, on suit le 
%processus de Add2Listes car on complete la liste la plus courte par des silences dont l'intensité vaut 0.
%Necessite :  Add2Listes 

declare
fun{ChordToOneSample Chord}
   case Chord
   of nil then nil
   [] H|nil then H
   [] H1|H2|T then {ChordToOneSample {Add2Listes H1 H2}|T}
   end
end

%Test
declare 
C1 = [[1 2] nil [1 2]]
C2 = nil
C3 = [[1 2] [1 2] [1 2]]
C4 = [[1 2] [1 2 4] [1 2]]
{Browse {AddChordSample C1}}
{Browse {AddChordSample C2}}
{Browse {AddChordSample C3}}
{Browse {AddChordSample C4}}
