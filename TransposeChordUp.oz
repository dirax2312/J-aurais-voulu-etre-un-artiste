% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut
%Necessité : SemiTransposeUp

declare
fun{TransposeChordUp Ch}
   case Ch of nil then nil
   [] H|T then
      {SemiTransposeUp H}|{TransposeChordUp T}
   end
end

%Test
declare
ExtNote1=note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote2=note(name:d octave:3 sharp:false duration:2.0 instrument:none)
ExtNote3=note(name:e octave:3 sharp:false duration:2.0 instrument:none)
ExtNote4=note(name:b octave:3 sharp:false duration:2.0 instrument:none)
ExtChord=[ExtNote1 ExtNote2 ExtNote3 ExtNote4]

{Browse {TransposeChordUp ExtChord}}
