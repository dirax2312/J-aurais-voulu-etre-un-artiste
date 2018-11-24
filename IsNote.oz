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