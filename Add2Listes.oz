%Additionne 2 listes éléments par éléments et renvoye une liste avec les sommes. Si les deux listes ne sont pas de même longeurs, le debut 
%de la liste renvoyée sera la somme des deux listes et losrsque la liste la plus courte est finie, on place les elements de la liste la plus
%longue (ex : si L1 = [1 2] et L2 = [1 2 3 4] le debut de la liste renvoyée sera [2 4 et la suite sera 3 4] )
%Necessite : /

declare
fun{Add2Listes L1 L2}
   case L1#L2
   of nil#nil then nil
   [] (H1|T1)#(H2|T2) then (H1+H2)|{Add2Listes T1 T2}
   [] nil#(H2|T2) then H2|{Add2Listes nil T2}
   [] (H1|T1)#nil then H1|{Add2Listes T1 nil}
   end
end

%Test
declare
L1 = [1 2]
L2 = [1 2]
L3 = [1 2 4 5]
{Browse {Add2Listes L1 L2}}
{Browse {Add2Listes L2 L3}}
{Browse {Add2Listes L3 L2}}
