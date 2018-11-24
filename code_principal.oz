%Code principal du projet P2 avec toutes les fonctions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fonction qui prend en argument une note et vérifie si il s'agit
% bien d'une note en renvoyant true si oui et false sinon.
% Un silence renvoit tru


declare
fun{IsNote A}
   case A of nil then true
   [] Name#Octave then
      if ( Name==a orelse Name==b orelse Name==c orelse Name==d orelse
	   Name==e orelse Name==f orelse Name==g andthen {IsInt Octave})
      then
	 true
      else
	 false
      end
   [] Atom then
      if Atom==silence then true
	 else 
	 case {AtomToString Atom} of [_] then
	    if ( Atom==a orelse Atom==b orelse Atom==c orelse Atom==d orelse
		 Atom==e orelse Atom==f orelse Atom==g)
	    then
	       true
	    else
	       false
	    end
	 [] [N O] then
	    if ([N]=={AtomToString a} orelse [N]=={AtomToString b} orelse [N]=={AtomToString c} orelse [N]=={AtomToString d} orelse
		[N]=={AtomToString e} orelse [N]=={AtomToString f} orelse [N]=={AtomToString g} andthen {IsInt {StringToInt [O]}})
	    then
	       true
	    else
	       false
	    end    
	 else
	    false
	 end
      end
      
   else false
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un chord en argument et verifie s'il s'agit bien d'un chord
% en renvoyant true si c'est le cas et false sinon. Le cas où le chord est nil
% renvoit true

declare
fun{IsChord Chord}
   case Chord
   of nil then true
   [] H|T then
      if {IsNote H} then {IsChord T}
      else false
      end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Renvoit true si l'argument est une ExtenededNote et False sinon

declare
fun{IsExtendedNote Note}
   if {IsRecord Note} then 
      if {Label Note} == silence then 
	 if {Width Note}==1 
	    andthen {Arity Note}==[duration]
	    andthen {IsFloat Note.duration}
	 then true
	 else false
	 end
      else
	 if {Label Note} == note then 
	    if {Width Note} == 5
	       andthen {Arity Note} == [duration instrument name octave sharp]
	       andthen {IsAtom Note.name} then
	       if ((Note.name == a orelse
		    Note.name == b orelse
		    Note.name == c orelse
		    Note.name == d orelse
		    Note.name == e orelse
		    Note.name == f orelse
		    Note.name == g)
		   andthen {IsInt Note.octave}
		   andthen {IsBool Note.sharp}
		   andthen {IsFloat Note.duration}
		   andthen {IsAtom Note.instrument})
	       then true
	       else false
	       end
	    else false
	    end
	 else false
	 end
      end
   else false 
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un Extended chord en argument et verifie s'il s'agit bien d'un Extended
% chord en renvoyant true si c'est le cas et false sinon. Le cas où le chord
% est nil renvoit true

declare
fun{IsExtendedChord Chord}
   case Chord
   of nil then true
   [] H|T then
      if {IsExtendedNote H} then {IsChord T}
      else false
      end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NoteToExtended modifié par nos soins pour prendre en compte un silence %
% Prend une note en argument et renvoit la extended note correspondante %


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

