declare
fun{Loop Duration Musique}
   fun{LoopTemp D Mus Acc}
      if D==0 then Acc
      else case Mus of nil then
	      {LoopTemp D Musique Acc}
	   [] H|T then
	      {LoopTemp D-1 T H|Acc}
	   end
      end
   end
in
   {Reverse {LoopTemp {FloatToInt 44100.0*Duration} Musique nil}}
end

declare
Musi=[1 2 3 4 5 6 7 8 9]
Duration=3.0*0.0001

{Browse Duration*44100.0}
{Browse {Loop Duration Musi}}