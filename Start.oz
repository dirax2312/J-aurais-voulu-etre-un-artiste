%Renvoye Music avec les samples correspondants à Sec modifiés pour monter l'intesité lineairement durant ce nombre de seconde
%Necessite : /

fun{Start1 Sec Music}
   local
      NbrSample = {FloatToInt Sec*44100.0}
      L1 = {List.take Music NbrSample+1}
      Nbr = 1.0/{IntToFloat {Length L1}-1}
      fun{ChangeLStart LStart Acc1 Acc2 Nbr}
	 case LStart
	 of nil then Acc1
	 [] H|nil then {ChangeLStart nil H*1.0|Acc1 Acc2 Nbr} 
	 [] H|T then {ChangeLStart T H*Acc2|Acc1 Acc2+Nbr Nbr}
	 end
      end
   in
      {Reverse {ChangeLStart L1 nil 0.0 Nbr}}
   end
end

%Test (avec le 44100.0 remplacé par 1.0)   
declare
{Browse {Start 1.0 [1.2 1.3 1.4 1.6]}} 
{Browse {Start 2.0 [1.2 1.3 1.4 1.6]}}
