% Renvoit une flat partition qui est issue de la partition en argument

% Nécessite: IsNote NoteToExtended IsChord ChordToExtended 
%          IsExtendedNote IsExtendedChord Duration Drone
%	   Stretch Transpose

declare
fun{PartitionToTimedList Part}
   case Part of nil then nil
   [] H|T then
      if {IsNote H} then
	 {NoteToExtended H}|{PartitionToTimedList T}
      elseif {IsChord H} then
	 {ChordToExtended H}|{PartitionToTimedList T}
      elseif {IsExtendedNote H} then
	 H|{PartitionToTimedList T}
      elseif {IsExtendedChord H} then
	 H|{PartitionToTimedList T}
      else
	 case H of duration(seconds:Dur Part) then
	    {Append {Duration Dur {PartitionToTimedList Part}} {PartitionToTimedList T}}
	 [] drone(note:Item amount:N) then
	    {Append {Drone Item N} {PartitionToTimedList T}}
	 [] stretch(factor:Fac Part) then
	    {Append {Stretch Fac {PartitionToTimedList Part}} {PartitionToTimedList T}}
	 [] transpose(semitones:N Part) then
	    {Append {Transpose N {PartitionToTimedList Part}} {PartitionToTimedList T}}	    
	 end
      end
   end
end

% Test
declare
ExtChord1=[ExtNote1 ExtNote3 ExtNote4 ExtNote6]

declare
Part=[a X]
Part1=[c Z a e]
W=stretch(factor:2.0 Part)
X=duration(seconds:3.0 [a Y e])
Y=drone(note:a9 amount:7)
Z=transpose(semitones:3 [ExtChord1])

{Browse {PartitionToTimedList [a3 W c#5]}}
