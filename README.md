# covid19_russia_mapping
## This project aimed at describing outcomes of COVID-19 epidemics in Russia.
## We utilize demographic data and estimates for mortality and hospitalization rates, as well as available data on invasive mechanical ventilation units per region to estimate the most vulnerable ones.

The provided estimates have some caveats:
1. We expect the uniform attack  rate for different age groups
2. We estimate mortality by infection fatality ratio (IFR) provided by Verity et al., 2020. This is probably an underestimation
3. We lack data on IMV units in some regions
4. We expect about 60% of population to get affected by COVID-19 if no measures will be applied


All the code and neccessary data is provided in the repository

## Results
### Population structure


Population signficantly vary by region. The map below shows the log10 population by region.
![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig0population.png)

For COVID infection the most important is portion of the elderly people, because they are the ones who are most affected.
On the map below you can see  the percentage of people over 80 by region. The region vary by this metrics, with most people over 80 located in the European part of Russia.

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig1perc80.png)


### Estimated mortality rate
Knowing the population demographic structure we can estimate the expected mortality rate by region.
The map below provides such estimate for different region

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig2mortality.png)

Because the population density in different regions is different it is important to understand the portion of the region's population that will be affected.
As we ecxpect the most affected are regions in the European part of Russia

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table3.png)


