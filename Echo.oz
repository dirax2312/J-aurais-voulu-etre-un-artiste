%Renvoye un merge qui contient la musique (Music) avec un facteur de 1.0 et l'autre élément est l'echo.
%Le fonction Listede0 renvoye une liste de D 0
%Necessite : /

declare
fun{Echo Delay Factor Music}
   fun{ListeDe0 Delay Acc}
      if Delay == 0 then Acc
      else {ListeDe0 Delay-1 0.|Acc}
      end
   end
in
   [merge([1.0#Music Factor#{Flatten samples({ListeDe0 {FloatToInt Delay*44100.0} nil})|Music}])]
end

%Test
{Browse {Echo 0.001 0.5 [1]}}
      
