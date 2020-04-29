
clc

% Load CIELAB coordinates for the UW-58 colors. 
load UW58Colors

% UW58.Lab is a 58x3 array of Lab coords
UW58.RGB = lab2rgb(UW58.Lab); % convert to RGB using assumptions in matlab function

% Row indices for the UW-58 colors tested for 
% Cantaloup/Strawberry (CS, Exp 1) and Mango/Watermelon (MW, Exp 2)
color_CS = [58, 50, 39, 46, 8,  28, 32, 44];
color_MW = [58, 53, 50, 49, 36, 10, 48, 44];

% Load in data 
load FruitData

%FruitAssoc (58x12x54): color-concept associations ratings from Rathore et al. (2020). 
    %58 Rows are the UW-58 colors (same order as in UW58 struct)
    %12 Columns are fruits in the following order:
            % 1-Mango       2-Watermelon 3-Honeydew     4-Cantaloupe 
            % 5-Grapefruit  6-Strawberry 7-Raspberry    8-Blueberry 
            % 9-Avocado     10-Orange    11-Lime        12-Lemon

    %3rd dimension is particpants (different Ps from the present study)

%store fruit indices
cInd = 4;   sInd = 6;   mInd = 1; wInd = 2; 
fruit_CS = [cInd sInd];  
fruit_MW = [mInd wInd];


 %RespLoad_CS (256x3x36): Experiment 1 responses (Cantaloup/Strawbery).
    %1 = left color chose, 2 = right color chosen. 0s are placeholders
    %for conditions where both colors were the same (not presented).
    % 256 rows are conditions. The first 128 rows are cantaloup, and the
    % second 128 rows are strawberry. These are stored in TargetCond
    % (1 = cantaloup, 2 = strawberry).
        %within each fruit, the first 64 rows are taller bar on the
        %left and the second 64 rows are taller bar on the right (this
        %was not a factor of interest and was treated as a replicaiton)
            %within each taller bar condition, there were all pairwise
            %combiantions of colors from color_CS. The order of these 
            %color pairs is specified in ColorCond_CS, where the color 
            %in the 1st column was the color on the left, and the color
            %in the 2nd column was the color on the right. 
    %3 columns are repetitions
    %3rd dimension is particpants (n = 36).

%RTLoad_CS (256x3x36): same as RespLoad_CS but stores response times.

%RespLoad_MW (256x3x36): Experiment 2 responses (Mango/Watermelon). The
%structure is the same as RespLoad_CS, but the colors are specified in
%color_MW and ColorCond_MW. Here, in TargetCond 1=mango and 2=watermelon. 

%RTLoad_MW: same as RespLoad_MW but stores response times.


FruitAssociations %make color-concept association plots
PlotFruitLAB %plot experiment colors in CIELAB space

FruitTable %organize and agregate data into tables (CStable.csv, MWtable.csv)
FruitLayers %plot predictors and data


