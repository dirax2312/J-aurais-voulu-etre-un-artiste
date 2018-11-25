% fonction qui renvoye le nbr de note qu'il y a dans la partition en comptant les notes des accords et des transformations

declare
fun{Longueur Partition}
   fun{Longueur Partition Acc}
      case Partition
      of nil then Acc
      [] H|T then
	 if {IsExtendedNote H} then
	    {Browse 1}
	    {Longueur T Acc+1}
	 elseif {IsNote H} then
	    {Browse 2}
	    {Longueur T Acc+1}
	 elseif {IsChord H} then
	    {Browse 3}
	    {Longueur T Acc+{Length H}}
	 elseif {IsExtendedChord H} then
	    {Browse 4}
	    {Longueur T Acc+{Length H}}
	 else
	    {Browse 5}
	    {Longueur H 0}+{Longueur T Acc}
	 end
      end
   end
in
   {Longueur Partition 0}
end