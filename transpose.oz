% renvoye une partition qui a ete augmentée d'une certain nombre (Num) de demi tons

declare
fun{Transpose Num Part}
   case Part
   of nil then nil
   [] H|T then
      {TransposeCase Num H}|{Transpose Num T}
   end
end

