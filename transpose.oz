% renvoye une partition qui a ete augmentée/diminuée d'une certain nombre (Num) de demi tons
% Necessite : TransposeCase

declare
fun{Transpose Num Part}
   case Part
   of nil then nil
   [] H|T then
      {TransposeCase Num H}|{Transpose Num T}
   end
end

%Test 
declare 
Note1 = a
Note2 = b#4
Note3 = f2
Note4 = silence 
ExtNote1 = note(name:a octave:6 sharp:true duration:4.0 instrument:none)
ExtNote2 = note(name:c octave:2 sharp:false duration:4.2 instrument:none)
ExtNote3 = note(name:g octave:3 sharp:true duration:1.5 instrument:none)
ExtNote4 = silence(duration:4.0)
Chord = [Note1 Note2 Note3]
Chord1 = [Note3 Note1]
ExtChord =[ExtNote1 ExtNote2 ExtNote3]
ExtChord1 = [ExtNote4 ExtNote1]
Part = [Note3 ExtNote3 Chord ExtChord]
Part1 = [Note1 ExtNote1 Chord1 ExtChord1]

{Browse {Transpose ~2 Part}}
{Browse {Transpose 3 Part1}}
