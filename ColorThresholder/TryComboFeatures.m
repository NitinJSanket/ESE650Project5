clc
clear all
close all
warning off;

% Try to combine features
I = im2double(imread('../aerial_colorResized.jpg'));
addpath(genpath('../'));
[F(:,:,1),~] = BrightRoofsYCbCr(I);
[F(:,:,2),~] = DarkShadowsYCbCr(I);
[F(:,:,3),~] = GreenAndGrayRoofsYCbCr(I);
[F(:,:,4),~] = GreenYCbCr(I);
[F(:,:,5),~] = RedYCbCr(I);
[F(:,:,6),~] = RoadAndRoofs(I);
[F(:,:,7),~] = BottomBuilding(I);
[F(:,:,8),~] = BrightBuildings(I);
[F(:,:,9),~] = DarkRoofs(I);
[F(:,:,10),~] = MediumRoofs(I);
[F(:,:,11),~] = TennisCoursAndRoofs(I);
[F(:,:,12),~] = WierdBuildings(I);


for i = 1:size(F,3)
   F(:,:,i) = F(:,:,i).*rgb2gray(I); 
end


Z = sum(F,3);
% 
% % DispFeatures(F);
% 
% for i = 1:size(F,3)
%    F(:,:,i) = bwmorph(F(:,:,i),'clean');
% %    F(:,:,i) = imdilate(A, strel('disk',2));
% %    imshow([F(:,:,i);A]);
% %    pause;
% end
% 
% MaskOfShittyStuff = F(:,:,1)| F(:,:,2)|F(:,:,3)|F(:,:,4)|F(:,:,5)|F(:,:,7)|F(:,:,8)|F(:,:,9)|F(:,:,10)|F(:,:,11)|F(:,:,12);
% maskedRGBImage = I;
% maskedRGBImage(repmat(~MaskOfShittyStuff,[1 1 3])) = 0;
% imshow(maskedRGBImage);
% for i = 1:size(F,3)
% maskedRGBImage = I;
% maskedRGBImage(repmat(~F(:,:,i),[1 1 3])) = 0;
% imshow(maskedRGBImage);
% pause;
% end

%%
% L = bwlabel(F(:,:,6));
% imagesc(L);
% Stats = regionprops(L,'All');
% %%
% KeepIdxs = find([Stats.Area] >= 30 & [Stats.Eccentricity] <= 0.98 & [Stats.Solidity] >= 0.2); 
% Buildings = ismember(L, KeepIdxs);  
% % imshow(Buildings);
% 
% Buildings = imgaussfilt(im2double(Buildings), 5);
% imagesc(Buildings);
% %% Combine
% % Buildings = Buildings | MaskOfShittyStuff;
% maskedRGBImage = I;
% maskedRGBImage(repmat(~Buildings,[1 1 3])) = 0;
% imshow(maskedRGBImage);
% 
