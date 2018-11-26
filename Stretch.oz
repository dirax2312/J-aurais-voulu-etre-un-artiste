% transformation Stretch qui allonge la partition P en argument
% par le facteurF en multipliant chaque partitionItem par F
%Fonction pas finie 23/11/18


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
