% Renvoit un Extended Chord dont on a Multiplie la duration de
% chaque Extended Note par le facteur F
% Nécessité: /

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


%Test
declare 
ExtNote1 = note(name:a octave:6 sharp:true duration:4.0 instrument:none)
ExtNote2 = note(name:c octave:2 sharp:false duration:4.2 instrument:none)
ExtNote3 = note(name:g octave:3 sharp:true duration:1.5 instrument:none)
ExtNote4 = silence(duration:4.0)
ExtChord =[ExtNote1 ExtNote2 ExtNote3 ExtNote4]
ExtChord1 = [ExtNote4 ExtNote1]

{Browse {MultChord 3.0 ExtChord}}
{Browse {MultChord 2.0 ExtChord1}}
