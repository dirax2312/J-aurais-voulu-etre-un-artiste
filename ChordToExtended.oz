% Transforme un accord (liste de notes) en un accord etendu (une liste de note
% étendues)
% Necessite : NoteToExtended

declare
fun{ChordToExtended Chord}
   case Chord
   of nil then nil
   [] H|T then {NoteToExtended H}|{ChordToExtended T}
   end
end

%Test 
declare 
Note1 = a
Note2 = b2
Note3 = c4
Note4 = silence 
Note5 = d#5
Chord = [Note1 Note2 Note3 Note4 Note5]

{Browse {ChordToExtended Chord}}
