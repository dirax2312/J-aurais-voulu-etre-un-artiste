% Transpose l'item d'un demi ton vers le dessus si N>0 et vers le bas si N<0
%NecessitÃ© : IsNote, NoteToExtended, IsExtendedNote, IsChord, ChordToExtended, IsExtendedChord, TransposeChordUp, TransposeChordDown,
% SemiTransposeUp, SempiTransposeDown

declare
fun{SemiTransposeCase Num Item}
   if Num > 0 then
      if {IsNote Item} then
	 if Item == silence then
	    {NoteToExtended Item}
	 else
	    {SemiTransposeUp {NoteToExtended Item}}
	 end
      elseif {IsExtendedNote Item} then
	 case Item of silcence(duration:Dur) then
	    Item
	 else
	    {SemiTransposeUp Item}
	 end
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


%Test
declare
ExtNote1=note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote2=note(name:d octave:3 sharp:false duration:2.0 instrument:none)
Note1 = a3
Note2 = b
Chord = [Note1 Note2]
ExtChord = [ExtNote1 ExtNote2]

{Browse {SemiTransposeCase ~1 ExtNote1}}
{Browse {SemiTransposeCase 1 ExtNote1}}
{Browse {SemiTransposeCase ~1 ExtNote2}}
{Browse {SemiTransposeCase 1 ExtNote2}}
{Browse {SemiTransposeCase ~1 Note1}}
{Browse {SemiTransposeCase 1 Note1}}
{Browse {SemiTransposeCase ~1 Note2}}
{Browse {SemiTransposeCase 1 Note2}}
{Browse {SemiTransposeCase ~1 Chord}}
{Browse {SemiTransposeCase 1 Chord}}
{Browse {SemiTransposeCase ~1 ExtChord}}
{Browse {SemiTransposeCase 1 ExtChord}}
