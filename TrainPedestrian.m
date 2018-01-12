% Wrapper to train the Algorithm for Pedestrian Paths
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)
% NOTE: CLEARS WORKSPACE!

clc
clear all
close all
warning off;

disp('Training procedure for Pedestrian Path Planner....');
%% Load the necessary files
addpath(genpath('./'));
I = im2double(imread('aerial_colorResized.jpg'));
load('Path_10Good.mat');

disp(['Using ',num2str(length(Path)),' paths for training....']);

%% Extract the features
F = GetFeaturesPedestrian(im2double(I));
disp('Initialization Complete, Features are extracted....');

%% Try Running Dijksta
% Train
NumFeat = size(F,3);
NumPaths = length(Path);
CostMap = zeros(size(I(:,:,1)));
MinValue = 0.018;
Wts = (1/NumFeat).*ones(NumFeat,1);
for i = 1:NumFeat
    CostMap = CostMap + F(:,:,i).*Wts(i);
end
CostMap = exp(CostMap);
CostMap = (CostMap-min(min(CostMap)))+MinValue;
imagesc(CostMap);
drawnow;

disp('Training Procedure Started....');

LearningRate = 1e-3;    
ConvergenceThld = 0.1;
MaxIter = 100;
[Wts, WtsAll] = GradientDescent(F, Path, PathLandMarks, LearningRate, ConvergenceThld, MinValue, MaxIter, Wts, I);
CostMap = zeros(size(F(:,:,1)));
for i = 1:NumFeat
    CostMap = CostMap + F(:,:,i).*Wts(i);
end
CostMap = exp(CostMap);
CostMap = (CostMap-min(min(CostMap)))+MinValue;
save('PedestrianModel.mat','CostMap','WtsAll','Wts','F');
disp('Model saved as PedestrianModel.mat');