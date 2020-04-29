%% Plot color-concept association strengths for chosen fruits


figure (5)
FruitAssocBars(FruitAssoc, UW58.Lab, color_CS, 4, 6, 'Cantaloupe', 'Strawberry')

figure(53)
FruitAssocBars(FruitAssoc, UW58.Lab, color_MW, 1, 2, 'Mango', 'Watermelon')




function [ ] = FruitAssocBars(Ratings, Colmat, chosenColors, F1, F2, F1name, F2name)

clf
n = size(Ratings,3);

F1_ratingsAll = squeeze(Ratings(chosenColors,F1,:)); 
F2_ratingsAll = squeeze(Ratings(chosenColors,F2,:));

SEM1 = std(F1_ratingsAll')/sqrt(n);
SEM2 = std(F2_ratingsAll')/sqrt(n);

F1_ratings = mean(F1_ratingsAll,2)'; 
F2_ratings = mean(F2_ratingsAll,2)';

ClrsLAB = Colmat(chosenColors,:);
ClrsRGB = lab2rgb(ClrsLAB);

chosenFruits = [F1 F2];
hold on

subplot(1,3,1)
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
    
subplot(1,3,2)
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