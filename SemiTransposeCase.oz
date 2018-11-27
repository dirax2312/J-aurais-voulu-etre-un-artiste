% Transpose l'item d'un demi ton vers le dessus si N>0 et vers le bas si N<0

declare
fun{SemiTransposeCase Num Item}
   if Num > 0 then
      if {IsNote Item} then
	 {SemiTransposeUp {NoteToExtended Item}}
      elseif {IsExtendedNote Item} then
	 {SemiTransposeUp Item}
      elseif {IsChord Item} then
	 {TransposeChordUp {ChordToExtended Item}}
      elseif {IsExtendedChord Item} then
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
      elseif {IsExtendedChord Item} then
	 {TransposeChordDown Item}
      else nil
      end
   else Item
   end
end
