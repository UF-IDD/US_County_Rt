#  Effect of specific non-pharmaceutical intervention policies on SARS-CoV-2 transmission in the counties of the United States

[Preprint at medRxiv](https://www.medrxiv.org/content/10.1101/2020.10.29.20221036v1): Yang B, Huang AT, Garcia-Carreras B, Hart WE, Staid A, Hitchings M, Lee EC, Howe CJ, Grantz KH, Wesolowski A, Lemaitre JC, Rattigan S, Moreno C, Borgert B, Dale C, Quigley N, Cummings A, McLorg A, LoMonaco K, Schlossberg S, Barron-Kraus D, Shrock, UFCOVID Interventions Team, Lessler J, Laird CD, Cummings DAT. Effect of specific non-pharmaceutical intervention policies on SARS-CoV-2 transmission in the counties of the United States. 2020 medRxiv.

Correspondance regarding this study should be addressed to Derek A.T. Cummings (datc@ufl.edu), Carl D. Laird (cdlaird@sandia.gov) or Justin Lessler (justin@jhu.edu).

All statatiscal analyses were performed with R version 4.0.2 on Mac. The main and sensitivity analyses were performed with the markdown file [US_Rt_interventions.Rmd](https://github.com/UF-IDD/US_County_Rt/blob/main/US_Rt_interventions.Rmd), which will return figures and tables shown in the manuscript. Kniting the entire script is not recommended, as some permutation analyses will take hours to run and may reach the memory limit in R.

## Instruction
Data on estimated effective numbers can be found in [rt](https://github.com/UF-IDD/US_County_Rt/tree/main/rt) folder with a seperate [Disclaimer](https://github.com/UF-IDD/US_County_Rt/blob/main/rt/README.md) for these estimates.

Data on case and death numbers, covariates (NPIs and country-level characteristics), and estimates used for figure 4 can be found in [data](https://github.com/UF-IDD/US_County_Rt/tree/main/data) folder.

[Output](https://github.com/UF-IDD/US_County_Rt/tree/main/output) folder will store for plots and tables in the manuscript.

Cleaning and grouping [raw data on state-level NPIs](https://github.com/UF-IDD/US_County_Rt/blob/main/data/intervention_googlesheet_raw_20200702.csv) were performed with [intervention_processing.R](https://github.com/UF-IDD/US_County_Rt/blob/main/intervention_processing.R), including plot Figure S2.

## County-level school closure
Here we provided the data on county-level school closures dates ([school.csv](https://github.com/UF-IDD/US_County_Rt/blob/main/data/school.csv)). Data on county-level public school (K-12) closure were collected by the UFCOVID Interventions Team by consulting the government websites of school district, county and state and local news sources.

##  External resources

Below is the list of external repositories/resources that are used for the manuscript but are not synced with this repo.

1. Daily number of confirmed COVID-19 cases and deaths: [USAFacts](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/)
2. County-level characteristics: ["tidycensus" package version 0.9.9.2](https://cran.r-project.org/web/packages/tidycensus/index.html)
3. State-level NPIs: [COVID-19 US State Policy Database, CUSP](https://docs.google.com/spreadsheets/d/1zu9qEWI8PsOI_i8nI_S29HDGHlIp2lfVMsGxpQ5tvAQ/edit#gid=973655443)
4. Inference of effective reproduction number
[Pyomo](http://www.pyomo.org);[IPOPT](https://coin-or.github.io/Ipopt/); and Epi_inference(to be released; details can be request to Carl Laird via cdlaird@sandia.gov)
5. SEIR model structure: [Lemaitre, J.C., Grantz, K.H., Kaminsky, J. et al. A scenario modeling pipeline for COVID-19 emergency planning. Sci Rep 11, 7534 (2021). https://doi.org/10.1038/s41598-021-86811-0](https://www.nature.com/articles/s41598-021-86811-0#Bib1)
