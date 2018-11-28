%Renvoye une partition ou les durées de chaque note sont remplacées par la durée NbrSec mise en argument divisée 
%par le nombre total de note qu'il y a dans la partition. 
%ATTENTION :  L'argument NbrSec est un Float
% Necessite : Longueur, IsNote, IsExtendedNote, IsChord, IsExtendedChord, NoteToExtended, ChordToExtended

declare
fun{Duration NbrSec Partition}
   local
      NbrNote = {Longueur Partition}
      NewDuration = NbrSec/{IntToFloat NbrNote}
   in
      local 
	 fun{Duration1 Partition NewDuration}
	    case Partition
	    of nil then nil
	    []H|T then
	       if {IsNote H} then
		  local H1 in
		     H1={NoteToExtended H}
		     local X = {AdjoinAt H1 duration NewDuration}
		     in X|{Duration1 T NewDuration}
		     end
		  end
	       elseif {IsChord H} then
		  local H1 in
		     H1 = {ChordToExtended H}
		     {ChangeChord NewDuration H1}|{Duration1 T NewDuration}
		  end 
	       elseif {IsExtendedNote H} then 
		  local
		     X = {AdjoinAt H duration NewDuration}
		  in X|{Duration1 T NewDuration}
		  end
	       elseif {IsExtendedChord H} then
		  {ChangeChord NewDuration H}|{Duration1 T NewDuration}
	       else H|{Duration1 T NewDuration}
	       end
	    else nil
	    end
	 end
      in
	 {Duration1 Partition NewDuration}
      end 
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

{Browse {Duration 11.0 Part}}
{Browse {Duration 6.0 Part1}}
