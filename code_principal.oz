%Code principal du projet P2 avec toutes les fonctions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fonction qui prend en argument une note et vérifie si il s'agit
% bien d'une note en renvoyant true si oui et false sinon.
% Un silence renvoit tru


declare
fun{IsNote A}
   case A of  Name#Octave then
      if ( Name==a orelse Name==b orelse Name==c orelse Name==d orelse
	   Name==e orelse Name==f orelse Name==g andthen {IsInt Octave})
      then
	 true
      else
	 false
      end
   [] Atom then
      if{IsAtom Atom} then
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
      else
	 false
      end      
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
   else false
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
      if {IsExtendedNote H} then {IsExtendedChord T}
      else false
      end
   else false 	
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

% Transforme un accord (liste de notes) en un accord etendu (une liste de note
% étendues)

declare
fun{ChordToExtended Chord}
   case Chord
   of nil then nil
   [] H|T then {NoteToExtended H}|{ChordToExtended T}
   else false
   end   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoit un Extended Chord dont on a Multiplie la duration de
%chaque Extrended Note par le facteur F

declare
fun{MultChord F Chord}
   case Chord
   of nil then nil
   [] H|T then
      local X = {AdjoinAt H duration F*H.duration}
      in X|{MultChord F T}
      end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convertit une partition en flat partition %
% Cas des Transformations à traiter

declare
fun{PartitionToTimedList Part}
   case Part of nil then nil
   [] H|T then
      if {IsNote H} then
	 {NoteToExtended H}|{PartitionToTimedList T}
      elseif {IsChord H} then
	 {ChordToExtended H}|{PartitionToTimedList T}
      elseif {IsExtendedNote H} then
	 H|{PartitionToTimedList T}
      elseif {IsExtendedChord H} then
	 H|{PartitionToTimedList T}
	% elseif {IsTransformation} then   %à modifier
      else nil                             %à modifier
      end
   else nil
   end   
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% transformation Stretch qui allonge la partition P en argument
% par le facteurF en multipliant chaque partitionItem par F
%Fonction pas finie 23/11/18


declare
fun{Stretch F P}
   case P of nil then nil
   [] H|T then
      if {IsNote H} then
	 local H1 in
	    H1={NoteToExtended H}
	    local X={AdjoinAt H1 duration F*H1.duration} in
	       X|{Stretch F T} 
	    end
	 end
      elseif {IsExtendedNote H} then
	 local X={AdjoinAt H duration F*H.duration} in
	    	 X|{Stretch F T}
	 end
      elseif{IsChord H} then
	 local H1 in
	    H1={ChordToExtended H}
	    {MultChord F H1}|{Stretch F T} 
	 end
      elseif {IsExtendedChord H} then
	 {MultChord F H}|{Stretch F T} 
      else H|{Stretch F T}
      end
   else nil
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un argument Note et un nombre Num
% renoit une liste qui comprends Num fois Note
% Si Note est une note, la fonction renvoit une liste de note
% Si Note est une extended note, la fonction
% renvoit une liste d'extended note
% Si note est quoi que ce soit d'autre, renvoit nil

declare
fun{Drone Note Num}
      fun{Drone1 Note Num Acc}
	 if{IsNote Note} then
	    if{IsInt Num} then
	       if Num > 0 then
		  {Drone1 Note Num-1 Note|Acc} 
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
	    else nil
	    end
	 else nil
	 end
      end      
in
   {Drone1 Note Num nil}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fonction qui renvoye le nbr de note qu'il y a dans la partition en comptant les notes des accords et des transformations

declare
fun{Longueur Partition}
   fun{Longueur Partition Acc}
      case Partition
      of nil then Acc
      [] H|T then
	 if {IsNote H} then {Longueur T Acc+1}
	 elseif {IsExtendedNote H} then {Longueur T Acc+1}
	 elseif {IsChord H} then {Longueur T Acc+{Length H}}
	 elseif {IsExtendedChord H} then {Longueur T Acc+{Length H}}
	 else {Longueur H 0}+{Longueur T Acc}
	 end
      end
   end
in
   {Longueur Partition 0}
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%renvoye l'accord mis en argument avec chacunes des valeurs duration remplacée par la valeur NewDuration

declare
fun{ChangeChord NewDuration Chord}
   case Chord
   of nil then nil
   [] H|T then
      local X = {AdjoinAt H duration NewDuration}
      in X|{ChangeChord NewDuration T}
      end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Transpose l'ExtNote mise en argument d'un demi ton au dessus

declare
fun{SemiTransposeUp ExtNote}
   if (ExtNote.name == c orelse
       ExtNote.name == d orelse
       ExtNote.name == f orelse
       ExtNote.name == g orelse
       ExtNote.name == a) andthen ExtNote.sharp == false
   then {AdjoinAt ExtNote sharp true}
   elseif ExtNote.name == e then {AdjoinAt ExtNote name f}
   elseif ExtNote.name == b then
      {AdjoinList ExtNote [name#c octave#(ExtNote.octave+1)]}
   elseif ExtNote.name == c then {AdjoinList ExtNote [name#d sharp#false]}
   elseif ExtNote.name == d then {AdjoinList ExtNote [name#e sharp#false]}
   elseif ExtNote.name == f then {AdjoinList ExtNote [name#g sharp#false]}
   elseif ExtNote.name == g then {AdjoinList ExtNote [name#a sharp#false]}
   elseif ExtNote.name == a then {AdjoinList ExtNote [name#b sharp#false]}
   else ExtNote
   end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Transpose une ExtNote d'un demi ton vers le bas

declare
fun{SemiTransposeDown ExtNote}
   if(ExtNote.name == d andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#c sharp#true]}
   elseif (ExtNote.name == e andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#d sharp#true]}
   elseif (ExtNote.name == g andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#f sharp#true]}
   elseif (ExtNote.name == a andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#g sharp#true]}
   elseif (ExtNote.name == b andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#a sharp#true]}
      
   elseif (ExtNote.name == f andthen {Not ExtNote.sharp})  then
      {AdjoinAt ExtNote name e}
   elseif (ExtNote.name == c andthen {Not ExtNote.sharp}) then
      {AdjoinList ExtNote [name#b octave#(ExtNote.octave-1)]}
   elseif (ExtNote.name == c orelse
	   ExtNote.name == d orelse
	   ExtNote.name == f orelse
	   ExtNote.name == g orelse
	   ExtNote.name == a) andthen ExtNote.sharp
   then {AdjoinAt ExtNote sharp false}
   else ExtNote
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut

declare
fun{TransposeChordUp Ch}
   case Ch of nil then nil
   [] H|T then
      {SemiTransposeUp H}|{TransposeChordUp T}
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut

declare
fun{TransposeChordDown Ch}
   case Ch of nil then nil
   [] H|T then
      {SemiTransposeDown H}|{TransposeChordDown T}
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transpose l'item d'un demi ton vers le dessus si N>0 et vers le bas si N<0

declare
fun{SemiTransposeCase Num Item}
   if Num > 0 then
      if {IsNote Item} then
	 {SemiTransposeUp {NoteToExtended Item}}
      elseif {IsExtendedNote Item} then
	 {SemiTransposeUp Item}
      elseif {IsChord Item} then
	 {TransposeChordUp {ChordToExtended Item}}
      elseif {IsExtendedChord Item} then
	 {TransposeChordUp Item}
      else nil
      end
   elseif Num < 0 then
      if {IsNote Item} then
	 {SemiTransposeDown {NoteToExtended Item}}
      elseif {IsExtendedNote Item} then
	 {SemiTransposeDown Item}
      elseif {IsChord Item} then
	 {TransposeChordDown {ChordToExtended Item}}
      elseif {IsExtendedChord Item} then
	 {TransposeChordDown Item}
      else nil
      end
   else Item
   end
end
