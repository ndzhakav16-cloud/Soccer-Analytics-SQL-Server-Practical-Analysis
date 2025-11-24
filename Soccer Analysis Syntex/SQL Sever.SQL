SELECT TOP (1000) [player_name]
      ,[team]
      ,[date_of_birth]
      ,[age]
      ,[marital_status]
      ,[number_of_kids]
      ,[nationality]
      ,[country_of_birth]
      ,[position]
      ,[preferred_foot]
      ,[height_cm]
      ,[weight_kg]
      ,[jersey_number]
      ,[injury_status]
      ,[agent]
      ,[matches_played]
      ,[minutes_played]
      ,[goals]
      ,[assists]
      ,[tackles]
      ,[interceptions]
      ,[saves]
      ,[clean_sheets]
      ,[yellow_cards]
      ,[red_cards]
      ,[passing_accuracy]
      ,[shot_accuracy]
      ,[previous_club]
      ,[years_at_club]
      ,[contract_end_year]
      ,[average_salary_zar]
      ,[market_value_zar]
      ,[signing_bonus_zar]
      ,[release_clause_zar]
  FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]

  ---- View the first 100 rows
  SELECT TOP (100) *
 FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY player_name;


--- Count the total number of players in the dataset
SELECT COUNT(*) AS TotalPlayers
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced];


--- List all unique teams in the league 
SELECT DISTINCT team
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE team IS NOT NULL
ORDER BY team;

--- Count how many players are in each team
SELECT team,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY PlayerCount DESC;


--- Identify the top 10 players with the most goals
SELECT TOP (10) player_name, team, goals, matches_played
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE goals IS NOT NULL
ORDER BY goals DESC, matches_played ASC;


--- Find the average salary for players in each team

SELECT team,
       AVG(average_salary_zar) AS AvgSalaryZAR,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY AvgSalaryZAR DESC;


---Retrieve the top 10 players with the highest market value

SELECT TOP (10) player_name, team, market_value_zar
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE market_value_zar IS NOT NULL
ORDER BY market_value_zar DESC;


--- Calculate the average passing accuracy for each position

SELECT position,
       AVG(passing_accuracy) AS AvgPassingAccuracy,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE passing_accuracy IS NOT NULL
GROUP BY position
ORDER BY AvgPassingAccuracy DESC;

---- 10.Compute total goals and assists for each team
SELECT 
    team,
    SUM(TRY_CAST(goals AS INT))   AS TotalGoals,
    SUM(TRY_CAST(assists AS INT)) AS TotalAssists,
    COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY team
ORDER BY TotalGoals DESC;



--Count players by their marital status

SELECT marital_status,
       COUNT(*) AS CountPlayers

FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY marital_status
ORDER BY CountPlayers DESC;

---Count players by nationality
SELECT nationality,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY nationality
ORDER BY PlayerCount DESC;

----Find average market value grouped by nationality
SELECT nationality,
       AVG(market_value_zar) AS AvgMarketValueZAR,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE market_value_zar IS NOT NULL
GROUP BY nationality
HAVING COUNT(*) > 0
ORDER BY AvgMarketValueZAR DESC;


---Determine how many player contracts end in each year


SELECT contract_end_year,
       COUNT(*) AS ContractsEnding

FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE contract_end_year IS NOT NULL
GROUP BY contract_end_year
ORDER BY contract_end_year;


---Identify players whose contracts end next year

SELECT player_name, team, contract_end_year, years_at_club

FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE contract_end_year = YEAR(GETDATE()) + 1
ORDER BY team, player_name;

----Summarize the number of players by injury status
SELECT injury_status,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
GROUP BY injury_status
ORDER BY PlayerCount DESC;

----Calculate goals per match ratio for each player

SELECT player_name, team, goals, matches_played,
       CASE
         WHEN matches_played IS NULL OR matches_played = 0 THEN NULL
         ELSE CAST(goals AS FLOAT) / NULLIF(matches_played,0)
       END AS GoalsPerMatch
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY GoalsPerMatch DESC;


----Count how many players are managed by each agent
SELECT agent,
       COUNT(*) AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE agent IS NOT NULL AND LTRIM(RTRIM(agent)) <> ''
GROUP BY agent
ORDER BY PlayerCount DESC;


---- Calculate average height and weight by player position

SELECT position,
       AVG(height_cm) AS AvgHeightCM,
       AVG(weight_kg) AS AvgWeightKG,
       COUNT(*)        AS PlayerCount
FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
WHERE height_cm IS NOT NULL OR weight_kg IS NOT NULL
GROUP BY position
ORDER BY AvgHeightCM DESC;


 ---- Identify players with the highest combined goals and assists
SELECT TOP (10) player_name, team, goals, assists,
       ISNULL(goals,0) + ISNULL(assists,0) AS GoalsPlusAssists

FROM [SoccerTeamDb1].[dbo].[ketro_sa_soccer_dataset_advanced]
ORDER BY GoalsPlusAssists DESC, goals DESC;
