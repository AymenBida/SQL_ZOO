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

-- Exercice 4:

SELECT yr, subject, winner FROM nobel WHERE yr = 1950;

SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'Literature';

SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';

SELECT winner FROM nobel WHERE subject = 'Peace' AND yr >= 2000;

SELECT * FROM nobel WHERE subject = 'Literature' AND yr >= 1980 AND yr <= 1989;

SELECT * FROM nobel WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

SELECT winner FROM nobel WHERE winner LIKE 'John %'

SELECT yr, subject, winner FROM nobel
  WHERE (subject = 'Physics' AND yr = 1980)
  OR (subject = 'Chemistry' AND yr = 1984);

SELECT yr, subject, winner FROM nobel WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine');

SELECT yr, subject, winner FROM nobel
  WHERE (subject = 'Medicine' AND yr < 1910)
  OR (subject = 'Literature' AND yr >= 2004);

SELECT * FROM nobel WHERE winner = 'Peter Grünberg';

SELECT * FROM nobel WHERE winner = "Eugene O\'neill";

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner;

SELECT winner, subject
  FROM nobel
  WHERE yr=1984
  ORDER BY subject IN ('Physics','Chemistry'), subject, winner;

--Exercice 5:

SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name='Russia');

SELECT name FROM world
  WHERE continent = 'Europe'
  AND gdp / population > (SELECT gdp / population FROM world WHERE name = 'United Kingdom');

SELECT name, continent FROM world
  WHERE continent IN (
    (SELECT continent FROM world WHERE name = 'Argentina'),
    (SELECT continent FROM world WHERE name = 'Australia')
    ) ORDER BY name;

SELECT name FROM world
  WHERE population > (SELECT population FROM world WHERE name = 'Canada')
  AND population < (SELECT population FROM world WHERE name = 'Poland');

SELECT name,
  CONCAT(ROUND(100 * population / (SELECT population FROM world WHERE name = 'Germany')), '%') AS percentage
  FROM world WHERE continent = 'Europe';

SELECT name FROM world WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0);

SELECT continent, name, area FROM world x
  WHERE area >= ALL(SELECT area FROM world y WHERE y.continent = x.continent AND population > 0)

SELECT continent, name FROM world x
  WHERE name = (SELECT name FROM world y WHERE x.continent = y.continent ORDER BY name LIMIT 1);

SELECT name, continent, population FROM world x
  WHERE 25000000 >= ALL(SELECT population FROM world y WHERE x.continent = y.continent);

SELECT name, continent FROM world x
  WHERE population / 3 > ALL(SELECT population FROM world y WHERE x.continent = y.continent AND x.name != y.name);

--Exercice 6:

SELECT SUM(population) FROM world;

SELECT DISTINCT continent FROM world;

SELECT SUM(gdp) FROM world WHERE continent = 'Africa';

SELECT COUNT(name) FROM world WHERE area >= 1000000;

SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

SELECT continent, COUNT(name) FROM world GROUP BY continent;

SELECT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY continent;

SELECT continent FROM world GROUP BY continent HAVING SUM(population) >= 100000000;

--Exercice 7:

SELECT matchid, player FROM goal WHERE teamid = 'GER';

SELECT id, stadium, team1, team2 FROM game WHERE id = 1012;

SELECT player, teamid, stadium, mdate FROM game JOIN goal ON id = matchid WHERE teamid = 'GER';

SELECT team1, team2, player FROM game JOIN goal ON id = matchid WHERE player LIKE 'Mario%';

SELECT player, teamid, coach, gtime FROM goal JOIN eteam ON teamid = id WHERE gtime <= 10;

SELECT mdate, teamname FROM game JOIN eteam ON team1 = eteam.id WHERE coach = 'Fernando Santos';

SELECT player FROM goal JOIN game ON matchid = id WHERE stadium = 'National Stadium, Warsaw';

SELECT DISTINCT player FROM game JOIN goal ON matchid = id
  WHERE teamid != 'GER' AND (team1 = 'GER' OR team2 = 'GER');

SELECT teamname, COUNT(teamid) FROM eteam JOIN goal ON id=teamid GROUP BY teamname;

SELECT stadium, COUNT(matchid) FROM game JOIN goal ON id = matchid GROUP BY stadium;

SELECT matchid, mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id 
  WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY matchid, mdate;

SELECT matchid, mdate, COUNT(matchid) FROM game JOIN goal ON matchid = id 
  WHERE teamid = 'GER' GROUP BY matchid, mdate;

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY id, mdate, team1, team2
  ORDER BY mdate, matchid, team1, team2;

--Exercice 8:

