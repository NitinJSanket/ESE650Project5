clc
clear all
close all
% load('CarModel.mat');
% load('PedestrianPathsTestSet.mat');
load('CarPathsTestSet.mat');
addpath(genpath('./'));
I = im2double(imread('aerial_colorResized.jpg'));

% KeepIdxs = [1,2,3,4,6];
% AllPaths = {AllPaths{KeepIdxs}};

Color = [1, 0.5, 0;
    1,	1,	 0;
    0,	1,	 0;
    1, 0.42, 0.71;
    0, 0,   1];

imshow(I);
hold on;
for i = 1:length(AllPaths)
    plot(AllPaths{i}(:,1),AllPaths{i}(:,2), '.','Color',Color(i,:));
end
% saveas(gcf, 'TestPathsPedestrain.jpg');
saveas(gcf, 'TestPathsCar.jpg');