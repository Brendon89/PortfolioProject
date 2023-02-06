USE [SqlPortfolioProject]
GO
/****** Object:  Table [dbo].[covidVacinations]    Script Date: 06/02/2023 21:37:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[covidVacinations](
	[iso_code] [nvarchar](255) NULL,
	[continent] [nvarchar](255) NULL,
	[location] [nvarchar](255) NULL,
	[date] [datetime] NULL,
	[total_tests] [nvarchar](255) NULL,
	[new_tests] [nvarchar](255) NULL,
	[total_tests_per_thousand] [nvarchar](255) NULL,
	[new_tests_per_thousand] [nvarchar](255) NULL,
	[new_tests_smoothed] [nvarchar](255) NULL,
	[new_tests_smoothed_per_thousand] [nvarchar](255) NULL,
	[positive_rate] [nvarchar](255) NULL,
	[tests_per_case] [nvarchar](255) NULL,
	[tests_units] [nvarchar](255) NULL,
	[total_vaccinations] [nvarchar](255) NULL,
	[people_vaccinated] [nvarchar](255) NULL,
	[people_fully_vaccinated] [nvarchar](255) NULL,
	[total_boosters] [nvarchar](255) NULL,
	[new_vaccinations] [nvarchar](255) NULL,
	[new_vaccinations_smoothed] [nvarchar](255) NULL,
	[total_vaccinations_per_hundred] [nvarchar](255) NULL,
	[people_vaccinated_per_hundred] [nvarchar](255) NULL,
	[people_fully_vaccinated_per_hundred] [nvarchar](255) NULL,
	[total_boosters_per_hundred] [nvarchar](255) NULL,
	[new_vaccinations_smoothed_per_million] [nvarchar](255) NULL,
	[new_people_vaccinated_smoothed] [nvarchar](255) NULL,
	[new_people_vaccinated_smoothed_per_hundred] [nvarchar](255) NULL,
	[stringency_index] [float] NULL,
	[population_density] [float] NULL,
	[median_age] [float] NULL,
	[aged_65_older] [float] NULL,
	[aged_70_older] [float] NULL,
	[gdp_per_capita] [float] NULL,
	[extreme_poverty] [nvarchar](255) NULL,
	[cardiovasc_death_rate] [float] NULL,
	[diabetes_prevalence] [float] NULL,
	[female_smokers] [nvarchar](255) NULL,
	[male_smokers] [nvarchar](255) NULL,
	[handwashing_facilities] [float] NULL,
	[hospital_beds_per_thousand] [float] NULL,
	[life_expectancy] [float] NULL,
	[human_development_index] [float] NULL,
	[excess_mortality_cumulative_absolute] [nvarchar](255) NULL,
	[excess_mortality_cumulative] [nvarchar](255) NULL,
	[excess_mortality] [nvarchar](255) NULL,
	[excess_mortality_cumulative_per_million] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vidDeaths]    Script Date: 06/02/2023 21:37:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vidDeaths](
	[iso_code] [nvarchar](255) NULL,
	[continent] [nvarchar](255) NULL,
	[location] [nvarchar](255) NULL,
	[date] [datetime] NULL,
	[population] [float] NULL,
	[total_cases] [float] NULL,
	[new_cases] [float] NULL,
	[new_cases_smoothed] [float] NULL,
	[total_deaths] [nvarchar](255) NULL,
	[new_deaths] [nvarchar](255) NULL,
	[new_deaths_smoothed] [nvarchar](255) NULL,
	[total_cases_per_million] [float] NULL,
	[new_cases_per_million] [float] NULL,
	[new_cases_smoothed_per_million] [float] NULL,
	[total_deaths_per_million] [nvarchar](255) NULL,
	[new_deaths_per_million] [nvarchar](255) NULL,
	[new_deaths_smoothed_per_million] [nvarchar](255) NULL,
	[reproduction_rate] [nvarchar](255) NULL,
	[icu_patients] [nvarchar](255) NULL,
	[icu_patients_per_million] [nvarchar](255) NULL,
	[hosp_patients] [nvarchar](255) NULL,
	[hosp_patients_per_million] [nvarchar](255) NULL,
	[weekly_icu_admissions] [nvarchar](255) NULL,
	[weekly_icu_admissions_per_million] [nvarchar](255) NULL,
	[weekly_hosp_admissions] [nvarchar](255) NULL,
	[weekly_hosp_admissions_per_million] [nvarchar](255) NULL
) ON [PRIMARY]

GO

--
select * from covidVacinations
where continent is not null
order by 3,4

--select * from vidDeaths
--order by 3,4

--data well be making use of 
select location, date, total_cases,new_cases total_deaths, population
from vidDeaths 
where continent is not null --this gives more accurate results. Continents are in place of locations/countries
--in some places
order by 1,2

--total cases comapred to deaths in different countries
select location, date, total_cases, total_deaths, (total_deaths / total_cases) *100  AS DeathsPercentage
from vidDeaths where location like '%south africa%'
where continent is not null
order by 1,2

select location, date, total_cases, total_deaths, (total_deaths / total_cases) *100  AS DeathsPercentage
from vidDeaths where location like '%zimbabwe%' 
AND continent is not null
order by 1,2



--total cases comapred to the population (percenatge of the population that contracted covid)
select location, date, total_cases, population ,(total_deaths / population) *100  AS CovidContractions
from vidDeaths where location like '%south africa%' order by 1,2

--for China
select location, date, total_cases, population ,(total_deaths / population) *100  AS CovidContractions
from vidDeaths where location like '%china' order by 1,2

--for United States
select location, date, total_cases, population ,(total_deaths / population) *100  AS CovidContractions
from vidDeaths where location like '%states%' order by 1,2


--Countries with the higest infection compared to the population
select location, population, MAX(total_cases) AS HigestInfectionCount,MAX((total_cases/population))*100 as
PercentagePopulationInfected
from vidDeaths
group by location, population
order by 1,2
desc


--countries with the most or higest deaths with percentage
select location, population, max(total_deaths) as MostDeaths, max((total_deaths/ population)) * 100
as PercentageDeaths
from vidDeaths group by location, population
order by 1,2

--cast allows us to convert data types from nvarch to integer
select location, population, max(cast(total_deaths as int)) as MostDeaths, max((total_deaths/ population)) * 100
as PercentageDeaths
from vidDeaths group by location, population
order by 1,2

--data looking slightly more accurate/.
select location, max(cast(total_deaths as int)) as totalDeaths
from vidDeaths
where continent is null
group by location
order by totalDeaths asc


--continents with highest death compared to the population
select continent, max(cast(total_deaths as int)) as totalDeaths
from vidDeaths where continent is not null
group by continent 
order by totalDeaths asc


--whole worlds numbers
--this gives us the total amount of cases on a specific date
--in a continent.
--We also see the deaths in a continent on a specific day
--again we use cast because of the data types that were used in orginal data
select date , sum(new_cases) as casesInDay, sum( cast(new_deaths as int)) as deaths, continent
from vidDeaths 
where continent is not null
group by date, continent
order by 1,2 

--Vaccinations
--Total population compared to population
select * from vidDeaths dea
join covidVacinations vac on
 dea.location = vac.location
 and dea.date = vac.date

 --how many people have been vaccinated in south africa per day 
 select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
 from vidDeaths dea
join covidVacinations vac on
 dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null and vac.location like '%south africa%'
 order by 2,3


 ----Rolling count
 -- as number increases, we want it to add up.
 --we are converting because of the data type. its a nvarch and not an integer an we cannot do caluculations with nvachar
 
  select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
  ,sum(convert(int ,vac.new_vaccinations )) OVER (Partition by dea.Location order by dea.location,
  dea.date) as RollingVaccinations
 from vidDeaths dea
join covidVacinations vac on
 dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null and vac.location like '%south africa%'
 order by 2,3


 --USING CTE

 With PopvsVac ( Continent, Location, Date, Population,new_vaccinations ,RollingVaccinations) 

 as
 (
 select dea.continent, dea.location, dea.date, dea.population,vac.new_vaccinations
,sum(convert(int ,vac.new_vaccinations )) OVER (Partition by dea.Location order by dea.location,
dea.date) as RollingVaccinations
--(RollingVaccinations / population) *100
from vidDeaths dea
join covidVacinations vac on
dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and vac.location like '%south africa%'
--order by 2,3
)
select * ,(RollingVaccinations / population) *100
from PopvsVac


--Views for visualizations

Create View  DeathcomparedToPopulation as 

--continents with highest death compared to the population
select continent, max(cast(total_deaths as int)) as totalDeaths
from vidDeaths where continent is not null
group by continent 
--order by totalDeaths asc

Create View locationAndTotalDeaths
as
select location, max(cast(total_deaths as int)) as totalDeaths
from vidDeaths
where continent is null
group by location


Create View CountryWithHigestInfected
as
select location, population, MAX(total_cases) AS HigestInfectionCount,MAX((total_cases/population))*100 as
PercentagePopulationInfected
from vidDeaths
group by location, population

