function [Wts,WtsAll] = GradientDescent(F, Path, PathLandMarks, LearningRate, ConvergenceThld, MinValue, MaxIter, Wts, I)
% Runs gradient descent on feature maps
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

if(nargin<9)
    % All features have equal weights
    Wts = (1/size(Path,3))*ones(size(Path,3),1);
    if(nargin<8)
        MaxIter = 100;
        if(nargin<7)
            ConvergenceThld = 1e-5;
            if(nargin<6)
                LearningRate = 1e-4;
                if(nargin<5)
                    MinValue = 0.02;
                end
            end
        end
    end
end

NumFeat = size(F,3);
NumPaths = length(Path);
LinearIndPEx = cell(length(Path),1);
WtsAll = zeros(NumFeat,MaxIter);
JPrev = 0;
JHist = zeros(MaxIter,1);
for i = 1:length(Path)
    LinearIndPEx{i} = sub2ind(size(F(:,:,1)),Path{i}(:,2),Path{i}(:,1));
end

for iter = 1:MaxIter
    tic
    J = 0;
    LinearIndPDijkstra = cell(length(Path),1);
    CostDijkstra = zeros(NumPaths,1);
    CostPEx = zeros(NumPaths,1);
    Gradient = zeros(NumPaths,NumFeat); % This is delJ/delFi
    CostMap = zeros(size(F(:,:,1)));
    DijkstraPath = cell(length(Path),1);
    % Generate cost map
    for i = 1:NumFeat
        CostMap = CostMap + F(:,:,i).*Wts(i);
    end
    CostMap = exp(CostMap);
    CostMap = (CostMap-min(min(CostMap)))+MinValue;
    for pathno = 1:NumPaths
        % Get the cost along the example path (hand-drawn)
        CostPEx(pathno) = sum(CostMap(LinearIndPEx{pathno}));
        % Run Dijkstra
        PathNow = PathLandMarks{pathno};
        PathStart = PathNow(1,:);
        PathEnd = PathNow(end,:);
        % First get the cost-to-go
        CostToGo = dijkstra_matrix(CostMap,ceil(PathEnd(2)),ceil(PathEnd(1)));
        % Get the Dijkstra Path
        [DijkstraX, DijkstraY] = dijkstra_path(CostToGo, CostMap, ceil(PathStart(2)), ceil(PathStart(1)));
        DijkstraPath{pathno} = [DijkstraY,DijkstraX];
        % Convert to linear indexes to obtain cost along the path
        LinearIndPDijkstra{pathno} = sub2ind(size(F(:,:,1)),DijkstraX,DijkstraY);
        % Get the cost along the dijkstra path
        CostDijkstra(pathno) = sum(CostMap(LinearIndPDijkstra{pathno}));
        for feature = 1:NumFeat
            FeatNow = CostMap.*F(:,:,feature);
            % Compute the gradient per path
            Gradient(pathno,feature) = sum(FeatNow(LinearIndPEx{pathno})) - sum(FeatNow(LinearIndPDijkstra{pathno}));
        end
        J =  J + CostPEx(pathno) - CostDijkstra(pathno);
    end
    
    % Take Mean for all paths
    Gradient = mean(Gradient,1);
    
    % Now update your weights
    Wts = Wts - Gradient'.*LearningRate;
    WtsAll(:,iter) = Wts;
    JHist(iter) = J;
    
    imshow(I);
    hold on;
    imagesc(CostMap);
    colorbar;
    alpha(0.5);
    hold off;
    PlotPaths(Path, PathLandMarks, {'r','r','r'});
    PlotPaths(DijkstraPath, PathLandMarks, {'b','b','b'})
    title(iter);
    drawnow;
    
    disp(['Difference between current and previous iteration objective function value: ', num2str(abs(J-JPrev))]);
    disp(['Current Objective Function value: ', num2str(J)]);
    disp('Current Weights are');
    disp(Wts);
    toc
    disp('--------------------------------------------------------------');
    
    % Convergence test
    if(abs(J-JPrev)<=ConvergenceThld)
        disp(['Convergence Criterion reached in ', num2str(iter), ' number of iterations...']);
        break;
    end
    % Reached maximum number of iterations
    if(iter==MaxIter)
        disp(['Reached ', num2str(MaxIter), ' (maximum) number of iterations, terminating...']);
    end
    JPrev = J;
end
end