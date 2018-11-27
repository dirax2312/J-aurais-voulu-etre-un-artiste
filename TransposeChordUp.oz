% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut

declare
fun{TransposeChordUp Ch}
   case Ch of nil then nil
   [] H|T then
      {SemiTransposeUp H}|{TransposeChordUp T}
   end
end
