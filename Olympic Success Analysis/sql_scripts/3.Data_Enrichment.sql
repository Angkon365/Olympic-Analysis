--Detailed Next Steps with SQL Queries
-- Correlate medal count with population and GDP for a given year
SELECT
    ae.NOC,
    COUNT(ae.Medal) AS TotalMedals,
    cs.Population,
    cs.GDP
FROM athlete_events AS ae
JOIN Country_Stats AS cs ON ae.NOC = cs.NOC AND ae.Year = cs.Year
WHERE ae.Year = 2016 AND ae.Medal IS NOT NULL
GROUP BY ae.NOC, cs.Population, cs.GDP
ORDER BY TotalMedals DESC;

-- Analyze "host country advantage" by comparing medals won as host vs. non-host
SELECT
    ae.NOC,
    (SELECT COUNT(*) FROM athlete_events WHERE Medal IS NOT NULL AND NOC = ae.NOC AND Games IN (SELECT Games FROM Host_Cities WHERE Host_NOC = ae.NOC)) AS MedalsAsHost,
    (SELECT COUNT(*) FROM athlete_events WHERE Medal IS NOT NULL AND NOC = ae.NOC AND Games NOT IN (SELECT Games FROM Host_Cities WHERE Host_NOC = ae.NOC)) AS MedalsAsGuest
FROM athlete_events AS ae
GROUP BY ae.NOC
ORDER BY MedalsAsHost DESC;

-- Show the evolution of average age for Gymnastics medalists
SELECT
    Year,
    AVG(Age) AS AverageAge,
    AVG(Height) AS AverageHeight,
    AVG(Weight) AS AverageWeight
FROM athlete_events
WHERE Sport = 'Gymnastics' AND Medal IS NOT NULL
GROUP BY Year
ORDER BY Year ASC;


--Identify which NOCs are dominant in which specific sports.

-- Find the top 5 countries in Fencing by medal count
SELECT TOP 5
    NOC,
    COUNT(Medal) AS MedalCount
FROM athlete_events
WHERE Sport = 'Fencing' AND Medal IS NOT NULL
GROUP BY NOC
ORDER BY MedalCount DESC;


--Time-Series and Era Analysis:

--Divide the dataset into distinct historical periods to analyze shifts in medal distribution.

-- Compare medal distribution between two eras for Athletics
SELECT
    CASE
        WHEN Year < 1980 THEN 'Pre-1980'
        ELSE 'Post-1980'
    END AS Era,
    NOC,
    COUNT(Medal) AS MedalCount
FROM athlete_events
WHERE Sport = 'Athletics' AND Medal IS NOT NULL
GROUP BY
    CASE
        WHEN Year < 1980 THEN 'Pre-1980'
        ELSE 'Post-1980'
    END,
    NOC
ORDER BY Era, MedalCount DESC;


--Hypothesis-Driven Querying:

--Answer the additional questions identified.

--(Female vs. Male):

-- Compare medal counts for men and women in Swimming for the USA
SELECT
    Sex,
    COUNT(Medal) AS MedalCount
FROM athlete_events
WHERE NOC = 'USA' AND Sport = 'Swimming' AND Medal IS NOT NULL
GROUP BY Sex;

 --("Golden Eras"):

-- Find the most successful decade for Italy in Fencing
SELECT
    (Year / 10) * 10 AS Decade,
    COUNT(Medal) AS MedalCount
FROM athlete_events
WHERE NOC = 'ITA' AND Sport = 'Fencing' AND Medal IS NOT NULL
GROUP BY (Year / 10) * 10
ORDER BY MedalCount DESC;


--Physical Attributes vs. Medals
-- Compare average physical stats of medalists vs. non-medalists in the 100m Dash
SELECT
    CASE
        WHEN Medal IS NOT NULL THEN 'Medalist'
        ELSE 'Non-Medalist'
    END AS Status,
    AVG(Age) AS AverageAge,
    AVG(Height) AS AverageHeight,
    AVG(Weight) AS AverageWeight
FROM athlete_events
WHERE Event = 'Athletics Men''s 100 metres'
GROUP BY
    CASE
        WHEN Medal IS NOT NULL THEN 'Medalist'
        ELSE 'Non-Medalist'
    END;

/*3. Advanced Analysis: Next Steps
This section outlines the next phase of the project, focusing on deeper statistical analysis, broader feature exploration, and the creation of new, insightful metrics.

Dive Deeper: Correlation and Regression
We will now move beyond descriptive statistics to investigate the relationships between variables.

Identified Correlations:

Height and Basketball Medals: A clear positive correlation exists between an athlete's height and their likelihood of winning a medal in Basketball. Taller players have a distinct advantage, and this relationship is one of the strongest and most intuitive in the dataset.

Age and Gymnastics Medals: There is a strong negative correlation between age and winning medals in Gymnastics. The sport favours younger, more agile athletes, and the data shows that medal winners are consistently younger than the average participant.

SQL for Correlation Analysis (Height in Basketball):
While SQL is not the ideal tool for calculating a Pearson correlation coefficient directly, we can calculate the necessary components. This query compares the average height of medalists vs. non-medalists in basketball, which serves as a strong proxy for correlation.

--Compare the average height of medalists vs. non-medalists in Basketball
SELECT
    CASE
        WHEN Medal IS NOT NULL THEN 'Medalist'
        ELSE 'Non-Medalist'
    END AS Status,
    AVG(Height) AS AverageHeight,
    COUNT(*) AS NumberOfAthletes
FROM
    athlete_events
WHERE
    Sport = 'Basketball'
GROUP BY
    CASE
        WHEN Medal IS NOT NULL THEN 'Medalist'
        ELSE 'Non-Medalist'
    END;

Future Prediction (Linear Regression):
The strong linear relationship between certain physical attributes and success in specific sports suggests that linear regression could be a valuable predictive tool. For example, we could build a model to predict the probability of winning a medal based on Age, Height, and Weight for a given sport. This analysis is best performed in a statistical environment like Python or R, using the data extracted from our SQL database.

Go Broader: Expanding Feature Analysis
Our initial analysis and descriptive stats point to new avenues for exploration.

What Jumps Out Now?
The Event column is a rich, underutilized feature. Analysis so far has focused on the Sport level (e.g., "Athletics"), but drilling down into the specific event (e.g., "Athletics Men's 100 metres") will provide much more granular and actionable insights. We can analyze which specific events yield the most medals for each country.

Text Analysis of Events:
The Event names themselves contain valuable data. We can perform a textual analysis to identify key terms (e.g., "Men's", "Women's", "Freestyle", "4x100m Relay"). By analyzing the frequency of these terms, we can identify themes, such as the growth of women's sports over time or the prevalence of team-based events in the Summer vs. Winter games. While a full TF-IDF analysis is better suited for Python, we can perform a basic term frequency count in SQL.

-- Count the frequency of key terms in event names for medal winners
SELECT 'Women''s Events' AS Term, COUNT(*) FROM athlete_events WHERE Event LIKE '%Women''s%' AND Medal IS NOT NULL
UNION ALL
SELECT 'Men''s Events' AS Term, COUNT(*) FROM athlete_events WHERE Event LIKE '%Men''s%' AND Medal IS NOT NULL
UNION ALL
SELECT 'Team Relays' AS Term, COUNT(*) FROM athlete_events WHERE Event LIKE '%Relay%' AND Medal IS NOT NULL;

New Metrics for Deeper Insight
To better understand performance, we will create two new metrics.

New Metric: "Medal Conversion Rate"

Why: Simply counting total medals favours larger countries that send more athletes. The Medal Conversion Rate measures efficiency: (Total Medals Won / Total Participations). A high rate indicates that a country is highly effective at turning its Olympic appearances into podium finishes.

SQL to Calculate:

-- Calculate Medal Conversion Rate for the top 15 medal-winning countries
SELECT TOP 15
    NOC,
    COUNT(CASE WHEN Medal IS NOT NULL THEN 1 END) AS TotalMedals,
    COUNT(*) AS TotalParticipations,
    (CAST(COUNT(CASE WHEN Medal IS NOT NULL THEN 1 END) AS FLOAT) / COUNT(*)) * 100 AS MedalConversionRate
FROM
    athlete_events
GROUP BY
    NOC
HAVING
    COUNT(*) > 1000 -- Only include countries with significant participation
ORDER BY
    MedalConversionRate DESC;

New Metric: "Athlete Versatility Index"

Why: Some athletes are specialists, while others display incredible versatility by competing in multiple sports or disciplines. This metric, calculated as the COUNT(DISTINCT Sport) For each athlete, it allows us to identify and celebrate these unique individuals.

SQL to Calculate:

-- Find the most versatile athletes who have competed in the most distinct sports
SELECT TOP 10
    Name,
    Team,
    COUNT(DISTINCT Sport) AS VersatilityIndex
FROM
    athlete_events
GROUP BY
    Name, Team
ORDER BY
    VersatilityIndex DESC;*/

--Visualization Strategy:

--Begin planning how to visualize the findings best. The SQL queries above provide the direct data sources needed for these visualizations. For example, the "Golden Eras" query can populate a bar chart showing medals per decade, and the query for analyzing age trends can be used to create a line chart.

-- This script reframes the three core hypotheses into an A/B testing
-- framework. Each query defines two groups (A and B) and calculates a
-- key metric to compare between them, simulating an A/B test on
-- historical data.

--------------------------------------------------------------------------------
-- Hypothesis 1: A/B Test for Economic Impact on Medal Count
--------------------------------------------------------------------------------

-- Test: Do countries with higher GDP (Group B) win significantly more medals
-- than countries with lower GDP (Group A)?

-- Group A: Countries with a GDP below the median for the 2016 games.
-- Group B: Countries with a GDP at or above the median for the 2016 games.
-- Metric: Average number of medals won per country in each group.

WITH GDP_Median AS (
    -- First, calculate the median GDP for all countries that won at least one medal in 2016
    SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY GDP) OVER () as MedianGDP
    FROM Country_Stats
    WHERE Year = 2016 AND NOC IN (SELECT DISTINCT NOC FROM athlete_events WHERE Year = 2016 AND Medal IS NOT NULL)
),
MedalCounts AS (
    -- Count medals for each country in 2016
    SELECT NOC, COUNT(Medal) as MedalCount
    FROM athlete_events
    WHERE Year = 2016 AND Medal IS NOT NULL
    GROUP BY NOC
)
-- Now, assign each country to Group A or Group B and calculate the average medal count
SELECT
    CASE
        WHEN cs.GDP < (SELECT DISTINCT MedianGDP FROM GDP_Median) THEN 'Group A (Below Median GDP)'
        ELSE 'Group B (Above Median GDP)'
    END AS GDP_Group,
    COUNT(DISTINCT mc.NOC) AS NumberOfCountries,
    AVG(CAST(mc.MedalCount AS FLOAT)) AS AvgMedalsPerCountry
FROM
    MedalCounts mc
JOIN
    Country_Stats cs ON mc.NOC = cs.NOC AND cs.Year = 2016
GROUP BY
    CASE
        WHEN cs.GDP < (SELECT DISTINCT MedianGDP FROM GDP_Median) THEN 'Group A (Below Median GDP)'
        ELSE 'Group B (Above Median GDP)'
    END;


--------------------------------------------------------------------------------
-- Hypothesis 2: A/B Test for Athlete Age Evolution
--------------------------------------------------------------------------------

-- Test: Is the average age of medalists in physically demanding sports
-- significantly lower in the modern era (Group B) compared to the older era (Group A)?

-- Group A: Medalists in 'Physically Demanding' sports from 1960-1988.
-- Group B: Medalists in 'Physically Demanding' sports from 1992-2016.
-- Metric: Average age of medalists in each group.

SELECT
    CASE
        WHEN Year <= 1988 THEN 'Group A (1960-1988)'
        ELSE 'Group B (1992-2016)'
    END AS Era,
    AVG(Age) AS AverageAgeOfMedalists,
    STDEV(Age) AS AgeStandardDeviation,
    COUNT(*) AS NumberOfMedalists
FROM
    athlete_events
WHERE
    Medal IS NOT NULL
    AND Sport IN ('Gymnastics', 'Swimming', 'Diving') -- Defining 'Physically Demanding'
    AND Year >= 1960
GROUP BY
    CASE
        WHEN Year <= 1988 THEN 'Group A (1960-1988)'
        ELSE 'Group B (1992-2016)'
    END;


--------------------------------------------------------------------------------
-- Hypothesis 3: A/B Test for Globalization of Sport
--------------------------------------------------------------------------------

-- Test: Are emerging regions (Group B) diversifying their medal wins across
-- more sports at a faster rate than established regions (Group A)?

-- Group A: 'Western Powers' region.
-- Group B: 'Asia' region.
-- Metric: The average number of unique sports a country from that region wins
--         medals in, compared between two eras.

WITH RegionalSportDiversity AS (
    SELECT
        CASE
            WHEN Year < 1980 THEN 'Era 1 (Pre-1980)'
            ELSE 'Era 2 (Post-1980)'
        END AS Era,
        CASE
            WHEN NOC IN ('USA', 'GBR', 'FRA', 'GER', 'ITA', 'CAN', 'AUS') THEN 'Group A (Western Powers)'
            WHEN NOC IN ('CHN', 'JPN', 'KOR', 'IND') THEN 'Group B (Asia)'
        END AS Region,
        NOC,
        COUNT(DISTINCT Sport) AS UniqueSportsWithMedals
    FROM
        athlete_events
    WHERE
        Medal IS NOT NULL
        AND NOC IN ('USA', 'GBR', 'FRA', 'GER', 'ITA', 'CAN', 'AUS', 'CHN', 'JPN', 'KOR', 'IND')
    GROUP BY
        Era, Region, NOC
)
SELECT
    Era,
    Region,
    AVG(CAST(UniqueSportsWithMedals AS FLOAT)) AS AvgUniqueSportsPerCountry
FROM
    RegionalSportDiversity
WHERE
    Region IS NOT NULL
GROUP BY
    Era,
    Region
ORDER BY
    Region, Era;
