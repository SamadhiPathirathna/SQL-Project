/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

select *
from PortfolioProject..CovidDeaths
order by 3,4

select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4


--Check for Empty Strings
SELECT COUNT(*) 
FROM PortfolioProject..CovidDeaths
WHERE continent = '';


UPDATE PortfolioProject..CovidVaccinations
SET continent  = NULL
WHERE continent = '';


SELECT DISTINCT new_vaccinations
FROM PortfolioProject..CovidVaccinations
ORDER BY new_vaccinations;


ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_deaths int;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN new_cases int;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_deaths float;


ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN total_cases float;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN population float;

ALTER TABLE PortfolioProject..CovidDeaths
ALTER COLUMN continent varchar(50) null;


-- Select Data that is needed

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2


Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 1,2



-- Total Cases vs Total Deaths

Select Location, date, total_cases,total_deaths, (total_deaths / (total_cases)) * 100 as DeathPercentage 
From PortfolioProject..CovidDeaths
Where location like '%lanka%'
order by 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, population,total_cases,(total_cases / (population)) * 100 AS PercentPopulationInfected 
From PortfolioProject..CovidDeaths
Where location like '%lanka%'
order by 1,2



-- Countries with Highest Infection Rate compared to Population

Select Location, population,max(total_cases) as HighestInfectionCount,max((total_cases / NULLIF(population, 0))) * 100 AS PercentPopulationInfected 
From PortfolioProject..CovidDeaths
--Where location like '%lanka%'
Where continent is not null
group by location, population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population


Select location,continent, MAX(cast(Total_deaths as FLOAT)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%lanka%'
Where continent is not null 
Group by continent,location
order by TotalDeathCount desc


-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as FLOAT)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%lanka%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc

Select location, MAX(cast(Total_deaths as FLOAT)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%lanka%'
Where continent is null 
Group by location
order by TotalDeathCount desc


-- GLOBAL NUMBERS
SELECT SUM(CAST(new_cases AS FLOAT)) AS total_cases, SUM(CAST(new_deaths AS FLOAT)) AS total_deaths, SUM(CAST(new_deaths AS FLOAT)) / NULLIF(SUM(CAST(new_cases AS FLOAT)), 0) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE  continent IS NOT NULL
--Group By date
ORDER BY  1, 2;



-- Total Population vs Vaccinations
select dea.continent,dea.location, dea.date, dea.population,vac.new_vaccinations
,sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidDeaths vac
	on dea.location= vac.location
	and dea.date=vac.date
where dea.continent IS NOT NULL
order by 2,3



-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent,dea.location, dea.date, dea.population,vac.new_vaccinations
,sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidDeaths vac
	on dea.location= vac.location
	and dea.date=vac.date
where dea.continent IS NOT NULL
)
Select *, (RollingPeopleVaccinated/NULLIF(Population,0))*100 as VaccinatedPercentage
From PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date varchar(50),
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

create view PercentPopulationVaccinated as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)

select *
from PercentPopulationVaccinated

