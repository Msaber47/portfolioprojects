select*
from covid_deaths
where continent is not null ;

#looking at total Cases vs total deaths
#likilihood of dying if you get affected by covid in your country
select location,`date`,total_cases,total_deaths,round((total_deaths/total_cases)*100,2) as death_percent
from covid_deaths
where location like '%samoa%'
order by 1,2;

#looking at what percentage of population got covid
select location,`date`,total_cases,population,round((total_cases/population)*100,2) as population_percent
from covid_deaths
where location like '%africa%'
order by 1,2;

#looking at countries with high infection percentage ccompared to population
select location,population,max(total_cases) as high_infect_con,max(round((total_cases/population)*100,2)) as population_percent
from covid_deaths
group by location,population
order by population_percent desc;

#showing countries with highest death rate when compared to population
select location,population,continent,
MAX(CAST(total_deaths AS double)) AS total_death,round(max(cast(total_deaths as double)/population)*100,2) as death_rate
from covid_deaths
where continent is not null
group by location,population,continent
ORDER BY death_rate desc;

#lets break down things to continents where one continent name is not uploaded correctly
select continent,
MAX(CAST(total_deaths AS double)) AS total_death
from covid_deaths
where continent is not null
group by continent
ORDER BY total_death desc;

#showing continents with the highest death count per population
select continent,round(max(cast(total_deaths as double)/population)*100,2) as max_count_death
from covid_deaths
where continent is not null
group by continent
order by max_count_death desc;

#global numbers
select location,date,sum(new_cases) as new_cases,sum(new_deaths) as new_deaths
from covid_deaths
group by date,location
order by new_deaths desc;
