% Renvoye une liste dont le debut et la fin sont graduels selon les durées DStart et DOut
%Necessite : Start1, Out

fun{Fade DStart DOut Music}
   local
      fun {Interval Xs N M}
	 case Xs
	 of nil then nil
	 [] H|T then {List.take {List.drop Xs N-1} M-N+1}
	 end
      end
      NbrSampleStart = {FloatToInt DStart*44100.0}
      NbrSampleOut = {FloatToInt DOut*44100.0}
      Linchange = {Interval Music NbrSampleStart+2 {Length Music}-NbrSampleOut}
   in
      {Flatten {Start1 DStart Music}|Linchange|{Out DOut Music}}
   end
end

%Test
Music = [1 2 3 4 5 6 7 8 910 11 12 13 14 15 16 17 18 19 20]
DStart = 0.0001
DOut = 0.0001
{Browse {Fade DStart DOut Music}}