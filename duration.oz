%renvoye une partition ou chaque note a une durée de NbrSec/NbrNote
%

declare
fun{Duration NbrSec Partition}
   NbrNote = {Longueur Partition}
   NewDuration = NbrSec/NbrNote
   fun{Duration1 Partition NewDuration}
      case Partition
      of nil then nil
      []H|T then
	 if {IsNote H} then
	    H={NoteToExtended H}
	    local
	       X = {AdjoinAt H duration NewDuration}
	    in X|{Duration T NewDuration}
	    end
	 else
	    if {IsChord H} then
	       H = {ChordToExtended H}
	       case H
	       of nil then nil
	       [] H1|T1 then
		  local X = {AdjointAt H1 duration NewDuration}
		  in X|{Duration T1 NewDuration}|{Duration T NewDuration}
		  end
	       end
	    else
	       if {IsExtendedNote H} then 
		  local
		     X = {AdjoinAt H duration NewDuration}
		  in X|{Duration T NewDuration}
		  end
	       else
		  case H
		  of nil then nil
		  [] H1|T1 then
		     local X = {AdjointAt H1 duration NewDuration}
		     in X|{Duration T1 NewDuration}|{Duration T NewDuration}
		     end
		  end
	       end
	    end
	 end
      end
   in
      {Duration Partition NewDuration}
   end
end