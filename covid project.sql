select * from [portfolio project]..CovidDeaths
order by 3,4


---looking at the data what we want
select location,date,total_cases,new_cases,total_deaths,population from [portfolio project]..CovidDeaths
order by 1,2

--Looking at Total Cases vs Total Deaths
--shows likelihood of dying if you contract covid in your country
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from [portfolio project]..CovidDeaths
where location = 'India'
order by 1,2

---Looking at Total vs Population
--shows what percentage of population got covid
select location,date,total_cases,population,(total_cases/population)*100 as DeathPercentage
from [portfolio project]..CovidDeaths
---where location = 'India'
order by 1,2

--Looking at countries with highest infection rate compared to Population
select location,population,max(total_cases) as highestinfectioncount,max((total_cases/population))*100 as
PercentPopulationInfected
from [portfolio project]..CovidDeaths
group by location,population
order by PercentPopulationInfected desc


---showing countries with highest death count per population

select location,max(cast(Total_deaths as int)) as TotalDeathCount
from [portfolio project]..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc


--lets break things down by continent
select continent,max(cast(Total_deaths as int)) as TotalDeathCount
from [portfolio project]..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

--global numbers
select date,sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage from [portfolio project]..CovidDeaths 
where continent is not null
order by date


---Looking at Total Population vs Vaccinations
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from [portfolio project]..CovidDeaths dea
join [portfolio project]..CovidVaccinations vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2,3
