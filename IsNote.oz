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

% Test

%doit renvoyer true
{Browse {IsNote a}}
{Browse {IsNote b}}
{Browse {IsNote c}}
{Browse {IsNote d}}
{Browse {IsNote e}}
{Browse {IsNote f}}
{Browse {IsNote g}}
{Browse {IsNote a#1}}
{Browse {IsNote a1}}
{Browse {IsNote silence}}

%doit renvoyer false
{Browse {IsNote h}}
{Browse {IsNote b#1}}
{Browse {IsNote e#3}}
{Browse {IsNote r#3}}
{Browse {IsNote t2}}
{Browse {IsNote [e b]}}
{Browse {IsNote bonjou}}
