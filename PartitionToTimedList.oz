% Convertit une partition en flat partition %
% 19/11 10h15 ne marche que pour des notes %

declare
fun{PartitionToTimedList Part}
   case Part of nil then nil
   [] H|T then
      {NoteToExtended H}|{Convert T}
   end
end