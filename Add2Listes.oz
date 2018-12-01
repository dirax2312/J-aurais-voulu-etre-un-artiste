%Additionne 2 listes éléments par éléments et renvoye la liste avec les sommes
%Necessite : /

declare
fun{Add2Listes L Li}
   case L#Li
   of nil#nil then nil 
   [] (H1|T1)#(H2|T2) then (H1+H2)|{Add2Listes T1 T2}
   end
end

%Test
declare
L1 = [1 2]
L2 = [1 2]
{Browse {Add2Listes L1 L2}}
