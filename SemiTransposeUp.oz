%Transpose l'ExtNote mise en argument d'un demi ton au dessus
declare
fun{SemiTransposeUp ExtNote}
   if (ExtNote.name == c orelse
       ExtNote.name == d orelse
       ExtNote.name == f orelse
       ExtNote.name == g orelse
       ExtNote.name == a) andthen ExtNote.sharp == false
   then {AdjoinAt ExtNote sharp true}
   elseif ExtNote.name == e then {AdjoinAt ExtNote name f}
   elseif ExtNote.name == b then
      {AdjoinList ExtNote [name#c octave#(ExtNote.octave+1)]}
   elseif ExtNote.name == c then {AdjoinList ExtNote [name#d sharp#false]}
   elseif ExtNote.name == d then {AdjoinList ExtNote [name#e sharp#false]}
   elseif ExtNote.name == f then {AdjoinList ExtNote [name#g sharp#false]}
   elseif ExtNote.name == g then {AdjoinList ExtNote [name#a sharp#false]}
   elseif ExtNote.name == a then {AdjoinList ExtNote [name#b sharp#false]}
   else ExtNote
   end
end

declare
ExtNote1=note(name:d octave:3 sharp:true duration:2.0 instrument:none)
{Browse {SemiTransposeUp ExtNote1}}

 