% fonction qui renvoye le nbr de note qu'il y a dans la partition en comptant les notes des accords et des transformations
% Necessite : IsNote, IsExtendedNote, IsChord, IsExtendedChord

declare
fun{Longueur Partition}
   fun{Longueur Partition Acc}
      case Partition
      of nil then Acc
      [] H|T then
	 if {IsNote H} then {Longueur T Acc+1}
	 elseif {IsExtendedNote H} then {Longueur T Acc+1}
	 elseif {IsChord H} then {Longueur T Acc+{Length H}}
	 elseif {IsExtendedChord H} then {Longueur T Acc+{Length H}}
	 end
      end
   end
in
   {Longueur Partition 0}
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
ExtChord =[ExtNote1 ExtNote2 ExtNote3 ExtNote4]
ExtChord1 = [ExtNote4 ExtNote1]
Part = [Note3 Note4 ExtNote3 ExtNote4 Chord ExtChord]
Part1 = [Note1 ExtNote1 Chord1 ExtChord1]

{Browse {Longueur Part}}
{Browse {Longueur Part1}}
