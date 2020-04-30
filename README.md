

# Semantic Discriminability for Visual Communication 

_Karen B. Schloss, Zachary Leggon, and Laurent Lessard_

Semantic discriminability is the degree to which observers can infer distinct mappings between visual features and concepts, based on the visual features and concepts alone (i.e., without legends or labels). In this project, we define a new metric to quantify semantic discriminability, called semantic distance. We then evaluated whether people's ability to interpret information visualizations was influenced by semantic distance, independent of perceptual distance (i.e., delta E in CIELAB space). The results show that semantic distance influences interpretability independent of perceptual distance, and overrides perceptual distance when the metrics conflict. These results can be used to inform color palette design for information visualizations, and help navigate trade-offs between competing factors (e.g., perceptual distance, semantic distance, name difference, aesthetic preference, affective connotiation). 

---

### Input data files

`UW58Colors.mat`: Stores the CIELAB coordinates for the UW-58 colors.

`Fruit.mat`: Stores the data from the present experiment and color-concept associations from Rathore et al. (2020). The content is described in `MAIN.m`

### Matlab scripts

`MAIN.m`: Main Matlab script. Run this file to load the data, create the .csv files used for analysis, and create the plots used to make the paper figures. This file runs `FruitAssociations.m`, `PlotFruitLAB.m`, `FruitTable.m`, and `FruitLayers.m`, which are described below.

`FruitAssociations.m`: Plots color-concept associations for the colors and fruits tested in Exp 1 and Exp 2.

`PlotFruitLAB.m`: Plots colors from Exp 1 and Exp 2 in CIELAB space.

`FruitTable.m`: Organizes the data into tables and calculates semantic distance. Creates `CStable.csv` and `MWtable.csv`, which are later used by `SemanticDisc.R` to compute statistics. Uses helper functions `generate_aggregations.m` and `generate_features.m`.

`FruitLayers.m`: Plots the predictors, data, and regression predictions from Exp 1 and Exp 2.

### Output data files

`CStable.csv`: stores the data from Experiment 1 (Cantaloupe and Strawberry) and predictors used for analyses in `SemanticDisc.R`. Columns include:
 - `subjnumber`: participant number, 1-36.
 - `rep`: trial repetition, 1-3.
 - `targetobj`: target object, 1 = cantaloupe, 2 = strawberry.
 - `C1`: color index for the color on the left.
 - `C2`: color index for the color on the right.
 - `response`: 1 = left, 2 = right.
 - `resptime`: response time in milliseconds.
 - `ColCond`, `swap`, `newresp`: intermediate quantities used for tracking left/right swapping of conditions.
 - `accuracy`: response accuracy, 1 = correct, 0 = incorrect.
 - `TC1`: association strength between the target and color 1.
 - `TC2`: association strength between the target and color 2.
 - `NTC1`: association strength between the non-target and color 1.
 - `NTC2`: association strength between the non-target and color 2.
 - `Tcorrect`: association strength between the target and the correct color.
 - `dE`: perceptual distance between the two colors, Delta E, in CIELAB space.
 - `dS`: semantic distance between the two colors in this context, Delta S.

`MWtable.csv`: same as `CStable.csv` except in `targetobj`, 1 = mango and 2 = watermelon.

### R scripts

`SemanticDisc.R`: R script that runs mixed-effect logistic regressions and linear mixed-effect models on the experiment data. Takes `CStable.csv` and `MWtable.csv` as inputs.





