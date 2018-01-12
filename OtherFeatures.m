clc
clear all
close all

I = im2double(imread('aerial_colorResized.jpg'));

%% K-Means Clustering
% NumClusters = 10;
% Lab = rgb2lab(I);
% L = Lab(:,:,1);
% A = Lab(:,:,2);
% B = Lab(:,:,3);
% L = L(:); 
% A = A(:); 
% B = B(:);
% [KMeansIdx,KMeansC] = kmeans([A,B], NumClusters);
% imagesc(reshape(KMeansIdx,size(Lab(:,:,1))));
% axis equal
% saveas(gcf,'KMeans.jpg');

%% GMM
NumClusters = 10;
Lab = rgb2lab(I);
L = Lab(:,:,1);
A = Lab(:,:,2);
B = Lab(:,:,3);
L = L(:); 
A = A(:); 
B = B(:);
GMMModel = gmdistribution.fit([A(:),B(:)],NumClusters,'Regularize',1e-4,'Replicates',1,'Options',statset('Display','final','MaxIter',500));
GMMPosterior = posterior(GMMModel,[A(:),B(:)]);
imagesc(reshape(GMMPosterior(:,1),size(Lab(:,:,1))));
axis equal
saveas(gcf,'GMM.jpg');

%% Eucledian-Distance
[ED, BW, ~] = BottomBuildingED(I);
imagesc([ED,BW]);
axis equal;
saveas(gcf,'ED.jpg');

%% RGB Color Diagonal
RGBED = sqrt(((I(:,:,1)-I(:,:,2)).^2 +...
    (I(:,:,1)-I(:,:,3)).^2 +...
    (I(:,:,2)-I(:,:,3)).^2)/3);
imagesc(RGBED);
axis equal
saveas(gcf,'RGBED.jpg');

%% Std
Std = stdfilt(I);
imagesc(Std);
axis equal
saveas(gcf,'Std.jpg');

%% Entropy
Ent = entropyfilt(rgb2gray(I));
imagesc(Ent);
axis equal
saveas(gcf,'Ent.jpg');

%% Range
Range = rangefilt(I);
imagesc(Range);
axis equal
saveas(gcf,'Range.jpg');

%% Gradient
[Gmag,Gdir] = imgradient(rgb2gray(I));
imagesc([Gdir]);
axis equal
saveas(gcf,'GradientDir.jpg');

%% SWT
[cA, cH, cV, cD] = swt2(rgb2gray(I(1:1304,1:3004,:)),1,'haar');
cAHVD = [cA;cH;cV;cD];
imagesc(cD);
axis equal
saveas(gcf,'SWTcD.jpg');

%% DCT
NumBlocks = 50;
D = dct2(rgb2gray(I));
D1 = zeros(size(D));
D1(1:NumBlocks,1:NumBlocks) = D(1:NumBlocks,1:NumBlocks);
D = idct2(D1);
imagesc(D);
axis equal
saveas(gcf,'DCT.jpg');

