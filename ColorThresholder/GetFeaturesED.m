function F = GetFeaturesED(I)
% Try to combine features
[D(:,:,1),~] = BrightRoofsYCbCr(I);
[D(:,:,2),~] = DarkShadowsYCbCr(I);
[D(:,:,3),~] = GreenAndGrayRoofsYCbCr(I);
[D(:,:,4),~] = GreenYCbCr(I);
[D(:,:,5),~] = RedYCbCr(I);
[D(:,:,6),~] = RoadAndRoofs(I);
[D(:,:,7),~] = BottomBuilding(I);
[D(:,:,8),~] = BrightBuildings(I);
[D(:,:,9),~] = DarkRoofs(I);
[D(:,:,10),~] = MediumRoofs(I);
[D(:,:,11),~] = TennisCoursAndRoofs(I);
[D(:,:,12),~] = WierdBuildings(I);
[D(:,:,13),~] = BrightRoofs(I);
[D(:,:,14),~] = DarkerBuildings(I);
[A,~] = Buildings2(I);
[B,~] = Buildings3(I);

L = bwlabel(D(:,:,14));
Stats = regionprops(logical(L),'All');
KeepIdxs = find([Stats.Area] >= 30 & [Stats.Eccentricity] <= 0.8 & [Stats.Solidity] >= 0.3);
D(:,:,14) = ismember(L, KeepIdxs);

for i = 1:size(D,3)
    if(i==6 || i==14)
        A = bwmorph(D(:,:,i),'clean');
    end
    F(:,:,i) = imgaussfilt(im2double(A), 2);
end

%% Try to get all the buildings
A = A|B|D(:,:,6);
L = bwlabel(A);
Stats = regionprops(logical(L),'All');

KeepIdxs = find([Stats.Area] >= 30 & [Stats.Eccentricity] <= 0.98 & [Stats.Solidity] >= 0.2);
Buildings = ismember(L, KeepIdxs);
F(:,:,end+1) = imgaussfilt(im2double(Buildings), 2);
end
