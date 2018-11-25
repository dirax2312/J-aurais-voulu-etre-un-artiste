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
		local X={AdjointAt H1 duration (F*H1.duration)} in
			X|T
		end
	    H1|{Stretch F T}
	 end
      elseif {IsExtendedNote H} then
	 local X={AdjointAt H duration (F*H.duration)} in
			X|T
		end
	 H|{Stretch F T}
      elseif{IsChord H} then
	 local H1 in
	    H1={ChordToExtended H}
	    local X={AdjointAt H1 duration (F*H1.duration)} in
			X|T
		end
	    H1|{Stretch F T}
	 end
      elseif {IsExtendedChord H} then
	 local X={AdjointAt H duration (F*H.duration)} in
			X|T
		end
	 H|{Stretch F T}
      else H|{Stretch T}
      end
   else nil
   end
end
