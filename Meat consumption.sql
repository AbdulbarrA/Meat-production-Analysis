SELECT indicator,category_of_meat,measure,frequency,year,value,location as country
FROM [dbo].[meat_consumption]

SELECT DISTINCT indicator
FROM meat_consumption
 
 SELECT DISTINCT category_of_meat 
FROM meat_consumption

 SELECT DISTINCT measure 
FROM meat_consumption

SELECT DISTINCT frequency
FROM meat_consumption

SELECT DISTINCT year 
FROM meat_consumption

SELECT DISTINCT value 
FROM meat_consumption

---Indicatimg the total consumption by country 
SELECT DISTINCT SUM(VALUE) AS Total_meat_consumed, location as Country
FROM meat_consumption
GROUP BY  location
ORDER BY 2 DESC

SELECT *
FROM meat_consumption

SELECT value as Sheep_sum
FROM meat_consumption
WHERE category_of_meat = 'SHEEP'
---finding what category of meat had the most consumption based on total consumption
SELECT DISTINCT SUM(VALUE) AS Total_meat,  category_of_meat
FROM meat_consumption
WHERE measure = 'KG_CAP'
GROUP BY   category_of_meat
ORDER BY 1 DESC
/* It was shown that pig had the highest consumption by an average person Kg per capita*/
---so the question is why does human complain in conserving the cattle meat and producing
---plant based meat when the total beef consumption in tonnes is ranked 3rd of total consumption from the 39 countries listed ? 
---more data on cattle production compared to others.


---Identifying total meat production
SELECT *
FROM [dbo].[global-meat-production-by-livestock-type]


---cleaning data
---removing NULLS 

DELETE FROM[dbo].[global-meat-production-by-livestock-type]
WHERE Country IS NULL AND Code IS NULL AND Year IS  NULL AND Meat_game IS NULL
AND Meat_duck IS NULL AND Meat_horse IS NULL AND Meat_camel IS  NULL AND Meat_goose IS  NULL 
AND Meat_sheep IS  NULL AND Meat_pig IS  NULL AND Meat_poultry IS  NULL

SELECT DISTINCT *
FROM [dbo].[global-meat-production-by-livestock-type]

---General Analysis


SELECT CAST( Meat_game AS bigint)game, CAST(Meat_duck AS bigint)duck, CAST(Meat_horse AS bigint)horse, CAST(Meat_camel AS bigint)camel, CAST(Meat_goose AS bigint)goose,
				CAST(Meat_sheep AS bigint)sheep, CAST(Meat_beef AS bigint)beef, CAST(Meat_pig AS bigint)pig, CAST(Meat_poultry AS bigint) poultry, Year, Country
INTO Production
FROM [dbo].[global-meat-production-by-livestock-type]
WHERE	Meat_game IS  NOT NULL AND Meat_duck IS NOT NULL AND Meat_horse IS NOT NULL AND Meat_camel IS NOT NULL AND Meat_goose IS NOT  NULL 
		AND Meat_sheep IS NOT NULL AND Meat_pig IS  NOT NULL AND Meat_poultry IS NOT NULL AND Country IS NOT NULL

	 SELECT SUM(game)game, SUM(duck)duck, SUM(horse)horse, SUM(camel)camel, SUM(goose)goose, SUM(sheep)sheep, SUM(beef)beef, SUM(pig)pig, SUM(poultry)poultry, Year, Country  
	 FROM Production
	 WHERE Year BETWEEN 2000 AND 2020 
	 GROUP BY Year, Country
	 ORDER BY 10 DESC
		/*With this analysis we could find the country with the  production of all form of livestock produced*/

		SELECT DISTINCT Country
		FROM [dbo].[global-meat-production-by-livestock-type]
		ORDER BY 1 ASC


		---To identify the meat consumption in Kg per capita and GDP
		SELECT *
		FROM [dbo].[meat-consumption-vs-gdp-per-capita]

		SELECT DISTINCT Continent
		FROM [dbo].[meat-consumption-vs-gdp-per-capita]
		--- From the data we could get which country consumes more meat by population i.e if there is correlation between population and Kg per capita
		--- Also indicate does the rich consumes more meat by gdp and kg per capita.
		
		/*Discriptive analysis*/
		(---1) 
		SELECT SUM(Population)sum_pop,SUM(Meat_kg_per_capita)sum_per_capita,SUM([GDP_per_capita])sum_gdp,Entity as Country
		FROM [dbo].[meat-consumption-vs-gdp-per-capita]
		WHERE Meat_kg_per_capita IS NOT NULL AND Population IS NOT NULL AND GDP_per_capita IS NOT NULL 
		GROUP BY Entity
		ORDER BY 2 DESC
		/*2767.7378616333*/
		(---2)
		SELECT SUM(GDP_per_capita)GDP_per_capita, SUM(Meat_kg_per_capita)Meat_Kg_per_capita,Continent
		FROM [dbo].[meat-consumption-vs-gdp-per-capita]
		WHERE Meat_kg_per_capita IS NOT NULL AND GDP_per_capita IS NOT NULL AND Continent IS NOT NULL
		GROUP BY Continent
		ORDER BY 1 DESC

		---By population
			SELECT SUM(GDP_per_capita)GDP_per_capita, SUM(Meat_kg_per_capita)Meat_Kg_per_capita,Continent,SUM(Population)Population
		FROM [dbo].[meat-consumption-vs-gdp-per-capita]
		WHERE Meat_kg_per_capita IS NOT NULL AND GDP_per_capita IS NOT NULL AND Continent IS NOT NULL AND Population IS NOT NULL
		GROUP BY Continent
		ORDER BY 1 DESC

	--- Analysing the amout of meat slaugtered( Dataset 3)
SELECT *
FROM [dbo].[animals-slaughtered-for-meat]


SELECT Country ,SUM(Meat_cattle)Meat_cattle, SUM(Meat_goat)Meat_goat, SUM(Meat_chicken)Meat_chicken, SUM(Meat_turkey)Meat_turkey,
		SUM(Meat_cattle)Meat_cattle,SUM(Meat_pig)Meat_pig, SUM(Meat_lamb)Meat_lamb
FROM 
(
SELECT Entity AS Country, CAST(Meat_cattle AS bigint)Meat_cattle, CAST(Meat_goat AS bigint)Meat_goat, CAST(Meat_chicken AS bigint)Meat_chicken, CAST(Meat_turkey AS bigint)Meat_turkey,
		CAST(Meat_pig AS bigint)Meat_pig, CAST(Meat_lamb AS bigint)Meat_lamb
FROM [dbo].[animals-slaughtered-for-meat]
)a
WHERE Meat_cattle IS NOT NULL AND Meat_goat IS NOT NULL AND Meat_chicken IS NOT NULL AND Meat_turkey IS NOT NULL
	AND Meat_pig IS NOT NULL AND Meat_lamb IS NOT NULL
GROUP BY Country
ORDER BY SUM(Meat_cattle) DESC

---Analysis of meat production in tonnes
SELECT*
FROM [dbo].[meat-production-tonnes]

SELECT DISTINCT Code
FROM [dbo].[meat-production-tonnes]

SELECT DISTINCT Year
FROM [dbo].[meat-production-tonnes]


SELECT DISTINCT Total_meat_production_tonnes
FROM [dbo].[meat-production-tonnes]

 ---meat production by country
SELECT Entity AS Country,Year,Total_meat_production_tonnes
FROM [dbo].[meat-production-tonnes]
WHERE Entity <> 'Europe' AND Entity <> 'Africa' AND Entity <> 'Western Africa (FAO)'
AND Entity <> 'Western Asia (FAO)' AND Entity <> 'Western Europe(FAO)' AND Entity <> 'Upper-middle-income countries'
AND Entity <> 'World' AND Entity <> 'South-eastern Asia (FAO)' AND Entity <> 'Southern Africa(FAO)' AND Entity <> 'Southern Asia (FAO)'
AND Entity <> 'South Europe (FAO)' AND Entity <> 'South America (FAO)' AND Entity <> 'Small Island Developing States (FAO)'
AND Entity <> 'Oceania (FAO)'  AND Entity <> 'Northern Africa (FAO)'  AND Entity <> 'Northern America (FAO)'
AND Entity <> 'Northern Europe (FAO)' AND Entity <> 'Micronesia (FAO)' AND Entity <> 'Middle Africa (FAO)' AND Entity <> 'Low Income Food Deficit Countries (FAO)'
AND Entity <> 'Lower-middle-income countries' AND Entity <> 'Low-income countries' AND Entity <>'Least Developed Countries (FAO)'
AND Entity <> 'Land Locked Developing Countries (FAO)' AND Entity <> 'High-income countries' AND Entity <> 'Europe (FAO)'
AND Entity <> 'Europoean Union (FAO)' AND Entity <> 'European Union (27) (FAO)' AND Entity <> 'Eastern Africa (FAO)'
AND Entity <> 'Eastern Asia (FAO)' AND Entity <> 'Eastern Europe (FAO)' AND Entity <> 'Central Asia (FAO)'
AND Entity <> 'Central America (FAO)' AND Entity <> 'Central African Republic (FAO)' AND Entity <> 'Caribbean (FAO)' AND Entity <> 'Belgium-Luxembourg (FAO)'
AND Entity <> 'Asia (FAO)' AND Entity <> 'Americas (FAO)' AND Entity <> 'Africa (FAO)' AND Entity <> 'European Union (27)' 
AND Entity <> 'Net Food Importing Developing Countries (FAO)' AND Entity <> 'Southern Africa (FAO)' AND Entity <> 'Southern Europe (FAO)'
AND Entity <> 'Sudan (former)' AND Entity <> 'Western Europe (FAO)' AND Entity <> 'China (FAO)' AND Year IS NOT NULL AND Entity IS NOT NULL AND Total_meat_production_tonnes IS NOT NULL
 
ORDER BY 2 DESC

---By year
SELECT Year,SUM(Total_meat_production_tonnes) AS Total_meat_produced_tonnes
FROM [dbo].[meat-production-tonnes]
WHERE Entity <> 'Europe' AND Entity <> 'Africa' AND Entity <> 'Western Africa (FAO)'
AND Entity <> 'Western Asia (FAO)' AND Entity <> 'Western Europe(FAO)' AND Entity <> 'Upper-middle-income countries'
AND Entity <> 'World' AND Entity <> 'South-eastern Asia (FAO)' AND Entity <> 'Southern Africa(FAO)' AND Entity <> 'Southern Asia (FAO)'
AND Entity <> 'South Europe (FAO)' AND Entity <> 'South America (FAO)' AND Entity <> 'Small Island Developing States (FAO)'
AND Entity <> 'Oceania (FAO)'  AND Entity <> 'Northern Africa (FAO)'  AND Entity <> 'Northern America (FAO)'
AND Entity <> 'Northern Europe (FAO)' AND Entity <> 'Micronesia (FAO)' AND Entity <> 'Middle Africa (FAO)' AND Entity <> 'Low Income Food Deficit Countries (FAO)'
AND Entity <> 'Lower-middle-income countries' AND Entity <> 'Low-income countries' AND Entity <>'Least Developed Countries (FAO)'
AND Entity <> 'Land Locked Developing Countries (FAO)' AND Entity <> 'High-income countries' AND Entity <> 'Europe (FAO)'
AND Entity <> 'Europoean Union (FAO)' AND Entity <> 'European Union (27) (FAO)' AND Entity <> 'Eastern Africa (FAO)'
AND Entity <> 'Eastern Asia (FAO)' AND Entity <> 'Eastern Europe (FAO)' AND Entity <> 'Central Asia (FAO)'
AND Entity <> 'Central America (FAO)' AND Entity <> 'Central African Republic (FAO)' AND Entity <> 'Caribbean (FAO)' AND Entity <> 'Belgium-Luxembourg (FAO)'
AND Entity <> 'Asia (FAO)' AND Entity <> 'Americas (FAO)' AND Entity <> 'Africa (FAO)' AND Entity <> 'European Union (27)' 
AND Entity <> 'Net Food Importing Developing Countries (FAO)' AND Entity <> 'Southern Africa (FAO)' AND Entity <> 'Southern Europe (FAO)'
AND Entity <> 'Sudan (former)' AND Entity <> 'Western Europe (FAO)' AND Entity <> 'China (FAO)' AND Year IS NOT NULL AND Entity IS NOT NULL AND Total_meat_production_tonnes IS NOT NULL
GROUP BY Year 
ORDER BY 2 DESC

SELECT Year, Entity, Total_meat_production_tonnes
FROM [dbo].[meat-production-tonnes]
WHERE Year IS NOT NULL AND Entity IS NOT NULL AND Total_meat_production_tonnes IS NOT NULL


