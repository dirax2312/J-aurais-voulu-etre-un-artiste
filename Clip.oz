%Renvoye la liste Music dont les valeurs sont comprises entre Low et High. Dans le cas ou c'est au dessus ou en dessous de ces valeurs, renvoye soit Low Soit High
%Necessite : /

declare
fun{Clip Low High Music}
   if Low>=High then nil
   else
      case Music
      of nil then nil
      [] H|T then
	 if (H=<High andthen H>=Low) then H|{Clip Low High T}
	 elseif H>High then High|{Clip Low High T}
	 else Low|{Clip Low High T}
	 end
      end
   end
end


%Test
declare
{Browse {Clip 1.0 3.0 [1.0 2.2 3.0 ~1.0 4.3]}}