% Renvoye la frequence de la note selon la formule donnée dans l'enoncé
% Necessite : Hauteur 
declare
fun{Frequence Note}
   case Note of note(name:Name octave:Oct sharp:Sharp duration:Dur instrument:Inst) then
      local H in
	 H={IntToFloat {Hauteur Note}}
	 {Pow 2.0 H/12.0}*440.0
      end
	[] silence(duration:Dur) then 0.0
   else 0.0
   end
end

%Test
declare
Note1=note(name:g octave:4 sharp:false duration:1.0 instrument:none)
Note2=silence(duration:4.0)

{Browse {Frequence Note1}}
{Browse {Frequence Note2}}
