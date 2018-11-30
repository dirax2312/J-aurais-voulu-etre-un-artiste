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

%Test

%Renvoye Nbr positif
declare
ExtNote1 = note(name:a octave:4 sharp:true duration:2.0 instrument:none)
ExtNote2 = note(name:b octave:5 sharp:false duration:2.0 instrument:none)
ExtNote3 = note(name:b octave:6 sharp:false duration:2.0 instrument:none)
ExtNote4 = note(name:b octave:7 sharp:false duration:2.0 instrument:none)
{Browse {Hauteur ExtNote1}}
{Browse {Hauteur ExtNote2}}
{Browse {Hauteur ExtNote3}}
{Browse {Hauteur ExtNote4}}

%Renvoye Nbr negatif
ExtNote5 = note(name:c octave:3 sharp:false duration:2.0 instrument:none)
ExtNote6 = note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote7 = note(name:d octave:4 sharp:false duration:2.0 instrument:none)
ExtNote8 = note(name:g octave:4 sharp:true duration:2.0 instrument:none)
{Browse {Hauteur ExtNote5}}
{Browse {Hauteur ExtNote6}}
{Browse {Hauteur ExtNote7}}
{Browse {Hauteur ExtNote8}}
%Renvoye 0
ExtNote9 = silence(duration:4.0)
ExtNote10 = note(name:a octave:4 sharp:false duration:2.0 instrument:none)
{Browse {Hauteur ExtNote9}}
{Browse {Hauteur ExtNote10}}