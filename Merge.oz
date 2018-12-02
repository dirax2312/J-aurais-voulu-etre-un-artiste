%Prends deux listes de float en argument et renvoye une liste dont chaque élément n_ème élément est le resultatde la multiplication du n_éme éléments de LFac et de LMus
%Necessite : /
declare
fun{Merge LFac LMus}
   case LFac#LMus
   of nil#nil then nil
   [] (HFac|TFac)#(HMus|TMus) then
      {Map HMus fun{$ X} X*HFac end}|{Merge TFac TMus}
   end
end

%Test Gentil
declare
{Browse {Merge [1 2 3] [[1 2 3] [1 2 3] [1 2 3]]}}

%Test réel
{Browse {Mix Fun [merge([0.5#Mus1 0.3#Mus2])]}}
