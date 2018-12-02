% Ces deux fonctions sont fort semblables. Elles prennent toutes deux une liste de tuples (de type Fact#Music) en argument en renvoyent une lise composées des facteurs (pour la fonction ListFact) et une liste de Music (pour la fonction ListMusic)
%Necessite : /
declare 
fun{ListFact List}
   if List == nil then nil
   else case List.1
	of Fact#Music then
	   Fact|{ListFact List.2}
	end
   end
end
fun{ListMusic List}
   if List == nil then nil
   else case List.1
	of Fact#Music then
	   Music|{ListMusic List.2}
	end
   end
end


%Test gentils 
declare
L1 = [4#2 5#2 6#2]
{Browse {ListFact L1}}
{Browse {ListMusic L1}}

%Test réels
L2 = [0.5#Mus1 0.34#Mus2 0.78#Mus3]
{Browse {ListFact L2}}
{Browse {ListMusic L2}}


