%Transforme chaque note de l'accord en Sample liste de samples correspondant
%à chaque note dans l'accord
%Necessite : NoteToSample

declare
fun{ChordToSample Chord}
   case Chord
   of nil then nil
   [] H|T then {NoteToSample H}|{ChordToSample T}
   end
end

declare
N1 = note(name:a octave:4 sharp:false duration:0.0001 instrument:none)
N9 = silence(duration:0.0001)
C1=[N1 N9]
C2 = nil

{Browse {ChordToSample C1}}
{Browse {ChordToSample C2}}
