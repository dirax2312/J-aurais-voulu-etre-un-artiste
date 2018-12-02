%Prends deux listes de float en argument et renvoye une liste dont chaque �l�ment n_�me �l�ment est le resultatde la multiplication du n_�me �l�ments de LFac et de LMus
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

%Test r�el
{Browse {Mix Fun [merge([0.5#Mus1 0.3#Mus2])]}}
