%Renvoit un Extended Chord dont on a Multiplie la duration de
%chaque Extrended Note par le facteur F

declare
fun{MultChord F Chord}
   case Chord
   of nil then nil
   [] H|T then
      local X = {AdjoinAt H duration F*H.duration}
      in X|{MultChord F T}
      end
   end
end