% Prend un argument Note et un nombre Num
% renoit une liste qui comprends Num fois Note
% Si Note est une note, la fonction renvoit une liste de note
% Si Note est une extended note, la fonction
% renvoit une liste d'extended note
% Si note est quoi que ce soit d'autre, renvoit nil

% Nécessite: IsNote NoteToExtended IsExtended

declare
fun{Drone Note Num}
      fun{Drone1 Note Num Acc}
	 if{IsNote Note} then
	    if{IsInt Num} then
	       if Num > 0 then
		  {Drone1 {NoteToExtended Note} Num-1 {NoteToExtended Note}|Acc} 
	       else Acc
	       end
	    else nil
	    end
	 elseif {IsExtendedNote Note} then
	    if{IsInt Num} then
	       if Num > 0 then
		  {Drone1 Note Num-1 Note|Acc} 
	       else Acc
	       end
	    else Acc
	    end
	 else Acc
	 end
      end      
in
   {Drone1 Note Num nil}
end

% Test
{Browse {Drone a 3}}
{Browse {Drone a#2 6}}
{Browse {Drone a4 0}} %renvoit nil
{Browse {Drone g 3}}
{Browse {Drone r 1}} %renvoit nil
{Browse {Drone a ~1}} %renvoit nil
