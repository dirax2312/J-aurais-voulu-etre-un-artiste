% Prend un chord en argument et verifie s'il s'agit bien d'un chord
% en renvoyant true si c'est le cas et false sinon. Le cas où le chord est nil
% renvoit true

declare
fun{IsChord Chord}
   case Chord
   of nil then true
   [] H|T then
      if {IsNote H} then {IsChord T}
      else false
      end
   else false 
   end
end
