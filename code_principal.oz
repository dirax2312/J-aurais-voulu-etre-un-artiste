
% Fonction qui prend en argument une note et vérifie si il s'agit
% bien d'une note en renvoyant true si oui et false sinon.
% Un silence renvoit true

%Nécessite les fonctions: /

declare
fun{IsNote A}
   case A of  Name#Octave then
      if ( Name==a orelse Name==c orelse Name==d
	   orelse Name==f orelse Name==g andthen {IsInt Octave})
      then true
      else false
      end
   [] Atom then
      if{IsAtom Atom} then
	 if Atom==silence then true
	  else 
	    case {AtomToString Atom} of [_] then
	       if ( Atom==a orelse Atom==b orelse Atom==c orelse Atom==d orelse
		 Atom==e orelse Atom==f orelse Atom==g)
	       then true
	       else false
	       end
	    [] [N O] then
	       if ([N]=={AtomToString a} orelse [N]=={AtomToString b} orelse [N]=={AtomToString c} orelse [N]=={AtomToString d} orelse
		   [N]=={AtomToString e} orelse [N]=={AtomToString f} orelse [N]=={AtomToString g} andthen {IsInt {StringToInt [O]}})
	       then true
	       else false
	       end    
	    else false
	    end
	 end
      else false
      end      
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un chord en argument et verifie s'il s'agit bien d'un chord
% en renvoyant true si c'est le cas et false sinon. Le cas où le chord est nil
% renvoit true

%Nécessite : IsNote

declare
fun{IsChord Chord}
   case Chord
   of nil then true
   [] H|T then
      if {IsNote H} then {IsChord T}
      else false
      end
   else false 
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
