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