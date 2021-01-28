--Exercice 1:

SELECT population FROM world WHERE name = 'Germany';

SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000;

--Exercice 2:

SELECT name FROM world WHERE name LIKE 'Y%';

SELECT name FROM world WHERE name LIKE '%y';

SELECT name FROM world WHERE name LIKE '%x%';

SELECT name FROM world WHERE name LIKE '%land';

SELECT name FROM world WHERE name LIKE 'C%ia';

SELECT name FROM world WHERE name LIKE '%oo%';

SELECT name FROM world WHERE name LIKE '%a%a%a%';

SELECT name FROM world WHERE name LIKE '_t%';

SELECT name FROM world WHERE name LIKE '%o__o%';

SELECT name FROM world WHERE name LIKE '____';

SELECT name FROM world WHERE name = capital;

SELECT name FROM world WHERE capital = concat(name, ' City');

SELECT capital, name FROM world WHERE capital LIKE concat('%', name, '%');

SELECT capital, name FROM world WHERE capital LIKE concat('%', name, '%') AND capital != name;

SELECT name, REPLACE(capital, name, '') FROM world WHERE capital LIKE concat('%', name, '%') AND capital != name;

--Exercice 3:

SELECT name, continent, population FROM world;

SELECT name FROM world WHERE population > 200000000;

SELECT name, GDP / population AS 'per capita GDP' FROM world WHERE population > 200000000;

SELECT name, population / 1000000 AS population FROM world where continent = 'South America';

SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy');

SELECT name FROM world WHERE name LIKE '%United%';

SELECT name, population, area FROM world WHERE population > 250000000 OR area > 3000000;

SELECT name, population, area FROM world WHERE population > 250000000 XOR area > 3000000;

SELECT
  name,
  ROUND((population / 1000000), 2) AS population,
  ROUND((gdp / 1000000000), 2) AS gdp
  FROM world
  WHERE continent = 'South America';

SELECT name, ROUND((gdp / population) / 1000) * 1000 AS 'per capita GDP' FROM world WHERE gdp > 1000000000000;

SELECT name, capital FROM world WHERE LENGTH(name) = LENGTH(capital);

SELECT name, capital FROM world WHERE LEFT(name, 1) = LEFT(capital, 1) AND name != capital;

SELECT name FROM world
  WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';

