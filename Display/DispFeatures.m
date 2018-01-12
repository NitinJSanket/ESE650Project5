function DispFeatures(F, Name)
% Displays feature maps
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

if(nargin<2)
   Name = cell(size(F,3),1); 
end
figure,
for i = 1:size(F,3)
   imagesc(F(:,:,i));
   title([num2str(i),' ', Name{i}]);
   pause;
end
end