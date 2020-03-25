
All results obtained here are available in [results.csv](https://github.com/garushyants/covid19_russia_mapping/blob/master/results.csv)

## Methods
### Demographics data
Data on 2019 demographics by region was obtained from [Rosstat] (https://gks.ru/bgd/regl/b19_111/Main.htm), and then combined with inhouse python script.
The final table is provided in repository [here](https://github.com/garushyants/covid19_russia_mapping/blob/master/rosstat_combined.tsv)

### IMV data
Initial data on invasive mechanical ventilators (IMV) was obtained from [meduza.io](#https://meduza.io/feature/2020/03/20/v-italii-iz-za-koronavirusa-katastroficheski-ne-hvataet-apparatov-ivl-v-rossii-ih-gorazdo-bolshe-no-eto-ne-znachit-chto-my-luchshe-gotovy-k-epidemii)
We added additional data from Headway [current report](https://www.hwcompany.ru/blog/expert/nali4ie_apparatov_ivl_na_22_03_2020)
The resulting table [IMV_meduza_impr.csv](https://github.com/garushyants/covid19_russia_mapping/blob/master/IMV_meduza_impr.csv) is available in repository.

### Mortality and hospitalization rates
Data on mortality and hospitalization rates was obtained from [Verity et al., 2020, medarxiv](https://www.medrxiv.org/content/10.1101/2020.03.09.20033357v1.full.pdf)
We modified the rate for the age group 0-9 from 0.0 to 0.001, expecting that there have to be some cases in this age group.
Data on cases requiring critical care obtained from [Ferguson et al., 2020 Impact of non-pharmaceutical interventions (NPIs) to reduce COVID-19 mortality and healthcare demand](https://www.imperial.ac.uk/media/imperial-college/medicine/sph/ide/gida-fellowships/Imperial-College-COVID19-NPI-modelling-16-03-2020.pdf)
All utilized parameters are provided in [mortality_hosp_ICU.tsv](https://github.com/garushyants/covid19_russia_mapping/blob/master/mortality_hosp_ICU.tsv).

## Acknowledgements
This work was inspired by the [work of Ian Miller et al. on COVID-19 burden in US](https://github.com/ianfmiller/covid19-burden-mapping/blob/master/README.md).


