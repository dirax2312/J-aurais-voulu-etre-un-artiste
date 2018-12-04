%Renvoye Music avec les samples correspondants à Sec modifiés pour monter l'intesité lineairement durant ce nombre de seconde
%Necessite : /

declare
fun{Start Sec Music}
   local
      NbrSample = {FloatToInt Sec*1.0}
      L1 = {List.take Music NbrSample+1}
      L2 = {List.drop Music NbrSample+1}
      Nbr = 1.0/{IntToFloat {Length L1}-1}
      fun{ChangeL1 L1 Acc1 Acc2 Nbr}
	 case L1
	 of nil then Acc1
	 [] H|nil then {ChangeL1 nil 1.0|Acc1 Acc2 Nbr} 
	 [] H|T then {ChangeL1 T Acc2|Acc1 Acc2+Nbr Nbr}
	 end
      end
   in
      {Flatten {Reverse {ChangeL1 L1 nil 0.0 Nbr}}|L2}
   end
end

%Test (avec le 44100.0 remplacé par 1.0)   
declare
{Browse {Start 1.0 [1.2 1.3 1.4 1.6]}} 
{Browse {Start 2.0 [1.2 1.3 1.4 1.6]}}
