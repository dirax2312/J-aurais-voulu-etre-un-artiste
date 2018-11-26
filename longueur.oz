% fonction qui renvoye le nbr de note qu'il y a dans la partition en comptant les notes des accords et des transformations

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
	 else {Longueur H 0}+{Longueur T Acc}
	 end
      end
   end
in
   {Longueur Partition 0}
end
