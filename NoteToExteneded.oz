% NoteToExtended modifié par nos soins pour prendre en compte un silence %
% Prend une note en argument et renvoit la extended note correspondante %
% Necessite les fcts : /


declare
fun {NoteToExtended Note}
   case Note
   of Name#Octave then
      note(name:Name octave:Octave sharp:true duration:1.0 instrument:none)
   [] Atom then
      case {AtomToString Atom}
      of [_] then
	 note(name:Atom octave:4 sharp:false duration:1.0 instrument:none)
      [] [N O] then
	 note(name:{StringToAtom [N]}
	      octave:{StringToInt [O]}
	      sharp:false
	      duration:1.0
	      instrument: none)
      else silence(duration:1.0)
      end
   end
end

%Test 
declare 
Note1 = a
Note2 = b2
Note3 = c4
Note4 = silence 
Note5 = d#5

{Browse {NoteToExtended Note1}}
{Browse {NoteToExtended Note2}}
{Browse {NoteToExtended Note3}}
{Browse {NoteToExtended Note4}}
{Browse {NoteToExtended Note5}}
