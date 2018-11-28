% Prend un Note Item en argument. L'augmente de Num demi-
% tons si Num est positif. Le diminue de Num demi-tons
% si Num est négatif.

%Nécessite: SemiTransposeCase

declare
fun{TransposeCase Num Item}
   if Num==0 then Item
   elseif Num > 0 then
      {TransposeCase Num-1 {SemiTransposeCase 1 Item}}
   else {TransposeCase Num+1 {SemiTransposeCase ~1 Item}}
   end
end

%Test
declare
{Browse {TransposeCase ~2 a}}
{Browse {TransposeCase ~2 c}}
{Browse {TransposeCase 5 a}}
