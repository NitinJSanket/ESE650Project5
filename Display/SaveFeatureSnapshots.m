function SaveFeatureSnapshots(F)
% Displays feature maps
% Code by: Nitin J. Sanket (nitinsan@seas.upenn.edu)

figure,
for i = 1:size(F,3)
   imagesc(F(:,:,i));
   title(i);
   saveas(gcf, ['PF',num2str(i),'.jpg']);
end
end