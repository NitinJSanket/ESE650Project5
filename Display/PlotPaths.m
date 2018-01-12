function PlotPaths(Path, PathLandMarks, Color)
% Plots Paths given the cell array of paths
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

% Use drawnow in the main code
if(nargin<3)
    Color = {'r','r','r'};
end

for i = 1:length(Path)
    hold on;
    plot(Path{i}(:,1),Path{i}(:,2), [Color{1}, '.']);
    plot(PathLandMarks{i}(1,1),PathLandMarks{i}(1,2),[Color{2}, '.']);
    plot(PathLandMarks{i}(end,1),PathLandMarks{i}(end,2),[Color{3}, '.']);
end
end