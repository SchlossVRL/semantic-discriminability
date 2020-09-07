function [ObjAllAvg] = PlotAssoc(ObjData, Obj, AllColors)
%Plot color-object association bar graphs

%ObjData = (ObjData+200)/200;

n = size(ObjData,3);

%labels for x-axis
Nums = 1:58;
Numstr  = num2cell(Nums);
Names = cellfun(@num2str,Numstr,'un',0);


ClrsRGB = lab2rgb(AllColors);
ClrsRGB(27,:) = [1,1,1];
ObjAll = reshape(ObjData,58, n);

ObjAllAvg = mean(ObjAll,2);
ObjSEM = std(ObjAll')/sqrt(n);
[ObjRating ObjInd] = sort(ObjAllAvg(:,1)); 



hold on
for i  = 1:58

     
    bar(i, ObjRating(i), 'FaceColor', ClrsRGB(ObjInd(i),:), 'EdgeColor', 'none')
    ObjNames{i} = Names{ObjInd(i)};
    
    plot([i,i], [ObjRating(i) - ObjSEM(ObjInd(i)), ObjRating(i) + ObjSEM(ObjInd(i)) ], 'k')
    plot([i-.2,i+.2], [ObjRating(i) - ObjSEM(ObjInd(i)), ObjRating(i) - ObjSEM(ObjInd(i)) ], 'k')
    plot([i-.2,i+.2], [ObjRating(i) + ObjSEM(ObjInd(i)), ObjRating(i) + ObjSEM(ObjInd(i)) ], 'k')  
end

set(gca, 'XTickLabel',ObjNames,'XTick',[1:58], 'FontSize', 8.5)
set(gca, 'YTick',[0:.25:1], 'FontSize', 8.5)

title(Obj)
ylabel('Mean Rating')
xlabel('Color')
% ylim([-100,100])
ylim([0,1])
xlim([0 59])
grid on

ax = gca; 
ax.XTickLabelRotation = 90;
end


