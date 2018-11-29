% Prend un Extended chord en argument et verifie s'il s'agit bien d'un Extended
% chord en renvoyant true si c'est le cas et false sinon. Le cas où le chord
% est nil renvoit true

%Nécessite : /

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

% Test:

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
ExtNote12=silence(duration:3.0)
ExtNote13=silence(name:a)

declare
ExtChord1=[ExtNote1 ExtNote4 ExtNote2]
ExtChord2=[ExtNote2 ExtNote12]
ExtChord3=nil
ExtChord4=[ExtNote3 ExtNote10]
ExtChord5=[ExtNote3 a]
ExtChord=[ExtNote1 ExtNote13]

%doit renvoyer true
{Browse {IsExtendedChord ExtChord1}}
{Browse {IsExtendedChord ExtChord2}}
{Browse {IsExtendedChord ExtChord3}}

%doit renvoyer false
{Browse {IsExtendedChord ExtChord4}}
{Browse {IsExtendedChord ExtChord5}}
