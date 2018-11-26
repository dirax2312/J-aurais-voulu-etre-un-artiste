%Renvoye une partition ou les durées de chaque note sont remplacées par la durée NbrSec mise en argument divisée 
%par le nombre total de note qu'il y a dans la partition

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
		  {ChangeChord H NewDuration}|{Duration1 T NewDuration}
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
