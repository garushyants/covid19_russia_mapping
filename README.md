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
The map below provides such estimate for different region. The number of deaths provided there is probably underestimation, and could get much worse if the medical infrastructure won't be able to provide enough intensive care beds (as we see in Italy).

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig2mortality.png)

Because the population density in different regions is different it is important to understand the portion of the region's population that will be affected.
As we expect the most affected are regions in the European part of Russia. 

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table3.png)

### Hospitalized cases and the ones requiring critical care

Of the reasons described above it is hard to estimate the real mortality rate, because it's hardly depends on the provided medical care, that is why it is more important to estimate the number of people that will be hospitalized in each region.
Below we provide two estimates:
- the percent of the population that will be hospitalized
- the percent of population that will be hospitalized and require critical care

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig3hospitalized.png)

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig4critical.png)

As we can see European part of Russia is the one that possibly is more affected.
Again below you can find the top best and worst regions.

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table1.png)

### Intensive care. Most valnurable regions

We already showed that because of the fluctuations in demographic structure in various regions, we expect different portion of critical and hospitalized cases.
What we want to understand is how well this regions are prepared to treat the critical cases.
To estimate that we utilized the public data on IMV units per region.
The map below shows the number of IMVs per 100000 persons

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig5IMVper100000.png)

As you can see this distribution is nonuniform. The most IMVs units per capita are available in Khanty-Mansiyskiy AOk, while other regions have much less units.
Now we can combine the information on IMVs with the information about critical cases.
The map below shows this information.

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig6CasesperIMV.png)

In the table below you can see the ten best prepared (green) and the ten worst prepared regions (red)

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table2.png)



