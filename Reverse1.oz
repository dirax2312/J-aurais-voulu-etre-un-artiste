%prend en argument une musique. Applique Mix dessus puis renoit
%la liste d'échantillons dans le sens inverse

%Nécessite: Mix

declare
fun{Reverse1 Fun Music}
   {Reverse {Mix Fun Music}}
end

%Test

declare
Sam=[1.0 2.0 3.0]
M=[samples(Sam)]
{Browse {Reverse [1.0 2.0 3.0]}}
{Browse {Reverse1 PartitionToTimedList M}}