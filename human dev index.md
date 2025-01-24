-- for the whole table
select*
from [Human development Index]..hdr_general
order by ["country"] desc

-- year vs life expectancy overall
select ["life_expectancy"], ["year"],["country"]
from [Human development Index]..hdr_general
order by ["country"] desc

--year vs life expectancy males vs females
select ["life_expec_m"], ["life_expec_f"], ["year"],["country"]
from [Human development Index]..hdr_general
order by ["country"] desc

--overall year of schooling for each country
select ["expec_yr_school"],  ["year"], ["country"]
from [Human development Index]..hdr_general
order by ["country"] desc

select ["expec_yr_school_m"],  ["expec_yr_school_f"], ["year"], ["country"]
from [Human development Index]..hdr_general
order by ["country"] desc

--gross in for each country
select ["gross_inc_percap"],  ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

select ["gross_inc_percap_m"], ["gross_inc_percap_f"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

--hdi for each country
select ["hdi"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

select ["hdi_m"], ["hdi_f"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

--life expectancy vs labor
select ["life_expec_m"], ["life_expec_f"], ["year"],["country"], ["labour_participation_m_%"], ["labour_participation_f_%"]
from [Human development Index]..hdr_general
order by ["country"] desc

--gross in vs exp school yr
select ["gross_inc_percap"],["expec_yr_school"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

select ["gross_inc_percap_m"], ["gross_inc_percap_f"], ["expec_yr_school_m"],  ["expec_yr_school_f"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

-- gross inc vs mean school yr
select ["gross_inc_percap"],["mean_yr_school"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc

select ["gross_inc_percap_m"], ["gross_inc_percap_f"], ["mean_yr_school_m"],  ["mean_yr_school_f"], ["year"], ["country"]
from [Human development Index].. hdr_general
order by ["country"] desc


-- with school f and m percent life expectancy percentage with expec yr
Select  ["year"], ["country"],["life_expec_m"], ["life_expec_f"], ["expec_yr_school_m"],  ["expec_yr_school_f"],
100-(((convert(float, ["life_expec_f"]) - convert(float, ["expec_yr_school_f"]))/ ["life_expec_f"])*100)as total_life_in_school_f_percent, 
100-(((convert(float, ["life_expec_m"]) - convert(float, ["expec_yr_school_m"]))/ ["life_expec_m"])*100) as total_life_in_school_m_percent
from [Human development Index]..hdr_general
where try_convert(float, ["life_expec_f"]) is not null
and try_convert(float,["expec_yr_school_f"]) is not null
and try_convert(float,["life_expec_m"]) is not null
and try_convert(float,["expec_yr_school_m"]) is not null
order by ["country"] desc

-- with f and m percent life expectancy percentage with mean yr
Select  ["year"], ["country"],["life_expec_m"], ["life_expec_f"], ["mean_yr_school_m"],  ["mean_yr_school_f"],
100-(((convert(float, ["life_expec_f"]) - convert(float, ["mean_yr_school_f"]))/ convert(float, ["life_expec_f"]))*100) as total_life_in_school_f_percent_mean, 
100-(((convert(float, ["life_expec_m"]) - convert(float, ["mean_yr_school_m"]))/ convert(float, ["life_expec_m"])))*100 as total_life_in_school_m_percent_mean
from [Human development Index].. hdr_general
where try_convert(float, ["life_expec_f"]) is not null
and try_convert(float,["mean_yr_school_f"]) is not null
and try_convert(float,["life_expec_m"]) is not null
and try_convert(float,["mean_yr_school_m"]) is not null
order by ["country"] desc

-- secondary education% for each country
select ["year"], ["country"], ["secondary_education_f_%"], ["secondary_education_m_%"]
from [Human development Index]..hdr_general
order by ["country"] desc

select ["year"], ["country"], ["secondary_education_f_%"], ["secondary_education_m_%"],
((convert(float,["secondary_education_f_%"]) + convert(float, ["secondary_education_m_%"]))/2) as average_secondary_education_percent
from [Human development Index]..hdr_general
where try_convert(float, ["secondary_education_f_%"]) is not null
and try_convert(float, ["secondary_education_m_%"]) is not null
order by ["country"] desc


--human development index is measure of human dev based on health, education and standard of living

--website: https://www.kaggle.com/datasets/lucasyukioimafuko/human-development-index-hdr-dataset-1990-2022
