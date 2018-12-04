%Renvoye Music avec les samples correspondants à Sec modifiés pour descendre l'intesité lineairement durant ce nombre de seconde
%Necessite : /

declare
fun{Out Sec Music}
   local
      NbrSample = {FloatToInt Sec*44100.0}
      L1 = {List.drop Music {Length Music}-NbrSample}
      Nbr = 1.0/{IntToFloat {Length L1}}
      fun{ChangeLOut LOut Acc1 Acc2 Nbr}
	 case LOut
	 of nil then Acc1 
	 [] H|T then {ChangeLOut T H*Acc2|Acc1 Acc2+Nbr Nbr}
	 end
	 end
   in
      {ChangeLOut L1 nil 0.0 Nbr}
   end
end

%Test (avec 1.0 à la place de 44100.0)
{Browse {Out 1.0 [1.2 1.3 1.4 1.6]}} 
{Browse {Out 2.0 [1.2 1.3 1.4 1.6]}}
