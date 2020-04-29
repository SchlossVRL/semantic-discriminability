








cInd = 4;
sInd = 6;
mInd = 1;
wInd = 2;

figure (1)
clf
subplot(2,2,1)
    PlotAssocLab(color_CS, UW58.Lab, Ratings, 'Cantaloupe', cInd, 2, 3)
subplot(2,2,2)
    PlotAssocLab(color_CS, UW58.Lab, Ratings, 'Strawberry', sInd, 2, 3)
subplot(2,2,3)
    PlotAssocLab(color_CS, UW58.Lab, Ratings, 'Cantaloupe', cInd, 2, 1)
subplot(2,2,4)
    PlotAssocLab(color_CS, UW58.Lab, Ratings, 'Strawberry', sInd, 2, 1)
    
    
figure(2)
clf
subplot(2,2,1)
    PlotAssocLab(color_MW, UW58.Lab, Ratings, 'Mango', mInd, 2, 3)
subplot(2,2,2)
    PlotAssocLab(color_MW, UW58.Lab, Ratings, 'Watermelon', wInd, 2, 3)
subplot(2,2,3)
    PlotAssocLab(color_MW, UW58.Lab, Ratings, 'Mango', mInd, 2, 1)
subplot(2,2,4)
    PlotAssocLab(color_MW, UW58.Lab, Ratings, 'Watermelon', wInd, 2, 1)   
    
function PlotAssocLab(ColorInd, LabAll, Ratings, Obj, fruitInd, x, y)

numColor = 8;
     LabSubset = LabAll(ColorInd,:);
     rgbSubset = lab2rgb(LabSubset);
     rateSubset = Ratings(fruitInd, ColorInd);
     
    for i = 1:numColor
        hold on
        
        %plot a* and b* coordinates
       plot(LabSubset(i,x), LabSubset(i,y), 'MarkerSize', rateSubset(i)*10 +3, 'Marker', 'o',...
            'MarkerFaceColor',rgbSubset(i,:),'MarkerEdgeColor', 'none');
        
    
        xlim([-100 100])
        ylim([-100 100])
        
        xlabel('a*')
        
        if y == 1 
            ylabel('L*') 
        end
        
        if y == 3 
            ylabel('b*') 
        end
        
        daspect([1 1 1])
        set(get(gca,'ylabel'),'rotation',0, 'VerticalAlignment','middle')
        title(Obj)

    end

end



