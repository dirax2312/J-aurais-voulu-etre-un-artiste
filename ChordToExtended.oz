% Transforme un accord (liste de notes) en un accord etendu (une liste de note
% �tendues)

declare
fun{ChordToExtended Chord}
   case Chord
   of nil then nil
   [] H|T then {NoteToExtended H}|{ChordToExtend T}
   end
end