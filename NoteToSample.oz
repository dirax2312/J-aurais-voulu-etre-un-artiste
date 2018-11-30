%Prends une note en argument et renvoit le samples correspondants
%Le nombre de samples est défini par le produit de la duration de
%la note avec 44100. Dans le cas où ce produit ne donne pas un
%nombre entier (par exemple dans le cas de note.duration=0.0001)
%la fonction arrondi le nombre de sample grâce à la fonction
%FloatToInt

%Nécessite: Frequence

declare
fun{NoteToSample Note}
   fun{NoteToSampleAcc Note Acc} 
      if  Acc > {FloatToInt Note.duration*44100.0} then nil
      else
	 local Ai in
	    Ai=0.5*{Sin 2.0*{Acos ~1.0}*{Frequence Note}*{IntToFloat Acc}/44100.0}
	    Ai|{NoteToSampleAcc Note Acc+1}
	 end
      end
   end
in
   {NoteToSampleAcc Note 1}
end

%Test
declare
Note=note(name:a octave:4 sharp:false duration:0.0001 instrument:none)
{Browse {NoteToSample Note}}
%duration de la note est si faible afin que l'on puisse compter que la longueur de samples puisse comptée
{Browse 0.5*{Sin 2.0*{Acos ~1.0}*440.0*456.0/44100.0}}
%vérification de la valeur de l'intensité poue une valeur de i et de f posée.