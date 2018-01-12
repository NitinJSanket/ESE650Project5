% Used to handcraft the paths
clc
clear all
close all
warning off;

addpath(genpath('./'));
% Resize and save image to save space
% I = imread('aerial_color.jpg');
% I = imresize(I,0.25,'bicubic');
% imwrite(I,'aerial_colorResized.jpg');

%%
I = im2double(imread('aerial_colorResized.jpg'));
NumTrainPaths = 1;
Path = cell(NumTrainPaths,1);
figure,
for i = 1:NumTrainPaths
    MaskNow = zeros(size(I,1),size(I,2));
    imshow(I);
    title(['Sample ', num2str(i), ', Zoom into the required area and press Enter to continue....']);
    % Zoom to whatever extent and press enter
    pause;
    [xLocs,yLocs] = ginput;
    xBetweenAll = [];
    yBetweenAll = [];
    for j = 1:length(xLocs)-1
        [xBetween, yBetween] = getMapCellsFromRay(xLocs(j),yLocs(j), xLocs(j+1), yLocs(j+1));
        xBetweenAll = [xBetweenAll;xBetween];
        yBetweenAll = [yBetweenAll;yBetween];
    end
    Path{i} = [xBetweenAll,yBetweenAll];
    PathLandMarks{i} = [xLocs,yLocs];
    hold on;
    plot(Path{i}(:,1),Path{i}(:,2),'r.');
    hold off;
    title('Press Enter to continue....');
    pause;
end

% save('WalkingPath.mat','Path','PathLandMarks');

%% Plot the paths to verify
figure,
imshow(I);
PlotPaths(Path, PathLandMarks, {'r','g','b'});