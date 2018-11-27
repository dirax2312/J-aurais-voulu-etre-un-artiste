% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut

declare
fun{TransposeChord Ch}
   case Ch of nil then nil
   [] H|T then
      {SemiTranspose H}|{TransposeCh T}
   end
end
