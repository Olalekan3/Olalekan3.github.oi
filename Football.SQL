USE [master]
GO

SELECT [Year]
      ,[Team]
      ,[NAME ]
      ,[No#]
      ,[Pos]
      ,[Ht]
      ,[Wt]
      ,[Age]
      ,[Exp]
      ,[College]
      ,[FirstName]
      ,[LastName]
      ,[Ft]
      ,[In]
      ,[Inches]
      ,[NumGrp]
  FROM [dbo].['Football Players Data$']


  --Part One


 --Q1. Write a query to find all the players in the "Arizona" team.

 SELECT Name
FROM Players
WHERE Team = 'Arizona';

--Q2. Write a query to find all the players who play as a "WR" (Wide Receiver).

SELECT Name
FROM Players
WHERE Position = 'WR';

--Q3. Write a query to list all players taller than 6 feet 2 inches.

SELECT Name, Ht_ft, Ht_in
FROM Players
WHERE (Ht_ft * 12 + Ht_in) > 74;

--Q4. Write a query to find all players who attended the "Washington" college.

SELECT Name
FROM Players
WHERE College = 'Washington';

--Q5. Write a query to list players who are 25 years old or younger.
 
SELECT Name, Age
FROM Players
WHERE Age <= 25;

--Q6. Write a query to find all players with missing Age data.

SELECT Name
FROM Players
WHERE Age IS NULL

--Q7. Write a query to find players who are rookies (Exp = 'R').

SELECT Name
FROM Players
WHERE Exp = 'R';

--Q8. Write a query to find the tallest player on the "New Orleans" team.

SELECT Name, Ht_ft, Ht_in
FROM Players
WHERE Team = 'New Orleans'
ORDER BY (Ht_ft * 12 + Ht_in) DESC
LIMIT 1;

--Q9. Write a query to find players weighing more than 250 pounds.

SELECT Name, Weight
FROM Players
WHERE Weight > 250;

--Q10. Write a query to calculate the average height of players at each position.

SELECT
    Position,
    AVG(Ht_ft * 12 + Ht_in) AS Avg_Height_Inches
FROM Players
GROUP BY Position;


--Part Two


--Q1. Write a query to find the heaviest player for each position.

SELECT
    P.Name,
    P.Position,
    P.Weight
FROM
    Players P
INNER JOIN (
    SELECT
        Position,
        MAX(Weight) AS Max_Weight
    FROM
        Players
    GROUP BY
        Position
) AS MaxWeights ON P.Position = MaxWeights.Position AND P.Weight = MaxWeights.Max_Weight;

--Q2. Write a query to rank players by age within their team. If two players have the same age, rank them by their weight.

SELECT
    Team,
    Name,
    Age,
    Weight,
    DENSE_RANK() OVER (PARTITION BY Team ORDER BY Age ASC, Weight DESC) AS Team_Age_Rank
FROM
    Players
ORDER BY
    Team, Team_Age_Rank;

--Q3. Write a query to calculate the average height (in inches) for all players older than 25 years.

SELECT
    AVG(Ht_ft * 12 + Ht_in) AS Average_Height_Inches
FROM
    Players
WHERE
    Age > 25;

--Q4. Write a query to find all players whose height is greater than the average height of their respective team.

SELECT
    P.Name,
    P.Team,
    (P.Ht_ft * 12 + P.Ht_in) AS Player_Height_Inches
FROM
    Players P
INNER JOIN (
    SELECT
        Team,
        AVG(Ht_ft * 12 + Ht_in) AS Avg_Team_Height
    FROM
        Players
    GROUP BY
        Team
) AS TeamAverages ON P.Team = TeamAverages.Team
WHERE
    (P.Ht_ft * 12 + P.Ht_in) > TeamAverages.Avg_Team_Height;

--Q5. Write a query to find all players who share the same last name.

SELECT
    Name
FROM
    Players
GROUP BY
    SUBSTRING_INDEX(Name, ' ', -1) -- Gets the part after the last space (the last name)
HAVING
    COUNT(*) > 1; -- Ensures the last name appears more than once

--Q6. Write a query to find the players with the minimum height for each position.

SELECT
    P.Name,
    P.Position,
    (P.Ht_ft * 12 + P.Ht_in) AS Min_Height_Inches
FROM
    Players P
INNER JOIN (
    SELECT
        Position,
        MIN(Ht_ft * 12 + Ht_in) AS Min_Height
    FROM
        Players
    GROUP BY
        Position
) AS MinHeights ON P.Position = MinHeights.Position
AND (P.Ht_ft * 12 + P.Ht_in) = MinHeights.Min_Height;

--Q7. Write a query to get the number of players for each team grouped by their experience level.

SELECT
    Team,
    Exp,
    COUNT(Name) AS Number_of_Players
FROM
    Players
GROUP BY
    Team, Exp
ORDER BY
    Team, Exp;

--Q8. Write a query to find the tallest and shortest players from each college.

WITH College_Heights AS (
    SELECT
        College,
        Name,
        (Ht_ft * 12 + Ht_in) AS Total_Height_Inches,
        MAX(Ht_ft * 12 + Ht_in) OVER (PARTITION BY College) AS Max_College_Height,
        MIN(Ht_ft * 12 + Ht_in) OVER (PARTITION BY College) AS Min_College_Height
    FROM
        Players
)
SELECT
    College,
    Name,
    Total_Height_Inches,
    CASE
        WHEN Total_Height_Inches = Max_College_Height THEN 'Tallest'
        WHEN Total_Height_Inches = Min_College_Height THEN 'Shortest'
        ELSE NULL
    END AS Height_Category
FROM
    College_Heights
WHERE
    Total_Height_Inches = Max_College_Height

--Q9. Write a query to find all players whose weight is above the average weight for their respective position.

SELECT
    P.Name,
    P.Position,
    P.Weight
FROM
    Players P
INNER JOIN (
    SELECT
        Position,
        AVG(Weight) AS Avg_Position_Weight
    FROM
        Players
    GROUP BY
        Position
) AS PositionAverages ON P.Position = PositionAverages.Position
WHERE
    P.Weight > PositionAverages.Avg_Position_Weight;

--Q10. Write a query to calculate the percentage of players in each position for every team.

SELECT
    Team,
    Position,
    COUNT(*) AS Players_in_Position,
    CAST(COUNT(*) AS DECIMAL) * 100 / SUM(COUNT(*)) OVER (PARTITION BY Team) AS Percentage_of_Team
FROM
    Players
GROUP BY
    Team, Position
ORDER BY
    Team, Percentage_of_Team DESC;





