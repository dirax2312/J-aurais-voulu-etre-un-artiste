%Transpose une ExtNote d'un demi ton vers le bas

% Nécessite: /

declare
fun{SemiTransposeDown ExtNote}
   if(ExtNote.name == d andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#c sharp#true]}
   elseif (ExtNote.name == e andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#d sharp#true]}
   elseif (ExtNote.name == g andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#f sharp#true]}
   elseif (ExtNote.name == a andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#g sharp#true]}
   elseif (ExtNote.name == b andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#a sharp#true]}
      
   elseif (ExtNote.name == f andthen {Not ExtNote.sharp})  then
      {AdjoinAt ExtNote name e}
   elseif (ExtNote.name == c andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#b octave#(ExtNote.octave-1)]}
   elseif (ExtNote.name == c orelse
	   ExtNote.name == d orelse
	   ExtNote.name == f orelse
	   ExtNote.name == g orelse
	   ExtNote.name == a) andthen ExtNote.sharp
   then {AdjoinAt ExtNote sharp false}
   else ExtNote
   end
end

% Test
declare
ExtNote1 = note(name:a octave:3 sharp:true duration:2.0 instrument:none)
ExtNote2 = note(name:a octave:3 sharp:false duration:2.0 instrument:none)
ExtNote3 = note(name:b octave:3 sharp:false duration:2.0 instrument:none)
ExtNote4 = note(name:c octave:3 sharp:true duration:2.0 instrument:none)
ExtNote5 = note(name:c octave:3 sharp:false duration:2.0 instrument:none)
ExtNote6 = note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote7 = note(name:d octave:3 sharp:false duration:2.0 instrument:none)
ExtNote8 = note(name:e octave:3 sharp:false duration:2.0 instrument:none)
ExtNote9 = note(name:f octave:3 sharp:true duration:2.0 instrument:none)
ExtNote10 = note(name:f octave:3 sharp:false duration:2.0 instrument:none)
ExtNote11 = note(name:g octave:3 sharp:true duration:2.0 instrument:none)
ExtNote12 = note(name:g octave:3 sharp:false duration:2.0 instrument:none)
{Browse {SemiTransposeDown ExtNote1}}
{Browse {SemiTransposeDown ExtNote2}}
{Browse {SemiTransposeDown ExtNote3}}
{Browse {SemiTransposeDown ExtNote4}}
{Browse {SemiTransposeDown ExtNote5}}
{Browse {SemiTransposeDown ExtNote6}}
{Browse {SemiTransposeDown ExtNote7}}
{Browse {SemiTransposeDown ExtNote8}}
{Browse {SemiTransposeDown ExtNote9}}
{Browse {SemiTransposeDown ExtNote10}}
{Browse {SemiTransposeDown ExtNote11}}
{Browse {SemiTransposeDown ExtNote12}}
