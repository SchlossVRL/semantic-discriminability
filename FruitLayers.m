

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
CSx = {'c_1'; 'c_2'; 'c_3'; 'c_4'; 's_4'; 's_3'; 's_2'; 's_1'}; %cantaloupe
MWx = {'m_1'; 'm_2'; 'm_3'; 'm_4'; 'w_4'; 'w_3'; 'w_2'; 'w_1'}; %mango


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
% model with all predictors (main text)

    % cantaloupe/strawberry
    Wcs_acc = [ 0.91, 0.26, 0.23, 0.23]; %int, percept dist, sem dist, assoc
    Wcs_rt = [1017.7, -42.8, 1.9, -68.3]; %int, percept dist, sem dist, assoc

    % mango/watermelon
    Wmw_acc = [1.00, -0.06, 0.41 0.37]; %int, percept dist, sem dist, assoc
    Wmw_rt = [1121.5,  9.0, -36.0, -120.6 ]; %int, percept dist, sem dist, assoc


%model with only semantic and perceptual distance
    Wcs_PS_acc = [ 0.89, 0.22, 0.34  ]; %int, percept dist, sem dist 
    Wcs_PS_rt = [1017.7, -29.3, -37.2]; %int, percept dist, sem dist 

    Wmw_PS_acc = [.97, -0.06, 0.55]; %int, percept dist, sem dist 
    Wmw_PS_rt = [1121.5,  12.1, -86.4]; %int, percept dist, sem dist 

    
%model with assoc only (sup mat)
    
    % cantaloupe/strawberry
    Wcs_A_acc = [0.79, 0.37]; %int,  assoc
    Wcs_A_rt = [1017.7, -76.4]; %int, assoc

    % mango/watermelon
    Wmw_A_acc = [.93, .53]; %int, assoc
    Wmw_A_rt = [1121.5, -135.7 ]; %int,  assoc

   
% store predictors 
Pcs = [Tagg_CS.dE, Tagg_CS.dS, Tagg_CS.Tcorrect];
Pmw = [Tagg_MW.dE, Tagg_MW.dS, Tagg_MW.Tcorrect];

%calculate predictions with all predictors
[Tagg_CS.accpred] = CalcPred(Wcs_acc, Pcs, 'log');
[Tagg_CS.rtpred] = CalcPred(Wcs_rt, Pcs, 'lin');

[Tagg_MW.accpred] = CalcPred(Wmw_acc, Pmw, 'log');
[Tagg_MW.rtpred] = CalcPred(Wmw_rt, Pmw, 'lin');

%calculate correlations between data and model fits with full model (main text)
%cantaloupe/strawberry
[ r p ] = corrcoef(Tagg_CS.accpred, Tagg_CS.accuracy);  %accuracy
[ r p ] = corrcoef(Tagg_CS.rtpred, Tagg_CS.resptime);   %RT   

%mango/watermelon
[ r p ] = corrcoef(Tagg_MW.accpred, Tagg_MW.accuracy);  %accuracy
[ r p ] = corrcoef(Tagg_MW.rtpred, Tagg_MW.resptime);   %RT


%calculate predictions with perceptual and semantic dist. only
[Tagg_CS.accpredPS] = CalcPred(Wcs_PS_acc, Pcs(:,1:2), 'log');
[Tagg_CS.rtpredPS] = CalcPred(Wcs_PS_rt, Pcs(:,1:2), 'lin');

[Tagg_MW.accpredPS] = CalcPred(Wmw_PS_acc, Pmw(:,1:2), 'log');
[Tagg_MW.rtpredPS] = CalcPred(Wmw_PS_rt, Pmw(:,1:2), 'lin');

[ r p ] = corrcoef(Tagg_CS.accpredPS, Tagg_CS.accuracy);
[ r p ] = corrcoef(Tagg_CS.rtpredPS, Tagg_CS.resptime);

[ r p ] = corrcoef(Tagg_MW.accpredPS, Tagg_MW.accuracy);
[ r p ] = corrcoef(Tagg_MW.rtpredPS, Tagg_MW.resptime);


%calculate predictions with assoc only (sup mat)
%cantaloupe/strawberry
[Tagg_CS.accpredA] = CalcPred(Wcs_A_acc, Tagg_CS.Tcorrect, 'log');
[Tagg_CS.rtpredA] = CalcPred(Wcs_A_rt, Tagg_CS.Tcorrect, 'lin');

%mango/watermelon
[Tagg_MW.accpredA] = CalcPred(Wmw_A_acc, Tagg_MW.Tcorrect, 'log');
[Tagg_MW.rtpredA] = CalcPred(Wmw_A_rt, Tagg_MW.Tcorrect, 'lin');

%calculate correlations between data and model fits with assoc only model
%(sup mat)
%cantaloupe/strawberry
[ r p ] = corrcoef(Tagg_CS.accpredA, Tagg_CS.accuracy);
[ r p ] = corrcoef(Tagg_CS.rtpredA, Tagg_CS.resptime);

%mango/watermelon
[ r p ] = corrcoef(Tagg_MW.accpredA, Tagg_MW.accuracy);
[ r p ] = corrcoef(Tagg_MW.rtpredA, Tagg_MW.resptime);


figure (7) %Cantaloupe/Strawberry predictions

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



figure (8) %Mango/Watermelon predictions

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
    




%% Additional numbers reported in the paper
% Avg. accuracy reported in Figure 1
    % Table indices for the 4 quadrants
    w2_w1_mango = 28;       %colcond 7, 8 (order in table S1)
    w2_w1_watermelon = 56;  %colcond 7, 8
    
    w3_w1_mango =  27;         %colcond 6, 8
    w3_w1_watermelon = 55;     %colcond 6, 8
    
    m1_w1_mango = 7;           %colcond 1, 8
    m1_w1_watermelon = 35;     %colcond 1, 8
    
    m2_w1_mango    = 13;       %colcond 2, 8
    m2_w1_watermelon = 41;     %colorcond 2, 8

    %avg acc
    w2_w1Acc = (Tagg_MW.accuracy(w2_w1_mango) + Tagg_MW.accuracy(w2_w1_watermelon))/2;
    w3_w1Acc = (Tagg_MW.accuracy(w3_w1_mango) + Tagg_MW.accuracy(w3_w1_watermelon))/2;
    
    m1_w1Acc = (Tagg_MW.accuracy(m1_w1_mango) + Tagg_MW.accuracy(m1_w1_watermelon))/2;
    m2_w1Acc = (Tagg_MW.accuracy(m2_w1_mango) + Tagg_MW.accuracy(m2_w1_watermelon))/2;
    

% correlate semantic distances in Exp 1 and Exp 2 (only 1:28
% 29:56 is the same set repeated, given that values are the same for both
% targets)
[r p] =  corrcoef(Tagg_CS.dS(1:28), Tagg_MW.dS(1:28));

% correlate perceptual distances in Exp 1 and Exp 2
[r p] =  corrcoef(Tagg_CS.dE(1:28), Tagg_MW.dE(1:28));

% correlate semantic distances and percpetual distance in Exp 1 
[r p] =  corrcoef(Tagg_CS.dS(1:28), Tagg_CS.dE(1:28));

% correlate semantic distances and percpetual distance in Exp 2 
[r p] =  corrcoef(Tagg_MW.dS(1:28), Tagg_MW.dE(1:28));

% correlate association strength with the target (Tcorrec) and semantic distances in Exp 1 (all 56
% rows Tcorrect is different for the two targets
[r p] =  corrcoef(Tagg_CS.Tcorrect, Tagg_CS.dS);

% correlate association strength with the target (Tcorrec) and perceptual
% distances in Exp 1
[r p] =  corrcoef(Tagg_CS.Tcorrect, Tagg_CS.dE)

% correlate association strength with the target (Tcorrec) and semantic distances in Exp 2
% rows Tcorrect is different for the two targets
[r p] =  corrcoef(Tagg_MW.Tcorrect, Tagg_MW.dS);

% correlate association strength with the target (Tcorrec) and perceptual
% distances in Exp 2
[r p] =  corrcoef(Tagg_MW.Tcorrect, Tagg_MW.dE);

%correlate RTs with Acc in Exp 1
[r p] =  corrcoef(Tagg_CS.accuracy, Tagg_CS.resptime);

%correlate RTs with Acc in Exp 2
[r p] =  corrcoef(Tagg_MW.accuracy, Tagg_MW.resptime);

%correlate Accuracy Exp 1 and Exp 2
[r p] =  corrcoef(Tagg_CS.accuracy, Tagg_MW.accuracy);

%correlate RT Exp 1 and Exp 2
[r p] =  corrcoef(Tagg_CS.resptime, Tagg_MW.resptime);


%% Calculate predicted data from regression weights

function [Ypred] = CalcPred(params, predictors, type)
    
    np = length(params); %number of parameters
    
    k = params(1); %constant
    betas = params(2:np); %beta weigts
    
    %z-score the predictors so they are the same as the predictions used in
    %to obtain the regression weights
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



