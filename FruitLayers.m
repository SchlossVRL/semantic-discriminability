

% Plot predictors and data for both experiments

%% codes specifying variable types
vAcc = 1;
vSemDist = 2;
vPercDist = 3;
vRT = 4;
vAssoc = 5;
vAccPred = 6;
vRTPred = 7;

% color notation for x-axis
CSx = {'c_1'; 'c_2'; 'c_3'; 'c_4'; 's_4'; 's_3'; 's_2'; 's_1'};
MWx = {'m_1'; 'm_2'; 'm_3'; 'm_4'; 'w_4'; 'w_3'; 'w_2'; 'w_1'};

%% Semantic and Perceptual distance
figure (5)
subplot(2,2,1)
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'dS', vSemDist, CSx)

subplot(2,2,3)
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'dE', vPercDist, CSx)
    
    
subplot(2,2,2)
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'dS', vSemDist, MWx)
    
subplot(2,2,4)
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'dE', vPercDist, MWx)
        
set(gcf,'Position',[    377   975   571   324]) 

%% Association strength between correct answer and the target object
figure(6)
subplot(1,4,1)
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'Tcorrect', vAssoc, CSx)

subplot(1,4,2)
    plotFruitLayers(Tagg_CS(29:56,:), UW58, color_CS, 'Tcorrect', vAssoc, CSx)    
  
subplot(1,4,3)
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'Tcorrect', vAssoc, MWx)

subplot(1,4,4)
    plotFruitLayers(Tagg_MW(29:56,:), UW58, color_MW, 'Tcorrect', vAssoc, MWx)      

set(gcf,'Position',[638   988   689   124])     
    
    
%%  PLOT DATA  

figure (7) % Cantaloupe/Strawberry

% accuracy
subplot(4,2,1) %cantaloupe
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'accuracy', vAcc, CSx)

subplot(4,2,2) %strawberry
    plotFruitLayers(Tagg_CS(29:56,:), UW58, color_CS, 'accuracy', vAcc, CSx)

% RT
subplot(4,2,5) %cantaloupe
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'resptime', vRT, CSx)

subplot(4,2,6) %straberry
    plotFruitLayers(Tagg_CS(29:56,:), UW58, color_CS, 'resptime', vRT, CSx)
  
set(gcf,'Position',[  1065         818         335         482]) 
    

figure (8) % Mango/Watermelon
% accuracy
subplot(4,2,1) %mango
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'accuracy', vAcc, MWx)

subplot(4,2,2) %watermelon
    plotFruitLayers(Tagg_MW(29:56,:), UW58, color_MW, 'accuracy', vAcc, MWx)

% RT
subplot(4,2,5) %mango
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'resptime', vRT, MWx)

subplot(4,2,6) %watermelon
    plotFruitLayers(Tagg_MW(29:56,:), UW58, color_MW, 'resptime', vRT, MWx)
        
set(gcf,'Position',[  1065         818         335         482]) 


%% Predict data

% weights come from mixed-effect regressions in R
Wcs_acc = [ 0.91, 0.26, 0.23, 0.23]; %int, percept dist, sem dist, assoc
Wcs_rt = [1017.7, -42.8, 1.9, -68.3]; %int, percept dist, sem dist, assoc

Wmw_acc = [1.00, -0.06, 0.41 0.37]; %int, percept dist, sem dist, assoc
Wmw_rt = [1121.5,  9.0, -36.0, -120.6 ]; %int, percept dist, sem dist, assoc

% store predictors 
Pcs = [Tagg_CS.dE, Tagg_CS.dS, Tagg_CS.Tcorrect];
Pmw = [Tagg_MW.dE, Tagg_MW.dS, Tagg_MW.Tcorrect];

%calculate predictions
[Tagg_CS.accpred] = CalcPred(Wcs_acc, Pcs, 'log');
[Tagg_CS.rtpred] = CalcPred(Wcs_rt, Pcs, 'lin');

[Tagg_MW.accpred] = CalcPred(Wmw_acc, Pmw, 'log');
[Tagg_MW.rtpred] = CalcPred(Wmw_rt, Pmw, 'lin');

[ r p ] = corrcoef(Tagg_CS.accpred, Tagg_CS.accuracy);
[ r p ] = corrcoef(Tagg_CS.rtpred, Tagg_CS.resptime);

[ r p ] = corrcoef(Tagg_MW.accpred, Tagg_MW.accuracy);
[ r p ] = corrcoef(Tagg_MW.rtpred, Tagg_MW.resptime);

figure (7) %Cantaloupe/Strawberry

%accuracy 
subplot(4,2,3) %cantaloupe
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'accpred', vAccPred, CSx)

subplot(4,2,4) %strawberry
    plotFruitLayers(Tagg_CS(29:56,:), UW58, color_CS, 'accpred', vAccPred, CSx)

%RT
subplot(4,2,7) %cantaloupe
    plotFruitLayers(Tagg_CS(1:28,:), UW58, color_CS, 'rtpred', vRTPred, CSx)

subplot(4,2,8) %strawberry
    plotFruitLayers(Tagg_CS(29:56,:), UW58, color_CS, 'rtpred', vRTPred, CSx)
 
set(gcf,'Position',[1065         818         335         482]) 



figure (8) %Mango/Watermelon

%accuracy
subplot(4,2,3) %mango
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'accpred', vAccPred, MWx)

subplot(4,2,4) %watermelon
    plotFruitLayers(Tagg_MW(29:56,:), UW58, color_MW, 'accpred', vAccPred, MWx)

 %RT
subplot(4,2,7) %mango
    plotFruitLayers(Tagg_MW(1:28,:), UW58, color_MW, 'rtpred', vRTPred, MWx)

subplot(4,2,8) %watermelon
    plotFruitLayers(Tagg_MW(29:56,:), UW58, color_MW, 'rtpred', vRTPred, MWx)
    
set(gcf,'Position',[1065         818         335         482]) 
    


%% Calculate predicted data from logistic regression

function [Ypred] = CalcPred(params, predictors, type)
    
    np = length(params);
    
    k = params(1);
    betas = params(2:np);
    
    predZ = (predictors - mean(predictors,1))./std(predictors);
    Linear =  k + sum(betas .* predZ, 2);
    
    if type == 'lin'
        Ypred = Linear;
    end
    
    if type == 'log'
        Ypred = 1./(1 + exp(-(Linear)));
    end 
       
end


%% plotFruitLayers plots the fruit line graphs 
function  plotFruitLayers(T, UW58, colorSet, v, vType, xTickLabels)

Titles = {'Accuracy'; 'Semantic Distance'; 'Perceptual Distance'; 'RT'; 'Associaiton'; 'Predicted Accuracy'; 'Predicted RT'};

title(Titles{vType});
yMaxType = [1 1 160 1400 1 1, 1400];
yMinType = [0 0 0 500 0 0, 500];
i = 1;
Markers = {'o', 'o'};
storeC2 = [];
storeAcc = [];
    
% Plot lines
hold on
for c1 = 1:8
    storeC2 = [];
    storeAcc = [];

    for c2 = 1:8
        if c1 < c2
            %separates ColCond into the 1st and 2nd digit (color1 and color2)
            C1ix(i) = floor(T.ColCond(i) / 10);
            C2ix(i) = mod(T.ColCond(i), 10);

            C1(i) = colorSet(C1ix(i));
            C2(i) = colorSet(C2ix(i));

            f = UW58.RGB(C1(i),:);

            storeC2 = [storeC2, c2];
            storeAcc = [storeAcc, T.(v)(i)];

            i = i+1;  
        end
    end
    plot(storeC2, storeAcc, 'Color', f, 'LineWidth', 1)
    set(gca, 'XTickLabel',xTickLabels,'XTick',[1:8], 'FontSize', 8) 
end

% Plot markers
i = 1;

for c1 = 1:8
    for c2 = 1:8
        
        if c1 < c2
     
            f = UW58.RGB(C1(i),:);
            plot(c2, T.(v)(i), 'Marker', Markers{T.targetobj(i)},...
                'MarkerSize', 4, ...
                 'MarkerFaceColor', f, 'MarkerEdgeColor', 'none')
             
            %error bars only for accuracy and RT
            sem = strcat(v, 'SEM');
            if vType == 1 || vType == 4
                plot([c2 c2], [T.(v)(i) - T.(sem)(i), T.(v)(i) + T.(sem)(i)] , 'Color', f, 'LineWidth', .8)
                plot([c2-.1 c2+.1], [T.(v)(i) - T.(sem)(i), T.(v)(i) - T.(sem)(i)] , 'Color', f, 'LineWidth', .8)
                plot([c2-.1 c2+.1], [T.(v)(i) + T.(sem)(i), T.(v)(i) + T.(sem)(i)] , 'Color', f, 'LineWidth', .8)
            end

            i = i+1;  
        end
    end
end

    xlim([0 9])
    ylim([yMinType(vType) yMaxType(vType)])
    
    if vType == 1 | vType == 6 
        plot([0 9], [.5 .5], 'k', 'LineStyle', '--')
        set(gca, 'YTick',[0:.2:1]) 
    end
    
    % Plot colored squares along the x-axis
    for i = 1:8
        plot(i, yMaxType(vType)/25, 'Marker', 's', 'MarkerEdgeColor', 'none', 'MarkerFaceColor', UW58.RGB(colorSet(i),:), 'MarkerSize', 8)
    end

end



