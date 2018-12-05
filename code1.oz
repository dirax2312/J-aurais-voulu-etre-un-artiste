% Projet d'informatique 2 - 2018
%	Debois Valentine 	NOMA: 46931700
%	Diriken Axel		NOMA: 33821700

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
local
   % See project statement for API details.
   [Project] = {Link ['Project2018.ozf']}
   Time = {Link ['x-oz://boot/Time']}.1.getReferenceTime

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renvoie true si A est une note, false sinon
% "silence" est considéré comme une note

%Entrée: A - pas de précision
%Nécessite: /


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
   
% renvoie true si Chord est un accord, false sinon

%Entrée: Chord - pas de précision
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
   
% Renvoie true si Note est une ExtendedNote et false sinon

%Entrée: Note - pas de précision	
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

% Renvoie true si Chord est un ExtendedChord et false sinon 
% Le cas où le Chord est nil renvoit true

%Entrée: Chord - pas de précision
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
   
% NoteToExtended modifié par nos soins pour prendre en compte un silence 
% Renvoie la ExtendedNote correspondante à Note

%Entrée: Note - format d'une note	
% Necessite: /
   


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

% Renvoie l'ExtendedChord correspondant à Chord
	
%Entrée: Chord - format d'un Chord
% Necessite : NoteToExtended


   fun{ChordToExtended Chord}
      case Chord
      of nil then nil
      [] H|T then {NoteToExtended H}|{ChordToExtended T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% renvoie une liste d'ExtendedNote qui comprend Num fois Note
% Si note est quoi que ce soit d'autre qu'une Note, 
% une ExtendedNote, un Chord ou un ExtendedChord, renvoit nil

%Entrée: Note - format d'une Note ou d'une ExtendedNote ou d'un Chord ou d'un ExtendedChord
% 	 Num - integer
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

% Renvoie le nombre de note qu'il y a dans Partition en comptant les notes des accords et des transformations

% Entrée: Partition - format d'une Partition
% Necessite : IsNote IsExtendedNote IsChord IsExtendedChord


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

% renvoie l'accord mis en argument avec chacunes des valeurs duration remplacées par la valeur NewDuration
	
%Entrée: NewDuration - Float
%	 Chord - format d'un ExtendedChord
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

%Renvoie une partition où la durée de chaque note est remplacée par la durée NbrSec mise en argument divisée 
%par le nombre total de note qu'il y a dans la partition pour que NbrSec devienne la durée totale de la partition. 

%Entrée: NbrSec - Float
%	 Partition - format de Partition	
% Necessite : Longueur ChangeChord IsNote IsExtendedNote IsChord IsExtendedChord NoteToExtended ChordToExtended


   fun{Duration NbrSec Partition}
      local
	 NbrNote = {Longueur Partition}
	 NewDuration = NbrSec/{IntToFloat NbrNote}
      in
	 local 
	    fun{Duration1 Partition NewDuration}
	       case Partition
	       of nil then nil
	       [] H|T then
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

% Renvoie un Extended Chord dont on a multiplié la duration de
% chaque Extended Note par le facteur F
	
%Entrée: F - Float
% 	 Chord - format d'un Chord
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

% renvoie la partition P en argument, dont la durée est multipliée
% par le facteur F.
	
% Entrée : F - Float
%	   P - format d'une partition
% Nécessite : IsNote NoteToExtended IsExtendedNote IsChord ChordToExtended IsExtendedChord MultChord


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

%renvoie ExtNote transposée d'un demi ton vers le haut

%Entree: ExtNote - format d'ExtendedNote
%Necessite: /


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
   
%renvoie ExtNote transposee d'un demi to vers le bas
 
%Entree : ExtNote - format d'une ExtendedNote
% Necessite: /


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

% renvoie Ch dont toutes les notes ont été transposées d'un demi ton vers le haut
	
%Entree : Ch - format d'un ExtendedChord
%Necessité : SemiTransposeUp


   fun{TransposeChordUp Ch}
      case Ch of nil then nil
      [] H|T then
	 {SemiTransposeUp H}|{TransposeChordUp T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
% renvoie Ch dont toutes les notes ont été transposées d'un demi ton vers le bas
	
%Entree : Ch - format d'un ExtendedChord
%Necessité : SemiTransposeDown

   
   fun{TransposeChordDown Ch}
      case Ch of nil then nil
      [] H|T then
	 {SemiTransposeDown H}|{TransposeChordDown T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renvoie Item transposé d'un demi ton vers le haut si Num>0 et vers le bas si Num<0 
% renvoie Item si Num=0
	
%Entree : Num - Integer
%	  Item - format dune Note ou d'une ExtendedNote ou d'un Chord ou d'un ExtendedChord
%Necessite : IsNote, NoteToExtended, IsExtendedNote, IsChord, ChordToExtended, IsExtendedChord, TransposeChordUp, TransposeChordDown,
% SemiTransposeUp, SempiTransposeDown

   
   fun{SemiTransposeCase Num Item}
      if Num > 0 then
	 if {IsNote Item} then
	    {SemiTransposeUp {NoteToExtended Item}}
	 elseif {IsExtendedNote Item} then
	    {SemiTransposeUp Item}
	 elseif {IsChord Item} then
	    {TransposeChordUp {ChordToExtended Item}}
	 else {TransposeChordUp Item}
	 end
      elseif Num < 0 then
	 if {IsNote Item} then
	    {SemiTransposeDown {NoteToExtended Item}}
	 elseif {IsExtendedNote Item} then
	    {SemiTransposeDown Item}
	 elseif {IsChord Item} then
	    {TransposeChordDown {ChordToExtended Item}}
	 else {TransposeChordDown Item}
	 end
      else Item
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renvoie Item transposé de Num demi tons vers le haut si Num>0 et vers le bas si Num<0 
% renvoie Item si Num=0
	
%Entree : Num - Integer
%	  Item - format dune Note ou d'une ExtendedNote ou d'un Chord ou d'un ExtendedChord
%Necessite : SemiTransposeCase


   fun{TransposeCase Num Item}
      if Num==0 then Item
      elseif Num > 0 then
	 {TransposeCase Num-1 {SemiTransposeCase 1 Item}}
      else {TransposeCase Num+1 {SemiTransposeCase ~1 Item}}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renvoie Part dont tous les items ont été transposés de Num demi tons vers le haut si Num>0 et vers le bas si Num<0 
% renvoie Item si Num=0
	
%Entree : Num - Integer
%	  Part - format d'une partition
% Necessite : TransposeCase


   fun{Transpose Num Part}
      case Part
      of nil then nil
      [] H|T then
	 {TransposeCase Num H}|{Transpose Num T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Renvoie une flat partition qui est issue de Part en argument

% Entree : Part - format d'une Partition
% Nécessite: IsNote NoteToExtended IsChord ChordToExtended 
%            IsExtendedNote IsExtendedChord Duration Drone
%      	     Stretch Transpose


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

% Renvoie 1 si la note est au dessus de A4, -1 si elle est en dessous et 0 si c'est un silence ou A4
	
% Entrée : Note - format d'une Note
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

% Renvoie la hauteur d'une ExtendedNote; La hauteur est définie comme étant le nombre de demi tons
% qui sépare une note de la note A4
% Renvoie 0 si Note est un silence 

% Entrée : Note - format d'une ExtendedNote
% Necessite : Emplacement, SemiTransposeUp, SemiTransposeDown


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

% Renvoie la frequence de Note selon la formule donnée dans l'énoncé
% Renvoie 0 si Note est un silence
	
% Entrée : Note - format d'une ExtendedNote
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

% Renvoie la liste d'échantillons correspondante à Note.
% La longueur de la liste d'échantillons est définie par le produit de la duration de
% Note avec 44100.0.
	
% Entrée : Note - format d'une ExtendedNote
% Nécessite: Frequence


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

% Renvoie Chord dont chaque note est transformée en liste d'échantillons.
% Renvoie donc une liste de liste d'échantillons

% Entrée : chord - format d'un ExtendedChord
% Necessite : NoteToSample


   fun{ChordToSamples Chord}
      case Chord
      of nil then nil
      [] H|T then {NoteToSample H}|{ChordToSamples T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% Renvoie l'addition de 2 Listes éléments par éléments. Si les deux listes ne sont pas de mÃªme longeurs, la liste la plus courte
% complétées par des 0.

% Entrée : L1 - Liste
%   	   L2 - Liste
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

% Renvoie l'addition terme par terme des echantillons correspondants à chaque note de Chord 
% Les notes dont la durée est plus courte que la note dont la durée est la plus longue sont comblées par du silence

% Entrée : Chord - format de sortie de la fonction ChordToSamples (cfr plus haut)
% Necessite :  Add2Listes 


   fun{ChordToOneSample Chord}
      case Chord
      of nil then nil
      [] H|nil then H
      [] H1|H2|T then {ChordToOneSample {Add2Listes H1 H2}|T}
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%renvoit la liste d'échantillons correspondante à une partiton prise en argument   

%Entrée : Partition - format d'une Flat Partition
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
	
%renvoie le contenu du fichier FileName. En principe le contenu de ce fichier doit être
%de la forme d'une liste d'échantillons

%Entrée : FileName - atom de type 'Nom de fichier.wav'
%Necessite : /

   fun{Wave FileName}
      {Project.Load FileName}
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
% Ces deux fonctions sont fort semblables.
%renvoient une liste composées des facteurs (pour la fonction ListFact) et une liste de Music (pour la fonction ListMusic)


%Entree : List - liste de tuple de type Fact#Music
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

%renvoie une liste dont chaque n-ième élément est le resultat de la multiplication du n-iéme élément de LFac et de LMus
	
%Entree : LFac - Liste de Float
%	  LMus - Liste d'échantillons
%Necessite : /

   fun{Merge LFac LMus}
      case LFac#LMus
      of nil#nil then nil
      [] (HFac|TFac)#(HMus|TMus) then
	 {Map HMus fun{$ X} X*HFac end}|{Merge TFac TMus}
      end
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
%Renvoie la liste Music dont les valeurs sont comprises entre Low et High. Dans le cas ou un echantillon
%est supérieur à High renvoie High dans la cas ou un echantillon est inférieur à Low renvoie Low,
	
%Entree : Low - Float
%	  High - Float
%	  Musique - Liste d'échantillons
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

%Renvoie un merge qui contient Music muliplié par un facteur 1.0 et l'autre élément par Factor. Le deuxième élément est Music précédé
	%d'un silence dont la durée vaut Delay.
%Le fonction Listede0 renvoie une liste de longueur Delay remplie de zeros.
   
%Entree : Delay - Float
%	  Factor - Float
%	  Music - format d'une Music
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

%renvoie Musique en boucle pendant une durée Duration

%Entree : Duration - Float
%	  Musique - Liste d'échantillons
%Nécessite: /


   fun{Loop Duration Musique}
      fun{LoopAcc D Mus Acc}
	 if D==0 then Acc
	 else case Mus of nil then
		 {LoopAcc D Musique Acc}
	      [] H|T then
		 {LoopAcc D-1 T H|Acc}
	      end
	 end
      end
   in
      {Reverse {LoopAcc {FloatToInt 44100.0*Duration} Musique nil}}
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Renvoie une liste avec N fois Music
	
%Entree: N - Integer
%	 Music - Liste
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

%Renvoye Music avec le nombre d'echantillons correspondants à Sec modifiés pour monter l'intesité lineairement durant un temps de Sec

%Entree : Sec - Float
%	  Music - Liste d'echantillons
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

%Renvoie Music avec le nombre d'echantillons correspondants à Sec modifiés pour descendre l'intesité 
%lineairement durant un temps de Sec
	
%Entree : Sec - Float
%	  Music - Liste d'echantillons
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
% Renvoie une liste dont le debut et la fin sont graduels en intensite selon les durées DStart au debut et DOut a la fin
%Interval prend une liste Xs et renvoie la liste du N-ieme au M-ieme element inclus
	
%Entree : DStart - Float
%	  DOut - Float
%	  Music - Liste d'echantillons
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

%renvoie une liste d'echantillons correspondant à Music

%Entree : Fun - Fonction (PartitionToTimedList en principe)
%	  Music - format d'une Music
%Nécessite: PartitionToTimedList PartitionToSamples Wave ChordToOneSample Merge Repeat Loop Clip Echo Fade



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
