% Renvoit true si l'argument est une ExtenededNote et False sinon

%Nécessite: /

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

% Test
declare
ExtNote1=note(name:a octave:1 sharp:false duration:1.0 instrument:none)
ExtNote2=note(name:b octave:2 sharp:false duration:0.25 instrument:none)
ExtNote3=note(name:c octave:3 sharp:true duration: 5.0 instrument:none)
ExtNote4=note(name:d octave:4 sharp:false duration:3.0 instrument:none)
ExtNote5=note(name:e octave:5 sharp:false duration:1.0 instrument:none)
ExtNote6=note(name:f octave:6 sharp:true duration:2.0 instrument:none)
ExtNote7=note(name:g octave:7 sharp:true duration:5.0 instrument:none)
ExtNote8=note(name:e octave:7 sharp:true duration:5.0 instrument:none)
ExtNote9=note(name:b octave:7 sharp:true duration:5.0 instrument:none)
ExtNote10=note(name:h octave:7 sharp:true duration:5.0 instrument:none)
ExtNote11=note(name:g octave:7 sharp:true duration:5.0 instrument:none)

%doit renvoyer true
{Browse {IsExtendedNote ExtNote1}}
{Browse {IsExtendedNote ExtNote2}}
{Browse {IsExtendedNote ExtNote3}}
{Browse {IsExtendedNote ExtNote4}}
{Browse {IsExtendedNote ExtNote5}}
{Browse {IsExtendedNote ExtNote6}}
{Browse {IsExtendedNote ExtNote7}}

%doit renvoyer false
{Browse {IsExtendedNote ExtNote8}}
{Browse {IsExtendedNote ExtNote9}}
{Browse {IsExtendedNote ExtNote10}}
