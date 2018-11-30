%Renvoye 1 si la note est au dessus de A4 -1 si c'est en dessus et 0 si c'est un silence ou A4
%Necessite : /

declare
fun{Emplacement Note}
   case Note of note(name:N octave:O sharp:S duration:D instrument:I) then 
      if (O < 4) then ~1
      elseif (O > 4) then 1
      elseif
	 (N == c orelse
	  N == d orelse
	  N == e orelse
	  N == f orelse
	  N == g) then ~1
      elseif ((N == a andthen S == true) orelse
	      N == b) then 1
      else 0
      end
   else 0
   end
end 


declare
fun{SemiTransposeUp ExtNote}
   case ExtNote of silence(duration:Dur) then
      ExtNote
   else
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
end

declare
fun{SemiTransposeDown ExtNote}
   case ExtNote of silence(duration:Dur) then
      ExtNote
   else
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
	      ExtNote.name == a) andthen ExtNote.sharp then
	 {AdjoinAt ExtNote sharp false}
      else ExtNote
      end
   end	 
end

%Renvoye la haute d'une note etendue
%Necessite : Emplacement, SemiTransposeUp, SemiTransposeDown

declare
fun{Hauteur Note}
   fun{HauteurAcc Note Acc}
      if {Emplacement Note} == 0 then Acc
      elseif {Emplacement Note} < 0 then {HauteurAcc {SemiTransposeUp Note} Acc-1}
      else  {HauteurAcc {SemiTransposeDown Note} Acc+1}
      end
   end
in
   {HauteurAcc Note 0}
end
% Renvoye la frequence de la note selon la formule donnée dans l'enoncé
% Necessite : Hauteur 
declare
fun{Frequence Note}
   case Note of note(name:Name octave:Oct sharp:Sharp duration:Dur instrument:Inst) then
      local H in
	 H={IntToFloat {Hauteur Note}}
	 {Pow 2.0 H/12.0}*440.0
      end
   [] silence(duration:Dur) then 0
   else nil
   end
end

%Test
declare
Note1=note(name:g octave:4 sharp:false duration:1.0 instrument:none)
Note2=silence(duration:4.0)

{Browse {Frequence Note1}}
{Browse {Frequence Note2}}


	 
      
