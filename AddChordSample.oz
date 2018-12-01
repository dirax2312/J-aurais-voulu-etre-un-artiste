declare
fun{Add2Listes L1 L2}
   case L1#L2
   of nil#nil then nil
   [] (H1|T1)#(H2|T2) then (H1+H2)|{Add2Listes T1 T2}
   [] nil#(H2|T2) then H2|{Add2Listes nil T2}
   [] (H1|T1)#nil then H1|{Add2Listes T1 nil}
   end
end


declare
L1 = [1 2]
L2 = [1 2]
L3 = [1 2 4 5]
{Browse {Add2Listes L1 L2}}
{Browse {Add2Listes L2 L3}}
{Browse {Add2Listes L3 L2}}

%Additionne les samples qui se trouvent dans le chord. Si les listes de samples ne sont pas de meme longueurs, on suit le processus de Add2Listes car on complete la liste la plus courte par des silences dont l'intensité vaut 0.

declare
fun{AddChordSample Chord}
   case Chord
   of nil then nil
   [] H|nil then H
   [] H1|H2|T then {AddChordSample {Add2Listes H1 H2}|T}
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