%% Plot color-concept association strengths for chosen fruits and colors


%Experiment 1: Cantaloupe and Strawberry
figure (1)
FruitAssocBars(FruitAssoc, UW58.Lab, color_CS, fruit_CS, 'Cantaloupe', 'Strawberry')

%Experiment 2: Mango and Watermelon
figure(2)
FruitAssocBars(FruitAssoc, UW58.Lab, color_MW, fruit_MW, 'Mango', 'Watermelon')

%% Plot color-concept associations chosen fruits and all colors
figure(1001)

clf
FruitInds = [cInd, sInd, mInd, wInd];
FruitNames = {'Cantaloup', 'Strawberry', 'Mango', 'Watermelon'};

hold on
for i = 1:4
subplot(4,1,i)
    PlotAssoc(FruitAssoc(:,FruitInds(i),:), FruitNames(i), UW58.Lab)
end

   
set(gcf,'Position',[665   657   664   523]) 
    
%% FruitAssocBars function to make plots
function [ ] = FruitAssocBars(Ratings, AllColors, Colors, Fruits, F1name, F2name)
% Ratings is the data
% AllColors is the UW-58 colors
% Colors are the colors in the experiment
% Fruits are the fruits in the experiment  
% F1name and F2name are the names of the two fruits in the experiment

clf
n = size(Ratings,3);

F1_ratingsAll = squeeze(Ratings(Colors,Fruits(1),:)); 
F2_ratingsAll = squeeze(Ratings(Colors,Fruits(2),:));

SEM1 = std(F1_ratingsAll')/sqrt(n);
SEM2 = std(F2_ratingsAll')/sqrt(n);

F1_ratings = mean(F1_ratingsAll,2)'; 
F2_ratings = mean(F2_ratingsAll,2)';

ClrsLAB = AllColors(Colors,:);
ClrsRGB = lab2rgb(ClrsLAB);

hold on

subplot(1,2,1)
    hold on
    for i = 1:8
        bar(i, F1_ratings(i), 'FaceColor', ClrsRGB(i,:))
        plot([i,i], [F1_ratings(i)-SEM1(i), F1_ratings(i)+SEM1(i)], 'k', 'LineWidth', .8)
        plot([i-.2,i+.2], [F1_ratings(i)-SEM1(i), F1_ratings(i)-SEM1(i)], 'k', 'LineWidth', .8)
        plot([i-.2,i+.2], [F1_ratings(i)+SEM1(i), F1_ratings(i)+SEM1(i)], 'k', 'LineWidth', .8)
    end

    ylabel('Average Association Strength')
    xlabel('Color')
    title(F1name)
    ylim([0 1])
    xlim([0 9])
    
subplot(1,2,2)
    hold on
    for i = 1:8
        bar(i, F2_ratings(i), 'FaceColor', ClrsRGB(i,:))
        plot([i,i], [F2_ratings(i)-SEM2(i), F2_ratings(i)+SEM2(i)], 'k', 'LineWidth', .8)
        plot([i-.2,i+.2], [F2_ratings(i)-SEM2(i), F2_ratings(i)-SEM2(i)], 'k', 'LineWidth', .8)
        plot([i-.2,i+.2], [F2_ratings(i)+SEM2(i), F2_ratings(i)+SEM2(i)], 'k', 'LineWidth', .8)
    end

    ylabel('Average Association Strength')
    xlabel('Color')
    title(F2name)
    ylim([0 1])
    xlim([0 9])

end