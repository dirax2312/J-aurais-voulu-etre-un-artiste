% transformation Stretch qui allonge la partition P en argument
% par le facteurF en multipliant chaque partitionItem par F
% Necessité : IsNote, NoteToExtended, IsExtendedNote, IsChord, ChordToExtended, IsExtendedChord, MultChord

declare
fun{Stretch F P}
   case P of nil then nil
   [] H|T then
      if {IsNote H} then
	 local H1 in
	    H1={NoteToExtended H}
	    local X={AdjoinAt H1 duration F*H1.duration} in
	       X|{Stretch F T} 
	    end
	 end
      elseif {IsExtendedNote H} then
	 local X={AdjoinAt H duration F*H.duration} in
	    	 X|{Stretch F T}
	 end
      elseif{IsChord H} then
	 local H1 in
	    H1={ChordToExtended H}
	    {MultChord F H1}|{Stretch F T} 
	 end
      elseif {IsExtendedChord H} then
	 {MultChord F H}|{Stretch F T} 
      else H|{Stretch F T}
      end
   else nil
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
ExtChord =[ExtNote1 ExtNote2 ExtNote3 ExtNote4]
ExtChord1 = [ExtNote4 ExtNote1]
Part = [Note3 Note4 ExtNote3 ExtNote4 Chord ExtChord]
Part1 = [Note1 ExtNote1 Chord1 ExtChord1]

{Browse {Stretch 2.0 Part}}
{Browse {Stretch 2.0 Part1}}
