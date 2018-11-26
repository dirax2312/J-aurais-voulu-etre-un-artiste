% Convertit une partition en flat partition %
% Cas des Transformations à traiter

declare
fun{PartitionToTimedList Part}
   case Part of nil then nil
   [] H|T then
      if {IsNote H} then
	 {NoteToExtended H}|{PartitionToTimedList T}
      elseif {isChord H} then
	 {ChordToExtended H}|{PartitionToTimedList T}
      elseif {IsExtendedNote H} then
	 H|{PartitionToTimedList T}
      elseif {IsExtendedChord H} then
	 H|{PartitionToTimedList T}
	% elseif {IsTransformation} then   %à modifier
      else nil                             %à modifier
      end
   end
end