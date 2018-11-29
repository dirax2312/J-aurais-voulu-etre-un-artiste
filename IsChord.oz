% Prend un chord en argument et verifie s'il s'agit bien d'un chord
% en renvoyant true si c'est le cas et false sinon. Le cas où le chord est nil
% renvoit true

%Nécessite : IsNote

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

% Test
%doit renvoyer true
{Browse {IsChord [a g f]}}
{Browse {IsChord [a]}}
{Browse {IsChord nil}}
{Browse {IsChord [silence silence]}}

%doit renvoyer false
{Browse {IsChord [a note(name:f octave:2 sharp:true duration:1.0 instrument:none) f]}}
{Browse {IsChord [silence bonjour]}}
