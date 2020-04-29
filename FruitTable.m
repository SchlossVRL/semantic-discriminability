
% data are organized as follows:
% 36x subjects total, one per file
% 3x repetitions per subject
% 2x target object (1=cantaloupe (or mango), 2=strawberry (or watermelon)
% 2x taller side (1=left, 2=right)
% 8x left color (index 1-8)
% 8x right color (index 1-8)


% generate conditions
[p1,p2,p3,p4,p5,p6] = ndgrid(1:8,1:8,1:2,1:2,1:3,1:36);

conds = [p6(:) p5(:) p4(:) p3(:) p2(:) p1(:)];
% note: we can convert back and forth e.g. as follows:
% [p1,p2,p3,p4,p5,p6] = ind2sub([8,8,2,2,3,36], ix)
% and then: conds(ix,:) = [p6,p5,p4,p3,p2,p1]


%% GENERATE TABLE WITH RESPONSES

Ratings = mean(FruitAssoc,3)';

% table with all conditions in it (same for both experiments)
Tcond = array2table( conds, 'VariableNames', ...
    {'subjnum', 'rep', 'targetobj', 'taller', 'C1', 'C2'} );

% data for CS, response and RT
T_CS = Tcond;
T_CS.response = RespLoad_CS(:); 
T_CS.resptime = RTLoad_CS(:);

% data for MW, response and RT
T_MW = Tcond;
T_MW.response = RespLoad_MW(:);  
T_MW.resptime = RTLoad_MW(:);

% filter tables to remove empty conditions where C1=C2
T_CS = T_CS(T_CS.C1 ~= T_CS.C2, :);
T_MW = T_MW(T_MW.C1 ~= T_MW.C2, :);



% filter tables to include unique color pair column specifier
% made by concatenating min(C1,C2) and max(C2,C1).
% when we swap colors, we must also swap repsonse (but not resptime).
% association ratings between (Target,NonTarget) and (C1,C2)
T_CS = [T_CS rowfun( @colagg, T_CS,...
    'InputVariables',{'C1','C2','response'},...
    'OutputVariableNames',{'ColCond','swap','newresp'} ) ];

T_MW = [T_MW rowfun( @colagg, T_MW,...
    'InputVariables',{'C1','C2','response'},...
    'OutputVariableNames',{'ColCond','swap','newresp'} ) ];


% compute accuracy (from 0 to 1) 
T_CS.accuracy = (2-T_CS.targetobj).*(2-T_CS.newresp) ...
    + (T_CS.targetobj-1).*(T_CS.newresp-1);

T_MW.accuracy = (2-T_MW.targetobj).*(2-T_MW.newresp) ...
    + (T_MW.targetobj-1).*(T_MW.newresp-1);


%% GENERATE FEATURES

T_CS = generate_features( T_CS, fruit_CS, color_CS, UW58.Lab, Ratings );
T_MW = generate_features( T_MW, fruit_MW, color_MW, UW58.Lab, Ratings );

%% SEMANTIC DISTANCE MATRIX

% semantic distance 
T_CS.dS = SemDist( T_CS, fruit_CS, color_CS, FruitAssoc );
T_MW.dS = SemDist( T_MW, fruit_MW, color_MW, FruitAssoc );

%% GENERATE AGGREGATIONS

Tagg_CS = generate_aggregations( T_CS );
Tagg_MW = generate_aggregations( T_MW );

%% OUTPUT TABLES TO CSV

writetable(T_CS, 'CStable.csv')
writetable(T_MW, 'MWtable.csv')

%% Calculate correlations

[r p] = corrcoef(Tagg_CS.dS, Tagg_CS.dE);
[r p] = corrcoef(Tagg_MW.dS, Tagg_MW.dE);

[r p] = corrcoef(Tagg_CS.dS, Tagg_MW.dS);
[r p] = corrcoef(Tagg_CS.dE, Tagg_MW.dE);

[r p] = corrcoef(Tagg_CS.accuracy, Tagg_MW.accuracy);
[r p] = corrcoef(Tagg_CS.resptime, Tagg_MW.resptime);

%% FUNCTIONS

% this function takes a data table, and returns a unique tag corresponding
% to the color pair, meant to aggregate cases (C1,C2) and (C2,C1). In the
% case where a swap is required, the response is inverted and returned as
% the variable newresp.
function [coltag,swap,newresp] = colagg(col1,col2,resp)
    if col1 < col2
        newresp = resp;
        coltag = 10*col1 + col2;
        swap=1;
    else
        newresp = 3-resp;
        coltag = 10*col2 + col1;
        swap=2;
    end
end


%% Semantic distance function

function dS = SemDist(T, fruits, cols, FruitAssoc)

    % compute semantic distance matrix for this pair of concepts and this
    % set of colors. We're doing this now because many of the color pairs
    % are repeated, so we might as well precompute semantic distances
    % between all possible pairs of colors first.
    
    ncols = numel(cols);  % number of colors
    dSmatrix = zeros(ncols,ncols);
    
    for i = 1:ncols
        for j = i+1:ncols
            Wavg = mean( FruitAssoc(cols([i,j]),fruits,:), 3);
            c = 1.4;
            s = c .* Wavg .* (1-Wavg);

            Wnet = ( Wavg(1,1) + Wavg(2,2) - Wavg(1,2) - Wavg(2,1) );
            Snet = sqrt( sum(sum(s.^2)) );
            znet = Wnet/Snet;
            prob_positive = normcdf(znet);
            prob_negative = 1 - prob_positive;
            
            dSmatrix(i,j) = abs(prob_positive - prob_negative);
            dSmatrix(j,i) = dSmatrix(i,j);
        end
    end

    % where we store semantic distances
    dS = zeros(height(T),1);
    
    % loop over each row of the table (which is a unique color pair + target)
    for i = 1:height(T)

        % figure out which colors we are using for this test
        C1ix = floor(T.ColCond(i) / 10);
        C2ix = mod(T.ColCond(i), 10);
        
        % extract relevant distances we precomputed above
        dS(i) = dSmatrix(C1ix,C2ix);
    end
end




