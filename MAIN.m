
clc

load FruitData1
% loads:
% --> 256 conditions are: 2 target obj x 2 bar height x 64 color pairs
% ClrNumbers: (256x2) array of color conditions [same as ColorCond_MW]
% ColorCond:  (256x2) array of color conditions
% ColorCond_MW: (256x2) array of color conditions for MW
% 
% FruitAssoc: (58x12x54) array of color x fruit x test subjects assoc ratings
                % 1-Mango       2-Watermelon 3-Honeydew     4-Cantaloupe 
                % 5-Grapefruit  6-Strawberry 7-Raspberry    8-Blueberry 
                % 9-Avocado     10-Orange    11-Lime        12-Lemon

% RespLoad: (256x3x36) array of responses (cond x reps x subjects) (1=left, 2=right, 0=null)
% RTLoad: (256x3x36) array of RTs (cond x reps x subjects) (in ms -- 0=null)
% RespLoad_MW, RTLoad_MW (same as above, but for MW instead of SC)
% TargetCond: which fruit was active

%Fruit order is for Fruit Assoc is:


% NOTE: THE ONLY THING WE NEED HERE IS FruitAssoc]

load UW58Colors
% loads UW-58 colors
% UW58.Lab is a 58x3 array of Lab coords

UW58.RGB = lab2rgb(UW58.Lab);

% fruit selector

cInd = 4;
sInd = 6;
mInd = 1;
wInd = 2;

fruit_CS = [cInd sInd];  
fruit_MW = [mInd wInd];

% color selector
color_CS = [58, 50, 39, 46, 8,  28, 32, 44];
color_MW = [58, 53, 50, 49, 36, 10, 48, 44];

% data are organized as follows:
% 36x subjects total, one per file
% 3x repetitions per subject
% 2x target object (1=mango, 2=strawberry)
% 2x taller side (1=left, 2=right)
% 8x left color (index 1-8)
% 8x right color (index 1-8)


FruitTable

FruitAssociations %make color-concept association plots
PlotFruitLAB %plot experiment colors in CIELAB space
FruitLayers %plot predictors and data


