% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut

%Nécessite: SemiTransposeDown

declare
fun{TransposeChordDown Ch}
   case Ch of nil then nil
   [] H|T then
      {SemiTransposeDown H}|{TransposeChordDown T}
   end
end

%Test
declare
ExtNote1=note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote2=note(name:d octave:3 sharp:false duration:2.0 instrument:none)
ExtNote3=note(name:f octave:3 sharp:false duration:2.0 instrument:none)
ExtNote4=note(name:c octave:3 sharp:false duration:2.0 instrument:none)

declare
ExtChord1=[ExtNote1 ExtNote2 ExtNote3 ExtNote4]

{Browse {TransposeChordDown ExtChord1}}
