local
   % See project statement for API details.
   [Project] = {Link ['Project2018.ozf']}
   Time = {Link ['x-oz://boot/Time']}.1.getReferenceTime


% Fonction qui prend en argument une note et vérifie si il s'agit
% bien d'une note en renvoyant true si oui et false sinon.
% Un silence renvoit true

%Nécessite les fonctions: /


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
   
% Renvoit true si l'argument est une ExtenededNote et False sinon
   
%Nécessite: /
   

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
		  then if (Note.name == e andthen Note.sharp) orelse (Note.name == b andthen Note.sharp)
		       then false
		       else true
		       end
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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un Extended chord en argument et verifie s'il s'agit bien d'un Extended
% chord en renvoyant true si c'est le cas et false sinon. Le cas où le chord
% est nil renvoit true

%Nécessite : /


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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% NoteToExtended modifié par nos soins pour prendre en compte un silence %
% Prend une note en argument et renvoit la extended note correspondante %
% Necessite les fcts : /
   


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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transforme un accord (liste de notes) en un accord etendu (une liste de note
% étendues)
% Necessite : NoteToExtended


   fun{ChordToExtended Chord}
      case Chord
      of nil then nil
      [] H|T then {NoteToExtended H}|{ChordToExtended T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un argument Note et un nombre Num
% renoit une liste qui comprends Num fois Note
% Si Note est une note, la fonction renvoit une liste de note
% Si Note est une extended note, la fonction
% renvoit une liste d'extended note
% Si note est quoi que ce soit d'autre, renvoit nil

% Nécessite: IsNote NoteToExtended IsExtendedNote IsChord ChordToExtended IsExtendedChord


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
	 elseif {IsChord Note} then
	    if{IsInt Num} then
	       if Num > 0 then
		  {Drone1 {ChordToExtended Note} Num-1 {ChordToExtended Note}|Acc}
	       else Acc
	       end
	    else Acc
	    end
	 elseif {IsExtendedChord Note} then
	    if{IsInt Num} then
	       if Num >0 then
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fonction qui renvoye le nbr de note qu'il y a dans la partition en comptant les notes des accords et des transformations
% Necessite : IsNote, IsExtendedNote, IsChord, IsExtendedChord


   fun{Longueur Partition}
      fun{Longueur Partition Acc}
	 case Partition
	 of nil then Acc
	 [] H|T then
	    if {IsNote H} then {Longueur T Acc+1}
	    elseif {IsExtendedNote H} then {Longueur T Acc+1}
	    elseif {IsChord H} then {Longueur T Acc+{Length H}}
	    elseif {IsExtendedChord H} then {Longueur T Acc+{Length H}}
	    end
	 end
      end
   in
      {Longueur Partition 0}
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renvoye l'accord mis en argument avec chacunes des valeurs duration remplacée par la valeur NewDuration
% ATTENTION le chord mis en argument est un ExtendedChord et la NewDuration est un Float
% Necessite: /


   fun{ChangeChord NewDuration Chord}
      case Chord
      of nil then nil
      [] H|T then
	 local X = {AdjoinAt H duration NewDuration}
	 in X|{ChangeChord NewDuration T}
	 end
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoye une partition ou les durées de chaque note sont remplacées par la durée NbrSec mise en argument divisée 
%par le nombre total de note qu'il y a dans la partition. 
%ATTENTION :  L'argument NbrSec est un Float
% Necessite : Longueur, ChangeChord, IsNote, IsExtendedNote, IsChord, IsExtendedChord, NoteToExtended, ChordToExtended


   fun{Duration NbrSec Partition}
      local
	 NbrNote = {Longueur Partition}
	 NewDuration = NbrSec/{IntToFloat NbrNote}
      in
	 local 
	    fun{Duration1 Partition NewDuration}
	       case Partition
	       of nil then nil
	       []H|T then
		  if {IsNote H} then
		     local H1 in
			H1={NoteToExtended H}
			local X = {AdjoinAt H1 duration NewDuration}
			in X|{Duration1 T NewDuration}
			end
		     end
		  elseif {IsChord H} then
		     local H1 in
			H1 = {ChordToExtended H}
			{ChangeChord NewDuration H1}|{Duration1 T NewDuration}
		     end 
		  elseif {IsExtendedNote H} then 
		     local
			X = {AdjoinAt H duration NewDuration}
		     in X|{Duration1 T NewDuration}
		     end
		  elseif {IsExtendedChord H} then
		     {ChangeChord NewDuration H}|{Duration1 T NewDuration}
		  else H|{Duration1 T NewDuration}
		  end
	       else nil
	       end
	    end
	 in
	    {Duration1 Partition NewDuration}
	 end 
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Renvoit un Extended Chord dont on a Multiplie la duration de
% chaque Extended Note par le facteur F
% Nécessité: /


   fun{MultChord F Chord}
      case Chord
      of nil then nil
      [] H|T then
	 local X = {AdjoinAt H duration F*H.duration}
	 in X|{MultChord F T}
	 end
      end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% transformation Stretch qui allonge la partition P en argument
% par le facteurF en multipliant chaque partitionItem par F
% Necessité : IsNote, NoteToExtended, IsExtendedNote, IsChord, ChordToExtended, IsExtendedChord, MultChord


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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Transpose l'ExtNote mise en argument d'un demi ton au dessus
%Cette fonction ne contrÃ´le pas si l'argument est correct, car
%cette fonctionsera utilsÃ©e dans un cas oÃ¹ on est sÃ»r que
%l'entrÃ©e en argument est correct

%NÃ©cessite: /


   fun{SemiTransposeUp ExtNote}
      case ExtNote of silence(duration:Dur) then
	 ExtNote
      else
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
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
%Transpose une ExtNote d'un demi ton vers le bas
   
% NÃ©cessite: /


   fun{SemiTransposeDown ExtNote}
      case ExtNote of silence(duration:Dur) then
	 ExtNote
      else
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
		 ExtNote.name == a) andthen ExtNote.sharp then
	    {AdjoinAt ExtNote sharp false}
	 else ExtNote
	 end
      end	 
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut
%Necessité : SemiTransposeUp


   fun{TransposeChordUp Ch}
      case Ch of nil then nil
      [] H|T then
	 {SemiTransposeUp H}|{TransposeChordUp T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transpose toutes les Extended notes contenues dans
%le Extended Chord pris en argument d'un demi ton
% vers le haut

%Nécessite: SemiTransposeDown

   
   fun{TransposeChordDown Ch}
      case Ch of nil then nil
      [] H|T then
	 {SemiTransposeDown H}|{TransposeChordDown T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transpose l'item d'un demi ton vers le dessus si N>0 et vers le bas si N<0
%NecessitÃ© : IsNote, NoteToExtended, IsExtendedNote, IsChord, ChordToExtended, IsExtendedChord, TransposeChordUp, TransposeChordDown,
% SemiTransposeUp, SempiTransposeDown

   
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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Prend un Note Item en argument. L'augmente de Num demi-
% tons si Num est positif. Le diminue de Num demi-tons
% si Num est négatif.

%Nécessite: SemiTransposeCase


   fun{TransposeCase Num Item}
      if Num==0 then Item
      elseif Num > 0 then
	 {TransposeCase Num-1 {SemiTransposeCase 1 Item}}
      else {TransposeCase Num+1 {SemiTransposeCase ~1 Item}}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renvoye une partition qui a ete augmentée/diminuée d'une certain nombre (Num) de demi tons
% Necessite : TransposeCase


   fun{Transpose Num Part}
      case Part
      of nil then nil
      [] H|T then
	 {TransposeCase Num H}|{Transpose Num T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Renvoit une flat partition qui est issue de la partition en argument

% Nécessite: IsNote NoteToExtended IsChord ChordToExtended 
%          IsExtendedNote IsExtendedChord Duration Drone
%	   Stretch Transpose


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
	 else
	    case H of duration(seconds:Dur Part) then
	       {Append {Duration Dur {PartitionToTimedList Part}} {PartitionToTimedList T}}
	    [] drone(note:Item amount:N) then
	       {Append {Drone Item N} {PartitionToTimedList T}}
	    [] stretch(factor:Fac Part) then
	       {Append {Stretch Fac {PartitionToTimedList Part}} {PartitionToTimedList T}}
	    [] transpose(semitones:N Part) then
	       {Append {Transpose N {PartitionToTimedList Part}} {PartitionToTimedList T}}	    
	    end
	 end
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoye 1 si la note est au dessus de A4 -1 si c'est en dessus et 0 si c'est un silence ou A4
%Necessite : /
   

   fun{Emplacement Note}
      case Note of note(name:N octave:O sharp:S duration:D instrument:I) then 
	 if (O < 4) then ~1
	 elseif (O > 4) then 1
	 elseif
	    (N == c orelse
	     N == d orelse
	     N == e orelse
	     N == f orelse
	     N == g) then ~1
	 elseif ((N == a andthen S == true) orelse
		 N == b) then 1
	 else 0
	 end
      else 0
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoye la haute d'une note etendue
%Necessite : Emplacement, SemiTransposeUp, SemiTransposeDown


   fun{Hauteur Note}
      fun{HauteurAcc Note Acc}
	 if {Emplacement Note} == 0 then Acc
	 elseif {Emplacement Note} < 0 then {HauteurAcc {SemiTransposeUp Note} Acc-1}
	 else  {HauteurAcc {SemiTransposeDown Note} Acc+1}
	 end
      end
   in
      {HauteurAcc Note 0}
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Renvoye la frequence de la note selon la formule donnée dans l'enoncé
% Necessite : Hauteur 

   fun{Frequence Note}
      case Note of note(name:Name octave:Oct sharp:Sharp duration:Dur instrument:Inst) then
	 local H in
	    H={IntToFloat {Hauteur Note}}
	    {Pow 2.0 H/12.0}*440.0
	 end
      [] silence(duration:Dur) then 0.0
      else 0.0
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Prends une note en argument et renvoit le samples correspondants
%Le nombre de samples est défini par le produit de la duration de
%la note avec 44100. Dans le cas où ce produit ne donne pas un
%nombre entier (par exemple dans le cas de note.duration=0.0001)
%la fonction arrondi le nombre de sample grâce à la fonction
%FloatToInt

%Nécessite: Frequence


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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Transforme chaque note de l'accord en Sample liste de samples correspondant
%à chaque note dans l'accord
%Necessite : NoteToSample


   fun{ChordToSamples Chord}
      case Chord
      of nil then nil
      [] H|T then {NoteToSample H}|{ChordToSamples T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
%Additionne 2 listes Ã©lÃ©ments par Ã©lÃ©ments et renvoye une liste avec les sommes. Si les deux listes ne sont pas de mÃªme longeurs, le debut 
%de la liste renvoyÃ©e sera la somme des deux listes et losrsque la liste la plus courte est finie, on place les elements de la liste la plus
%longue (ex : si L1 = [1 2] et L2 = [1 2 3 4] le debut de la liste renvoyÃ©e sera [2 4 et la suite sera 3 4] )
%Necessite : /


   fun{Add2Listes L1 L2}
      case L1#L2
      of nil#nil then nil
      [] (H1|T1)#(H2|T2) then (H1+H2)|{Add2Listes T1 T2}
      [] nil#(H2|T2) then H2|{Add2Listes nil T2}
      [] (H1|T1)#nil then H1|{Add2Listes T1 nil}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Additionne les samples qui se trouvent dans le chord. Si les listes de samples ne sont pas de meme longueurs, on suit le 
%processus de Add2Listes car on complete la liste la plus courte par des silences dont l'intensitÃ© vaut 0.
%Necessite :  Add2Listes 


   fun{ChordToOneSample Chord}
      case Chord
      of nil then nil
      [] H|nil then H
      [] H1|H2|T then {ChordToOneSample {Add2Listes H1 H2}|T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%prend en argument une partiton et renvoit la liste de sample correspondant

%Nécessite: IsExtendedNote NoteToSample ChordToOneSample


   fun{PartitionToSamples Partition}
      case  Partition of nil then nil
      [] H|T then
	 if {IsExtendedNote H} then
	    {NoteToSample H}|{PartitionToSamples T}
	 else {ChordToOneSample {ChordToSamples H}}|{PartitionToSamples T}
	 end
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Prend un nom de fichier en argument et renvoit le contenu de celui-ci. En principe le contenu de ce fichier doit être
%de la forme d'une liste d'échantillon

   fun{Wave FileName}
      {Project.Load FileName}
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% Ces deux fonctions sont fort semblables. Elles prennent toutes deux une liste de tuples (de type Fact#Music) en argument en renvoyent une lise composées des facteurs (pour la fonction ListFact) et une liste de Music (pour la fonction ListMusic)
%Necessite : /

   fun{ListFact List}
      if List == nil then nil
      else case List.1
	   of Fact#Music then
	      Fact|{ListFact List.2}
	   end
      end
   end
   fun{ListMusic List}
      if List == nil then nil
      else case List.1
	   of Fact#Music then
	      Music|{ListMusic List.2}
	   end
      end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   %Prends deux listes de float en argument et renvoye une liste dont chaque élément n_ème élément est le resultatde la multiplication du n_éme éléments de LFac et de LMus
%Necessite : /

   fun{Merge LFac LMus}
      case LFac#LMus
      of nil#nil then nil
      [] (HFac|TFac)#(HMus|TMus) then
	 {Map HMus fun{$ X} X*HFac end}|{Merge TFac TMus}
      end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Renvoye la liste Music dont les valeurs sont comprises entre Low et High. Dans le cas ou c'est au dessus ou en dessous de ces valeurs, renvoye soit Low Soit High
%Necessite : /
   
   fun{Clip Low High Music}
      if Low>=High then nil
      else
	 case Music
	 of nil then nil
	 [] H|T then
	    if (H=<High andthen H>=Low) then H|{Clip Low High T}
	    elseif H>High then High|{Clip Low High T}
	    else Low|{Clip Low High T}
	    end
	 end
      end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   %Renvoye un merge qui contient la musique (Music) avec un facteur de 1.0 et l'autre élément est l'echo.
%Le fonction Listede0 renvoye une liste de D 0
   
%Necessite : /


   fun{Echo Delay Factor Music}
      fun{ListeDe0 Delay Acc}
	 if Delay == 0 then Acc
	 else {ListeDe0 Delay-1 0.|Acc}
	 end
      end
   in
      [merge([1.0#Music Factor#{Flatten samples({ListeDe0 {FloatToInt Delay*44100.0} nil})|Music}])]
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   %prend en argument une liste de samples et une duration (en Float) et répète les samples dans musique
%pendant la duration indiquée

%Nécessite: /


   fun{Loop Duration Musique}
      fun{LoopTemp D Mus Acc}
	 if D==0 then Acc
	 else case Mus of nil then
		 {LoopTemp D Musique Acc}
	      [] H|T then
		 {LoopTemp D-1 T H|Acc}
	      end
	 end
      end
   in
      {Reverse {LoopTemp {FloatToInt 44100.0*Duration} Musique nil}}
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   %Renvoye une liste avec N fois l'élément Music dedans
%Necessite : /


   fun{Repeat N Music}
      fun{Repeat N Music Acc}
	 if N == 0 then Acc
	 else {Repeat N-1 Music Music|Acc}
	 end
      end
   in
      {Repeat N Music nil}
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoye Music avec les samples correspondants à Sec modifiés pour monter l'intesité lineairement durant ce nombre de seconde
%Necessite : /
   fun{Start1 Sec Music}
      local
	 NbrSample = {FloatToInt Sec*44100.0}
	 L1 = {List.take Music NbrSample+1}
	 Nbr = 1.0/{IntToFloat {Length L1}-1}
	 fun{ChangeLStart LStart Acc1 Acc2 Nbr}
	    case LStart
	    of nil then Acc1
	    [] H|nil then {ChangeLStart nil H*1.0|Acc1 Acc2 Nbr} 
	    [] H|T then {ChangeLStart T H*Acc2|Acc1 Acc2+Nbr Nbr}
	    end
	 end
      in
	 {Reverse {ChangeLStart L1 nil 0.0 Nbr}}
      end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoye Music avec les samples correspondants à Sec modifiés pour descendre l'intesité lineairement durant ce nombre de seconde
%Necessite : /
   fun{Out Sec Music}
      local
	 NbrSample = {FloatToInt Sec*44100.0}
	 L1 = {List.drop Music {Length Music}-NbrSample}
	 Nbr = 1.0/{IntToFloat {Length L1}}
	 fun{ChangeLOut LOut Acc1 Acc2 Nbr}
	    case LOut
	    of nil then Acc1 
	    [] H|T then {ChangeLOut T H*Acc2|Acc1 Acc2+Nbr Nbr}
	    end
	 end
      in
	 {ChangeLOut L1 nil 0.0 Nbr}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Renvoye une liste dont le debut et la fin sont graduels selon les durées DStart et DOut
%Necessite : Start1, Out
   fun{Fade DStart DOut Music}
      local
	 fun {Interval Xs N M}
	    case Xs
	    of nil then nil
	    [] H|T then {List.take {List.drop Xs N-1} M-N+1}
	    end
	 end
	 NbrSampleStart = {FloatToInt DStart*44100.0}
	 NbrSampleOut = {FloatToInt DOut*44100.0}
	 Linchange = {Interval Music NbrSampleStart+2 {Length Music}-NbrSampleOut}
      in
	 {Flatten {Start1 DStart Music}|Linchange|{Out DOut Music}}
      end
   end
   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%prend en argument une fonction et une musique et renvoit une liste
% sample correspondant à cette musique

%Nécessite: PartitionToTimedList



   fun{Mix Fun Music}
      case Music of nil then nil
      [] H|T then
	 case H of samples(Sam) then
	    {Flatten Sam|{Mix Fun T}}
	 [] partition(Part) then
	    {Flatten {PartitionToSamples {Fun Part}}|{Mix Fun T}}
	 [] wave(FileName) then
	    {Flatten {Wave FileName}|{Mix Fun T}}
	 [] merge(List) then
	    local
	       LFac = {ListFact List}
	       LMus = {ListMusic List}
	    in
	       {Flatten {ChordToOneSample {Merge LFac {Map LMus fun{$ X} {Mix Fun X} end}}}|{Mix Fun T}}
	    end
	 [] reverse(Musique) then
	    {Flatten {Reverse {Mix Fun Musique}}|{Mix Fun T}}
	 [] repeat(amount:N Music) then
	    {Flatten {Repeat N {Mix Fun Music}}|{Mix Fun T}}
	 [] loop(seconds:Dur Music) then
	    {Flatten {Loop Dur {Mix Fun Music}}|{Mix Fun T}}
	 [] clip(low:Low high:High Music) then
	    {Flatten {Clip Low High {Mix Fun Music}}|{Mix Fun T}}
	 [] echo(delay:Delay decay:Factor Music) then
	    {Flatten {Mix Fun {Echo Delay Factor Music}}|{Mix Fun T}}
	 [] cut(start:Start finish:Finish Music) then
	    {Flatten {List.take {List.drop {Mix Fun Music} {FloatToInt 44100.0*Start}-1} {FloatToInt 44100.0*(Finish-Start)}}|{Mix Fun T}}
	 [] fade(start:DStart out:DOut Music) then
	    %{Browse {Mix Fun Music}}
	    {Browse {Fade DStart DOut {Mix Fun Music}}}
	    {Flatten {Fade DStart DOut {Mix Fun Music}}|{Mix Fun T}}
	 else 4|{Mix Fun T}
	 end
      else 4
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
   Music = {Project.load 'Test_Mege.dj.oz'}
   Start

   % Uncomment next line to insert your tests.
   % \insert 'tests.oz'
   % !!! Remove this before submitting.
in
   Start = {Time}

   % Uncomment next line to run your tests.
   % {Test Mix PartitionToTimedList}

   % Add variables to this list to avoid "local variable used only once"
   % warnings.
   {ForAll [NoteToExtended Music] Wait}
   
   % Calls your code, prints the result and outputs the result to `out.wav`.
   % You don't need to modify this.
   {Browse {Project.run Mix PartitionToTimedList Music 'out.wav'}}
   
   % Shows the total time to run your code.
   {Browse {IntToFloat {Time}-Start} / 1000.0}

end
