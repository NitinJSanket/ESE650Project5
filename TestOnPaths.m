% Tests the Algorithm on a set of Paths
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)
clc
clear all
close all
addpath(genpath('./'));
I = im2double(imread('aerial_colorResized.jpg'));
load('CarModel.mat');
load('Path_10Good.mat');


%% Compute the path
AllPath = {};
disp('Computing Path, Please Wait....');
for i = 1:length(Path)
% First get the cost-to-go
CostToGo = dijkstra_matrix(CostMap,ceil(PathLandMarks{i}(2,2)),ceil(PathLandMarks{i}(2,1)));
% Get the Dijkstra Path
[DijkstraX, DijkstraY] = dijkstra_path(CostToGo, CostMap, ceil(PathLandMarks{i}(1,2)), ceil(PathLandMarks{i}(1,1)));
DijkstraPath = [DijkstraY,DijkstraX];
AllPath{end+1} = DijkstraPath;
imshow(I);
hold on;
title(i);
% pause;
drawnow;
end

imagesc(CostMap);
alpha(0.5);
PlotPaths(AllPath, PathLandMarks, {'r','r','r'});
PlotPaths(Path, PathLandMarks, {'b','b','b'});