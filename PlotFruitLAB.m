
%% Plot colors for each experiment in CIELAB (L, a plane, and L, b plane)

figure (3)
clf
subplot(2,2,1)
    PlotAssocLab(color_CS, UW58.Lab, FruitAssoc, 'Cantaloupe', cInd, 2,3)
subplot(2,2,2)
    PlotAssocLab(color_CS, UW58.Lab, FruitAssoc, 'Strawberry', sInd, 2,3)
subplot(2,2,3)
    PlotAssocLab(color_CS, UW58.Lab, FruitAssoc, 'Cantaloupe', cInd, 2,1)
subplot(2,2,4)
    PlotAssocLab(color_CS, UW58.Lab, FruitAssoc, 'Strawberry', sInd, 2,1)
    
    
figure(4)
clf
subplot(2,2,1)
    PlotAssocLab(color_MW, UW58.Lab, FruitAssoc, 'Mango', mInd, 2,3)
subplot(2,2,2)
    PlotAssocLab(color_MW, UW58.Lab, FruitAssoc, 'Watermelon', wInd, 2,3)
subplot(2,2,3)
    PlotAssocLab(color_MW, UW58.Lab, FruitAssoc, 'Mango', mInd, 2,1)
subplot(2,2,4)
    PlotAssocLab(color_MW, UW58.Lab, FruitAssoc, 'Watermelon', wInd, 2,1)   
    
    
%% PlotAssocLab plots colors for each experiment in CIELAB space
     
function PlotAssocLab(Colors, AllColors, FruitAssoc, fruitName, fruitInd, x, y)

    numColor = length(Colors);

    LabSubset = AllColors(Colors,:);
    rgbSubset = lab2rgb(LabSubset);
    
    Ratings = mean(FruitAssoc,3)';
    rateSubset = Ratings(fruitInd, Colors);

    dims = {'L*', 'a*', 'b*'};
    for i = 1:numColor
        
       hold on
       
       %plot coordiantes with mark size relative to associations strengths
       plot(LabSubset(i,x), LabSubset(i,y), 'MarkerSize', rateSubset(i)*10 +3, 'Marker', 'o',...
            'MarkerFaceColor',rgbSubset(i,:),'MarkerEdgeColor', 'none');
        
        xlabel(dims{x})
        ylabel(dims{y}) 
        
        title(fruitName)
        
        xlim([-100 100])
        ylim([-100 100])
        
        set(get(gca,'ylabel'),'rotation',0, 'VerticalAlignment','middle')
        daspect([1 1 1])   
    end
end



