%Renvoye une liste avec N fois l'élément Music dedans
%Necessite : /

declare
fun{Repeat N Music}
   fun{Repeat N Music Acc}
      if N == 0 then Acc
      else {Repeat N-1 Music Music|Acc}
      end
   end
in
   {Repeat N Music nil}
end

%Test
declare
Music1 = [1.0 2.0 3.1]
Music2 = 2.0
{Browse {Repeat 3 Music1}}
{Browse {Repeat 2 Music2}}