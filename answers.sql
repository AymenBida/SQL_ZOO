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

SELECT id, title FROM movie WHERE yr = 1962;

SELECT yr FROM movie WHERE title = 'Citizen Kane';

SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%' ORDER BY yr;

SELECT id FROM actor WHERE name = 'Glenn Close';

SELECT id FROM movie WHERE title = 'Casablanca';

SELECT name FROM actor JOIN casting ON id = actorid WHERE movieid = 11768;

SELECT name FROM actor JOIN casting ON id = actorid
  WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien');

SELECT title FROM movie JOIN casting ON id = movieid
  WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford');

SELECT title FROM movie JOIN casting ON id = movieid
  WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1;

SELECT title, name
  FROM movie
    JOIN casting ON movie.id = movieid
    JOIN actor ON actor.id = actorid
  WHERE yr = 1962 AND ord = 1;

SELECT yr, COUNT(title)
  FROM movie
    JOIN casting ON movie.id = movieid
    JOIN actor   ON actorid = actor.id
  WHERE name = 'Rock Hudson' GROUP BY yr HAVING COUNT(title) > 2;

SELECT title, name
  FROM casting
    JOIN movie ON (movie.id = movieid AND ord = 1)
    JOIN actor ON actor.id = actorid
  WHERE movie.id IN (
    SELECT movieid FROM casting WHERE actorid IN (
      SELECT id FROM actor WHERE name='Julie Andrews'));

SELECT name FROM actor
  JOIN casting ON (actor.id = actorid
                  AND (SELECT COUNT(ord) FROM casting
                        WHERE actorid = actor.id AND ord = 1) >= 15) GROUP BY name;

SELECT title, COUNT(actorid) FROM movie JOIN casting on id = movieid
  WHERE yr = 1978 GROUP BY title ORDER BY COUNT(actorid) DESC, title;

SELECT DISTINCT name FROM actor
  JOIN casting ON actor.id = actorid
  WHERE name != 'Art Garfunkel'
    AND movieid IN (SELECT movieid FROM casting
                      WHERE actorid = (SELECT actor.id FROM actor
                                        WHERE name = 'Art Garfunkel'));

--Exercice 9:

SELECT name FROM teacher WHERE dept IS NULL;

SELECT teacher.name, dept.name FROM teacher INNER JOIN dept ON (teacher.dept = dept.id);

SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id);

SELECT teacher.name, dept.name FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id);

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher;

SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id);

SELECT COUNT(name), COUNT(mobile) FROM teacher;

SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id) GROUP BY dept.name;

SELECT teacher.name,
  CASE WHEN (dept.id = 1 OR dept.id = 2) THEN 'Sci'
    ELSE 'Art' END
  FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id);

SELECT teacher.name,
  CASE WHEN (dept.id = 1 OR dept.id = 2) THEN 'Sci'
    WHEN dept.id = 3 THEN 'Art'
    ELSE 'None' END
  FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id);

--Exercice 10:

SELECT A_STRONGLY_AGREE FROM nss
  WHERE question = 'Q01' AND institution = 'Edinburgh Napier University' AND subject = '(8) Computer Science';

SELECT institution, subject FROM nss WHERE question = 'Q15' AND score >= 100;

SELECT institution, score FROM nss
  WHERE question = 'Q15' AND subject = '(8) Computer Science' AND score < 50;

SELECT subject, SUM(response) FROM nss
  WHERE question = 'Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject;

SELECT subject, SUM(response * A_STRONGLY_AGREE / 100) FROM nss
  WHERE question = 'Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject;

SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100) FROM nss
  WHERE question = 'Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject;

SELECT institution, ROUND(SUM(response * score / 100) / SUM(response) * 100) FROM nss
  WHERE question = 'Q22' AND (institution LIKE '%Manchester%') GROUP BY institution;

SELECT institution,
  SUM(sample),
  (SELECT sample FROM nss x WHERE subject = '(8) Computer Science' AND x.institution = y.institution AND question = 'Q01')
  FROM nss y
  WHERE question = 'Q01' AND (institution LIKE '%Manchester%') GROUP BY institution;

--Exercice 11:

SELECT lastName, party, votes FROM ge WHERE constituency = 'S14000024' AND yr = 2017 ORDER BY votes DESC;

SELECT party, votes, RANK() OVER (ORDER BY votes DESC) as posn FROM ge
  WHERE constituency = 'S14000024' AND yr = 2017 ORDER BY party;

SELECT yr, party, votes, RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn FROM ge
  WHERE constituency = 'S14000021' ORDER BY party, yr;

SELECT constituency,party, votes, RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) rank FROM ge
  WHERE constituency BETWEEN 'S14000021' AND 'S14000026' AND yr  = 2017 ORDER BY rank, constituency;

SELECT constituency, party
  FROM (
    SELECT constituency, party, votes, RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) rank
    FROM ge
    WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
      AND yr  = 2017
    ORDER BY rank, constituency) AS x
  WHERE rank = 1;

SELECT party, COUNT(votes) FROM ge x
  WHERE constituency LIKE 'S%'
    AND yr = 2017
    AND votes >= ALL(SELECT votes FROM ge y WHERE x.constituency = y.constituency AND y.yr = 2017)
  GROUP BY party;

--Exercice 12:

SELECT name, DAY(whn), confirmed, deaths, recovered FROM covid
  WHERE name = 'Spain' AND MONTH(whn) = 3 ORDER BY whn;

SELECT name, DAY(whn), confirmed, LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) FROM covid
  WHERE name = 'Italy' AND MONTH(whn) = 3 ORDER BY whn;

SELECT name,
  DAY(whn),
  confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new_cases
  FROM covid
  WHERE name = 'Italy' AND MONTH(whn) = 3 ORDER BY whn;

SELECT name,
  DATE_FORMAT(whn, '%Y-%m-%d'),
  confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER by whn) AS new_cases
  FROM covid
  WHERE name = 'Italy' AND WEEKDAY(whn) = 0 ORDER BY whn;

--Exercice 13:

SELECT count(id) AS Total_stops FROM stops;

SELECT id FROM stops WHERE name = 'Craiglockhart';

SELECT id, name FROM stops JOIN route ON stop = id WHERE num = 4 AND company = 'LRT' ORDER BY pos;

SELECT company, num, COUNT(*)
  FROM route WHERE stop = 149 OR stop = 53
  GROUP BY company, num HAVING COUNT(*) > 1;

SELECT a.company, a.num, a.stop, b.stop
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE a.stop = 53 AND b.stop = (SELECT id FROM stops WHERE name = 'London Road');

SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
    JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
  WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';

SELECT DISTINCT a.company, a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE a.stop = 115 AND b.stop = 137;

SELECT a.company, a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
    AND b.stop = (SELECT id FROM stops WHERE name = 'Tollcross');

SELECT DISTINCT name, a.company, a.num
  FROM route a
    JOIN route b ON (a.company = b.company AND a.num = b.num)
    JOIN stops ON a.stop = stops.id
  WHERE b.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart');

SELECT b.num, b.company, stops.name, d.num, d.company
  FROM route a
    JOIN route b ON a.num = b.num AND a.company = b.company
    JOIN (route c JOIN route d ON c.num = d.num AND c.company = d.company)
    JOIN stops ON b.stop = stops.id
  WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
    AND c.stop = (SELECT id FROM stops WHERE name = 'Lochend')
    AND b.stop = d.stop ORDER BY b.num, b.company, stops.name, d.num;

