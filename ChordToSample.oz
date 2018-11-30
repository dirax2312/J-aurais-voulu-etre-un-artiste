%Transforme chaque note de l'accord en Sample
%Necessite : NoteToSample

declare
fun{ChordToSample Chord}
   case Chord
   of nil then nil
   [] H|T then {NoteToSample H}|{ChordToSample T}
   end
end

declare
N1 = note(name:a octave:4 sharp:true duration:2.0 instrument:none)
N2 = note(name:b octave:5 sharp:false duration:2.0 instrument:none)
N3 = note(name:b octave:6 sharp:false duration:2.0 instrument:none)
N4 = note(name:b octave:7 sharp:false duration:2.0 instrument:none)
N5 = note(name:c octave:3 sharp:false duration:2.0 instrument:none)
N6 = note(name:d octave:3 sharp:true duration:2.0 instrument:none)
N7 = note(name:d octave:4 sharp:false duration:2.0 instrument:none)
N8 = note(name:g octave:4 sharp:true duration:2.0 instrument:none)
N9 = silence(duration:4.0)
N10 = note(name:a octave:4 sharp:false duration:2.0 instrument:none)
C1={N1 N2 N3 N4 N5 N6 N7 N8 N9 N10]
C2 = nil

{Browse {ChordToSample C1}}
{Browse {ChordToSample C2}}