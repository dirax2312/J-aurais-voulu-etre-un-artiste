   fun{Mix Fun Music}
      case Music of nil then nil
      [] H|T then
	 case H of samples(Sam) then
	    {Flatten Sam|{Mix Fun T}}
	 [] partition(Part) then
	    {Flatten {PartitionToSamples {Fun Part}}|{Mix Fun T}}
	 [] wave(FileName) then
	    {Flatten {Wave FileName}|{Mix Fun T}}
	 [] merge(List) then
	    local
	       LFac = {ListFact List}
	       LMus = {ListMusic List}
	    in
	       {Flatten {ChordToOneSample {Merge LFac {Map LMus fun{$ X} {Mix Fun X} end}}}|{Mix Fun T}}
	    end
	 [] repeat(amount:N Music) then
	    {Flatten {Repeat N {Mix Fun Music}}|{Mix Fun T}}
	 [] clip(low:Low high:High Music) then
	    {Browse {Clip Low High {Mix Fun Music}}}
	    {Flatten {Clip Low High {Mix Fun Music}}|{Mix Fun T}}
	 else 4|{Mix Fun T}
	 end
      else 4
      end
   end