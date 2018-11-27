% Prend un Note Item en argument. L'augmente de Num demi-
% tons si Num est positif. Le diminue de Num demi-tons
% si Num est négatif.

declare
fun{TransposeCase1 Num Item}
   if Num==0 then Item
   elseif Num > 0 then
      {TransposeCase1 Num-1 {SemiTransposeCase 1 Item}}
   else {TransposeCase1 Num+1 {SemiTransposeCase ~1 Item}}
   end
end
