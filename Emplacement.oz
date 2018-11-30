declare
Note = silence(duration:3.0)
{Browse {Label Note}==silence }
{Browse 1/2}
declare
fun{Emplacement Note}
   if (Note.octave < 4) then ~1
   elseif (Note.octave > 4) then 1
   elseif
     (Note.name == c orelse
      Note.name == d orelse
      Note.name == e orelse
      Note.name == f orelse
      Note.name == g orelse) then ~1
   elseif ((Note.name == a andthen Note.sharp == true) orelse
       Note.name == b) then 1
   else 0
   end
end

%Test
%Renvoye 1
declare
ExtNote1 = note(name:a octave:4 sharp:true duration:2.0 instrument:none)
ExtNote2 = note(name:b octave:4 sharp:false duration:2.0 instrument:none)
ExtNote3 = note(name:c octave:5 sharp:false duration:2.0 instrument:none)
ExtNote4 = note(name:d octave:6 sharp:true duration:2.0 instrument:none)
ExtNote5 = note(name:e octave:5 sharp:false duration:2.0 instrument:none)
{Browse {Emplacement ExtNote1}}
{Browse {Emplacement ExtNote2}}
{Browse {Emplacement ExtNote3}}
{Browse {Emplacement ExtNote4}}
{Browse {Emplacement ExtNote5}}

ExtNote6 = note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote7 = note(name:d octave:3 sharp:false duration:2.0 instrument:none)
ExtNote8 = note(name:e octave:3 sharp:false duration:2.0 instrument:none)
ExtNote9 = note(name:f octave:3 sharp:true duration:2.0 instrument:none)
ExtNote10 = note(name:f octave:3 sharp:false duration:2.0 instrument:none)
ExtNote11 = note(name:g octave:3 sharp:true duration:2.0 instrument:none)
ExtNote12 = note(name:g octave:3 sharp:false duration:2.0 instrument:none)     
