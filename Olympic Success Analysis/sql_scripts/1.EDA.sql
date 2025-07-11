---- View the first 20 rows to understand the table structure and data types
SELECT TOP 20 * 
FROM athlete_events

-- Get the total number of records =2,71,116
SELECT COUNT(*) AS total_records
FROM athlete_events

-- Count Total athletes=135571
SELECT COUNT(DISTINCT ID) AS Total_Athletes
FROM athlete_events

-- Count total unique sports=66
SELECT COUNT(DISTINCT Sport) AS Total_Sport
FROM athlete_events

-- List all unique sports
SELECT DISTINCT Sport
FROM athlete_events

-- List all unique season=2
SELECT DISTINCT Season
FROM athlete_events
ORDER BY Season;

--Range of Years Covered =2016/1896

SELECT MAX(Year) AS Latest_Year,
 MIN(Year) AS Last_Year
FROM athlete_events

-- Count the distribution of medals = NA-231333,Gold-13372,Bronze-13295,Silver-13116
SELECT Medal,
COUNT(*) AS Medal_count 
FROM athlete_events
GROUP BY Medal
ORDER BY Medal_count DESC

-- Calculate average age, height, and weight of participants-Age 25.055,Height-175.371,Weight-70.688
SELECT 
	   AVG(Age) AS Average_Age,
	   AVG(Height) AS Average_Height,
	   AVG(Weight) AS Average_Weight 
FROM athlete_events
WHERE Age IS NOT NULL AND Height IS NOT NULL AND Weight IS NOT NULL

-- Top 10 National Olympic Committees (NOCs) by total medal count= 1.USA,2.FRA,3.GBR....
SELECT TOP 10 NOC,
	   COUNT(*) AS Best
FROM athlete_events
WHERE Medal IS NOT NULL
GROUP BY NOC
ORDER BY Best DESC

--Playing with Data
--Clean the data--deal with NULLS-replace with average for numeric values like age height and weight

SELECT *
FROM athlete_events

--NULL Values
SELECT
COUNT (*) AS Total,
COUNT(*)-COUNT(Height) AS Null_Height,
COUNT(*)-COUNT(Age) AS Null_Age,
COUNT(*)-COUNT(Weight) AS Null_Weight
FROM athlete_events
--WHERE Age IS NULL 


--Sports in which USA won medal (58 out of 66)
SELECT DISTINCT Sport
FROM athlete_events
WHERE Medal IS NOT NULL AND NOC ='USA'


--NOC 230 but total team count is 1184
SELECT COUNT (DISTINCT Team) AS Total
FROM athlete_events

--Team names.....some weird team names like alibabaXI,Rambo won medal? others are understandable like Japan 1 and Japan 2...where two or more teams more Japan participate in same event
SELECT  Team,
	   COUNT(*) AS Total
FROM athlete_events
WHERE Medal IS NOT NULL 
GROUP BY Team
ORDER BY Total ASC

--Finding out where Team Rambo won medal
SELECT Sport,
	   YEAR,
	   Event
FROM athlete_events
WHERE TEAM ='RAMBO'

--Starting with Cleaning the data 
--1.Identify Null Values for Age/Weight/height and replacing them with average values as counted before (Age 25.055,Height-175.371,Weight-70.688) for Numeric values except year offcourse

SELECT 
	   AVG(Age) AS Average_Age,
	   AVG(Height) AS Average_Height,
	   AVG(Weight) AS Average_Weight 
FROM athlete_events
WHERE Age IS NOT NULL AND Height IS NOT NULL AND Weight IS NOT NULL

UPDATE athlete_events
SET Age = 25.0555089370165
WHERE Age is NULL;

UPDATE athlete_events
SET Height = 175.371949651978
WHERE Height is NULL;

UPDATE athlete_events
SET Weight = 70.6883370116169
WHERE Weight is NULL;

--Null values for non-numerica Data except Medals as NA means not 1st,2nd or 3rd place finish in event-------------0 null values..
SELECT
COUNT (*) AS Total,
COUNT(*)-COUNT(Name) AS Null_Name,
COUNT(*)-COUNT(Sex) AS Null_Sex,
COUNT(*)-COUNT(Team) AS Null_Team,
COUNT(*)-COUNT(NOC) AS Null_NOC,
COUNT(*)-COUNT(Games) AS Null_Games,
COUNT(*)-COUNT(Year) AS Null_Year,
COUNT(*)-COUNT(Season) AS Null_Season,
COUNT(*)-COUNT(City) AS Null_City,
COUNT(*)-COUNT(Sport) AS Null_Sport,
COUNT(*)-COUNT(Event) AS Null_Event
FROM athlete_events

--2.Identifying Duplicate Data
SELECT Id,
	   Name,
       Sex,
	   Age,
	   Height,
	   Weight,
	   Team,
	   NOC,
	   Games,
	   Year,
	   Season,
	   City,
	   Sport,
	   Event,
	   Medal,
	   COUNT(*) AS Duplicates
FROM athlete_events
GROUP BY Id,
       Name,
       Sex,
	   Age,
	   Height,
	   Weight,
	   Team,
	   NOC,
	   Games,
	   Year,
	   Season,
	   City,
	   Sport,
	   Event,
	   Medal
HAVING COUNT(*) > 1 

--Deleting Duplicate data using CTE -1385 Rows affected
--Checking
WITH CTE_Duplicates AS (
    SELECT
        Id, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal,
        ROW_NUMBER() OVER (
            PARTITION BY Id, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal
            ORDER BY Id 
        ) as rn
    FROM athlete_events
        
)
SELECT * -- See which rows would be marked for deletion
FROM CTE_Duplicates
WHERE rn > 1;

--Deleting

WITH CTE_Duplicates AS (
    SELECT
        Id,
        Name,
        Sex,
        Age,
        Height,
        Weight,
        Team,
        NOC,
        Games,
        Year,
        Season,
        City,
        Sport,
        Event,
        Medal,
        ROW_NUMBER() OVER (
            PARTITION BY
                Id, Name, Sex, Age, Height, Weight, Team, NOC, Games, Year, Season, City, Sport, Event, Medal
            ORDER BY Id    
        ) as rn
    FROM
        athlete_events
)
DELETE FROM CTE_Duplicates
WHERE rn > 1;


-- Get the total number of records Raw Data=2,71,116 and now it is 2,69,731
SELECT COUNT(*) AS total_records
FROM athlete_events

--3.Fixing Data Type Inconsistencies like if a column is storing numbers as text, or dates in an incorrect format.
Select *
From athlete_events
--None Visible

--4. Standardizing Data Formats like Trim Whitespace: Remove leading/trailing spaces/Case issues/Date formats/Synonyms/Spelling Mistake
Select *
From athlete_events
--None Visible

--5.Correcting Invalid Data (Outliers, Incorrect Values) like Update Incorrect Values: Based on business rules or external data-----No entries with negative value
SELECT Age,
	   Height,
	   Weight
FROM athlete_events
WHERE Age <= 0 OR Height <=0 OR Weight <=0

--Database is exported to Excel as Cleaned.xlsx

