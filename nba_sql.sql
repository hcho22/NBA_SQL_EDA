-- NBA player stats from 1996 ~ 2022 seasons
SELECT*
FROM NBA

-- Add new column call total points per season
ALTER TABLE NBA
ADD TotalSeasonPoints INT;

UPDATE NBA
SET TotalSeasonPoints = gp * pts


-- Top 5 players with total number of points. 
SELECT
	TOP 5 player_name,
	SUM(TotalSeasonPoints) AS TotalCareerPoints
FROM 
	NBA
GROUP BY
	player_name
ORDER BY
	TotalCareerPoints DESC;

-- Add new column call total assists per season
ALTER TABLE NBA
ADD TotalSeasonAssists INT;

UPDATE NBA
SET TotalSeasonAssists= gp * ast

-- Top 5 players with total number of assists. 
SELECT
	TOP 5 player_name,
	SUM(TotalSeasonAssists) AS TotalCareerAssists
FROM 
	NBA
WHERE
	TotalSeasonAssists IS NOT NULL
GROUP BY
	player_name
ORDER BY
	TotalCareerAssists DESC;

-- Add new column call total rebounds per season
ALTER TABLE NBA
ADD TotalSeasonRebounds INT;

UPDATE NBA
SET TotalSeasonRebounds= gp * reb

-- Top 5 players with total number of rebounds. 
SELECT
	TOP 5 player_name,
	SUM(TotalSeasonRebounds) AS TotalCareerRebounds
FROM 
	NBA
GROUP BY
	player_name
ORDER BY
	TotalCareerRebounds DESC;

-- Add column for usg per game.
ALTER TABLE NBA
ADD usg_per_game INT;

UPDATE NBA
SET usg_per_game = gp * reb

-- Top 5 players with most usage. 
SELECT
	TOP 10 player_name,
	AVG(usg_pct) AS Average_usg,
	SUM(TotalSeasonPoints) AS TotalPoints,
FROM 
	NBA
GROUP BY
	player_name
ORDER BY
	TotalPoints DESC, Average_usg DESC


SELECT *
FROM NBA

-- Top 10 players within first 5 years of draft. 
WITH FirstFiveYears AS (
	SELECT
		player_name,
		usg_pct, 
		TotalSeasonPoints,
		gp,
		season,
		draft_year,
		CAST(LEFT(season, 4) AS INT) AS season_start,
		(CAST(LEFT(season, 4) AS INT) - draft_year) AS YearsSinceDraft
	FROM
		NBA
	WHERE
		(CAST(LEFT(season,4) AS INT) - draft_year) < 5
)
SELECT
	Top 10 player_name,
	AVG(usg_pct) AS Average_usg,
	AVG(CAST(TotalSeasonPoints AS FLOAT) / gp) AS AveragePointsPerGame
FROM
	FirstFiveYears
GROUP BY
	player_name
ORDER BY
	AveragePointsPerGame DESC, Average_usg DESC;
