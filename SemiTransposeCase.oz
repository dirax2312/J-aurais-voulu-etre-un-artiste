declare
fun{SemiTransposeCase Num Item}
   if Num > 0 then
      if {IsNote Item} then
	 {SemiTransposeUp {NoteToExtended Item}}
      elseif {IsExtendedNote Item} then
	 {SemiTransposeUp Item}
      elseif {IsChord Item} then
	 {TransposeChordUp {ChordToExtended Item}}
      elseif {IsEtendedChord Item} then
	 {TransposeChordUp Item}
      else nil
      end
   elseif Num < 0 then
      if {IsNote Item} then
	 {SemiTransposeDown {NoteToExtended Item}}
      elseif {IsExtendedNote Item} then
	 {SemiTransposeDown Item}
      elseif {IsChord Item} then
	 {TransposeChordDown {ChordToExtended Item}}
      elseif {IsEtendedChord Item} then
	 {TransposeChordDown Item}
      else nil
      end
   else Part
   end
end
