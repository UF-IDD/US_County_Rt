#  Effect of specific non-pharmaceutical intervention policies on SARS-CoV-2 transmission in the counties of the United States

[Preprint at medRxiv](https://www.medrxiv.org/content/10.1101/2020.10.29.20221036v1): Yang B, Huang AT, Garcia-Carreras B, Hart WE, Staid A, Hitchings M, Lee EC, Howe CJ, Grantz KH, Wesolowski A, Lemaitre JC. Effect of specific non-pharmaceutical intervention policies on SARS-CoV-2 transmission in the counties of the United States. medRxiv. 2020 Jan 1.

All statatiscal analyses were performed with R version 4.0.2 on Mac. The main and sensitivity analyses were performed with the markdown file 'US_Rt_interventions.Rmd', which will return figures and tables shown in the manuscript.

##  External resources

Below is the list of external repositories that are not synced with this repo
(listed in .gitignore) but are cloned under the root directory of this repo at
local.

1. Daily number of confirmed COVID-19 cases and deaths: [USAFacts](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/)
2. County-level characteristics: ["tidycensus" package version 0.9.9.2](https://cran.r-project.org/web/packages/tidycensus/index.html)
3. State-level NPIs: [COVID-19 US State Policy Database, CUSP](https://docs.google.com/spreadsheets/d/1zu9qEWI8PsOI_i8nI_S29HDGHlIp2lfVMsGxpQ5tvAQ/edit#gid=973655443)
4. Inference of effective reproduction number
[Pyomo](http://www.pyomo.org)
[IPOPT](https://coin-or.github.io/Ipopt/)
[Epi_inference](to be released; details can be request to Carl Laird via cdlaird@sandia.gov)
