% Tests the Algorithm for Pedestrian Paths
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)
% NOTE: CLEARS WORKSPACE!

clc
clear all
close all
load('PedestrianModel.mat');
addpath(genpath('./'));
I = im2double(imread('aerial_colorResized.jpg'));
disp('Welcome to Pedestrian Path Planner, Press Enter to continue....');
pause;

AllPathsPed = {};

while(true)
imshow(I);
title('Test Sample, Zoom into the required area and press Enter to continue....');
% Zoom to whatever extent and press enter
pause;
[xLocs,yLocs] = ginput(2);
TestPathLandMarks = [xLocs,yLocs];
hold on;
plot(TestPathLandMarks(1,1),TestPathLandMarks(1,2),'rp','MarkerSize', 20, 'MarkerFaceColor', 'r');
plot(TestPathLandMarks(2,1),TestPathLandMarks(2,2),'bp','MarkerSize', 20, 'MarkerFaceColor', 'b');
hold off;
title('Red is the start point, Blue is the goal point');
drawnow;

%% Compute the path
disp('Computing Path, Please Wait....');
% First get the cost-to-go
CostToGo = dijkstra_matrix(CostMap,ceil(TestPathLandMarks(2,2)),ceil(TestPathLandMarks(2,1)));
% Get the Dijkstra Path
[DijkstraX, DijkstraY] = dijkstra_path(CostToGo, CostMap, ceil(TestPathLandMarks(1,2)), ceil(TestPathLandMarks(1,1)));
DijkstraPath = [DijkstraY,DijkstraX];
% close all
imshow(I);
hold on;
PlotPaths({DijkstraPath}, {TestPathLandMarks}, {'r','r','r'});
title('Press Ctrl+C on command window to end, Enter to continue...');
AllPathsPed{end+1} = DijkstraPath;
pause;
end