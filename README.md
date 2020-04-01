# Modelling COVID-19 burden in regions of Russia
#### Authors: Sofya Garushyants &#x00B9;,* and Georgii Bazykin &#x00B9;,&#x00B2;
&#x00B9; IITP RAS  
&#x00B2; Skoltech  
*garushyants at iitp dot ru

[Russian version/Русская версия](https://github.com/garushyants/covid19_russia_mapping/blob/master/README_ru.md)

### Abstract

#### The ongoing pandemic of COVID is devastating. Here, we model COVID burden in Russia and the Republic of Crimea under an unmitigated epidemic. For this, we link publically available demographic data with estimates of age-stratified hospitalization, critical care and lethality rates. To model the burden on healthcare, we also use data on the number of invasive mechanical ventilation (IMV) units (ventilators) per region to estimate the adequacy of their current supply. 

#### This is work in progress, and estimates will be refined as data is accumulated. Please contact us with comments, suggestions or questions.

## Modelling assumptions
1. We assume a uniform 60% population-wise infection rate across all regions. This is roughly the fraction of population expected to be infected at the end of the epidemic under the basic reproductive number (R0) of 2.5 in the absence of mitigation ([Anderson et al., 2020](https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(20)30567-5/fulltext)). 60% infected is a high estimate in the short term, but probably a reasonable estimate if the containment and suppression measures fail. The reported case counts are cumulative over the entire epidemic.
2. We assume a uniform attack rate across age groups.
3. We use the age-stratified infection fatality ratio (IFR) obtained from data on international residents repatriated from China in January 2020 ([Verity et al., 2020](https://www.medrxiv.org/content/10.1101/2020.03.09.20033357v1.full.pdf)). The mean IFR across all age groups in that work was 0.66%. IFR is lower than the case fatality rate (CFR) in that as well as in other works ([Wu and McGoogan, 2020](https://jamanetwork.com/journals/jama/fullarticle/2762130?guestAccessKey=bdcca6fa-a48c-4028-8406-7f3d04a3e932&utm_source=For_The_Media&utm_medium=referral&utm_campaign=ftm_links&utm_content=tfl&utm_term=022420&mod=article_inline), [Baud et al., 2020](https://www.thelancet.com/journals/laninf/article/PIIS1473-3099(20)30195-X/fulltext), [Oke and Heneghan](https://www.cebm.net/global-covid-19-case-fatality-rates/)). IFR depends on many factors, including the level of healthcare that can be provided. It can be increased if the medical infrastructure is unable to cope, e.g. due to a deficit of intensive care units. Here, we assume uniform age-stratified IFR (as well as fractions of cases requiring hospitalization and critical cases) across regions. Changes in IFR due to strain on healthcare are not modelled here.
4. Data on ventilators is unavailable for some regions.
5. We assume that patients are ascribed to IMV units in their home regions. 

## Results
### Population 


The map below shows the log10 population by region.
![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig0population.png)

The elderly are the group most affected by the COVID infection, with the estimated IFR of 7.8% for people over 80 y.o. ([Verity et al., 2020](https://www.medrxiv.org/content/10.1101/2020.03.09.20033357v1.full.pdf)). The map below shows the percentage of people over 80 y.o. by region. The regions with the highest fraction of people over 80 y.o. are those in the European part of Russia.

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig1perc80.png)


### Cases requiring hospitalizations or critical care

Knowing the population demographic structure, we can predict the expected number of cases of different severity by region. First, we estimate the cases that will have symptoms severe enough to require hospitalization. Under the assumptions of ([Verity et al., 2020](https://www.medrxiv.org/content/10.1101/2020.03.09.20033357v1.full.pdf)) and ([Ferguson et al., 2020](https://www.imperial.ac.uk/media/imperial-college/medicine/sph/ide/gida-fellowships/Imperial-College-COVID19-NPI-modelling-16-03-2020.pdf)), the predicted age-stratified fraction of infections requiring hospitalizations in Russia is 5.5%, including 1.5% of cases requiring critical care.

Below, we estimate for each region
- the percent of the population that will require hospitalization;
- the percent of the population that will require hospitalization and critical care.

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig3hospitalized.png)

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig4critical.png)

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table1.png)

The European part of Russia is the most affected, due to a large fraction of elderly population.


### Lethality 
The predicted age-stratified population-wide IFR in Russia under the assumptions of ([Verity et al., 2020](https://www.medrxiv.org/content/10.1101/2020.03.09.20033357v1.full.pdf)) is 0.89%. The map below provides the absolute cumulative number of expected COVID-related deaths per region. The regions with large populations (Moscow, Moscow Region, St. Petersburg and the regions in Southern European Russia) will of course be most badly hit in terms of absolute counts. 

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig2mortality.png)

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table2.png)

### Intensive care

Here, we analyze the availability of IMV units across regions from public data. The map below shows the number of IMV units per 100000 population. The per capita numbers of IMV units vary between regions, with the highest numbers in Khanty-Mansiyskiy AOk, Stavropolʹskiy kray, Respublika Sakha, and Tambovskaya oblastʹ.

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig5IMVper100000.png)

As shown above, differences in demographic structure between regions will lead to differences in the proportion of population requiring critical care. Combined with discrepancies in the numbers of units, this leads to major differences between regions in IMV unit occupancies over the course of the epidemic. The predicted cumulative number of critical cases per IMV unit ranges between 7.0 in Tyva 7.4 for the Khanty-Mansiyskiy region and 111.0 for the Leningradsky region. 

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Fig6CasesperIMV.png)

![alt text](https://github.com/garushyants/covid19_russia_mapping/blob/master/Figures/Table3.png)

The breakdown of all variables by region is also available in table format here: [results.csv](https://github.com/garushyants/covid19_russia_mapping/blob/master/results.csv)

## Methods
### Demographics data
Data on 2019 demographic structure by region was obtained from [Rosstat](https://gks.ru/bgd/regl/b19_111/Main.htm) and combined with a python script.
The final table is provided  [here](https://github.com/garushyants/covid19_russia_mapping/blob/master/rosstat_combined.tsv).
### Map data
Maps for Russia and Ukraine were downloaded from [GADM](https://gadm.org/download_country_v3.html). From map of Ukraine we substructed the Republic of Crimea and Sevastopol' and added those regions to the resulting map. Both maps are provided in the repository.
### IMV data
Estimates for the numbers of invasive mechanical ventilators (IMV) were obtained from [meduza.io](https://meduza.io/feature/2020/03/20/v-italii-iz-za-koronavirusa-katastroficheski-ne-hvataet-apparatov-ivl-v-rossii-ih-gorazdo-bolshe-no-eto-ne-znachit-chto-my-luchshe-gotovy-k-epidemii) with additions from Headway [current report](https://www.hwcompany.ru/blog/expert/nali4ie_apparatov_ivl_na_22_03_2020).
The resulting table [IMV_meduza_impr.csv](https://github.com/garushyants/covid19_russia_mapping/blob/master/IMV_meduza_impr.csv) is available in repository.
!!! Starting March, 30 2020!!! We use the updated data on available number of ventilators per region. This data was obtained by Headway from analysis of public procurement from 2017 to 2020. We utilized this data as it is provided in [ikashnitsky repo](https://github.com/ikashnitsky/covid19-russia). The results on the number of critical cases per IMV unit are different for some regions after this update.

### Fatality and hospitalization rates
Data on fatality and hospitalization rates was obtained from [Verity et al., 2020](https://www.medrxiv.org/content/10.1101/2020.03.09.20033357v1.full.pdf), with the hospitalization rate for the age group 0-9 assumed to equal 0.001. Data on cases requiring critical care was obtained from [Ferguson et al., 2020](https://www.imperial.ac.uk/media/imperial-college/medicine/sph/ide/gida-fellowships/Imperial-College-COVID19-NPI-modelling-16-03-2020.pdf). 
All utilized parameters are provided in [mortality_hosp_ICU.tsv](https://github.com/garushyants/covid19_russia_mapping/blob/master/mortality_hosp_ICU.tsv).

## Acknowledgements
This work was inspired by the [work of Ian Miller et al. on COVID-19 burden in the USA](https://github.com/ianfmiller/covid19-burden-mapping/blob/master/README.md).

