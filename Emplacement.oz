%Renvoye 1 si la note est au dessus de A4 -1 si c'est en dessus et 0 si c'est un silence ou A4
%Necessite : /
declare
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

%Test
%Renvoye 1
declare
ExtNote1 = note(name:a octave:4 sharp:true duration:2.0 instrument:none)
ExtNote2 = note(name:b octave:5 sharp:false duration:2.0 instrument:none)
ExtNote3 = note(name:b octave:6 sharp:false duration:2.0 instrument:none)
ExtNote4 = note(name:b octave:7 sharp:false duration:2.0 instrument:none)
{Browse {Emplacement ExtNote1}}
{Browse {Emplacement ExtNote2}}
{Browse {Emplacement ExtNote3}}
{Browse {Emplacement ExtNote4}}

%Renvoye -1
declare 
ExtNote5 = note(name:c octave:3 sharp:false duration:2.0 instrument:none)
ExtNote6 = note(name:d octave:3 sharp:true duration:2.0 instrument:none)
ExtNote7 = note(name:d octave:4 sharp:false duration:2.0 instrument:none)
ExtNote8 = note(name:g octave:4 sharp:true duration:2.0 instrument:none)
{Browse {Emplacement ExtNote5}}
{Browse {Emplacement ExtNote6}}
{Browse {Emplacement ExtNote7}}
{Browse {Emplacement ExtNote8}}

%Renvoye0
declare
ExtNote9 = silence(duration:4.0)
ExtNote10 = note(name:a octave:4 sharp:false duration:2.0 instrument:none)
{Browse {Emplacement ExtNote9}}
{Browse {Emplacement ExtNote10}}
