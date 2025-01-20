Select*
From [Porfolio Project]..CovidDeaths
Order by 3,4

--Select*
--From [Porfolio Project]..CovidVaccinations
--Order by 3,4

Select location,date, total_cases, new_cases,total_deaths, population
From [Porfolio Project]..CovidDeaths
Order by 1,2

--total cases vs total deaths

Select location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
From [Porfolio Project]..CovidDeaths
Where location like '%states%'
Order by 1,2

--total cases vs population

Select location, date, total_cases,population, 
(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS Deathpercentage
From [Porfolio Project]..CovidDeaths
--Where location like '%states%'
Order by 1,2

--countries with high infection rate vs population

Select location,population, max(total_cases) as highestinfectioncount,
MAX(total_cases/NULLIF(cast(population as float),0)) *100 AS populationinfectedPercentage
From [Porfolio Project]..CovidDeaths
GROUP BY location, population
order by populationinfectedPercentage desc

--highest death count with country

Select location,population, max(cast(total_deaths as int)) as totaldeathcount
From [Porfolio Project]..CovidDeaths
where continent is not null
GROUP BY location,population
order by totaldeathcount desc


--continent with highest death count
Select continent, max(cast(total_deaths as int)) as totaldeathcount
From [Porfolio Project]..CovidDeaths
where continent is not null
GROUP BY continent
order by totaldeathcount desc


-- global numbers

Select date, SUM(convert(float,new_cases)) as totalcases, sum(convert(float,new_deaths)) as totaldeaths, sum(convert(float,new_deaths))/(sum(nullif(convert(float,new_cases),0)))*100 as deathperecentage--total_cases,total_deaths, 
From [Porfolio Project]..CovidDeaths
--where continent is not null
Group By date
Order by 1,2

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
as rollingpeoplevaccinated, 
--(rollingpeoplevaccinated/population)*100
from [Porfolio Project]..CovidDeaths dea
join [Porfolio Project]..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3


--use cte

with popvsvac (continent, location, date,population,new_vaccinations, rollingpeoplevaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(nullif(convert(bigint, vac.new_vaccinations),0)) over (partition by dea.location order by dea.location, dea.date)
as rollingpeoplevaccinated 
--(rollingpeoplevaccinated/population)*100
from [Porfolio Project]..CovidDeaths dea
join [Porfolio Project]..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 1,2,3
)
Select *, nullif(rollingpeoplevaccinated/population,0)*100
from popvsvac

--temp table

drop table if exists populationvaccinatedpercent
create table populationvaccinatedpercent
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric
)

Insert into populationvaccinatedpercent
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
as rollingpeoplevaccinated 
--(rollingpeoplevaccinated/population)*100
from [Porfolio Project]..CovidDeaths dea
join [Porfolio Project]..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 1,2,3

Select *, (rollingpeoplevaccinated/population)*100
from populationvaccinatedpercent
