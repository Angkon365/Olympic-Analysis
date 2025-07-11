--------------------------------------------------------------------------------
-- Hypothesis 1: A/B Test for Economic Impact on Medal Count
--------------------------------------------------------------------------------

-- Test: Do countries with higher GDP (Group B) win significantly more medals
-- than countries with lower GDP (Group A)?

-- Group A: Countries with a GDP below the median for the 2016 games.
-- Group B: Countries with a GDP at or above the median for the 2016 games.
-- Metric: Average number of medals won per country in each group.

WITH GDP_Median AS (
    -- This CTE calculates the median GDP. Using DISTINCT ensures it returns one row.
    SELECT DISTINCT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY GDP) OVER () as MedianGDP
    FROM
        Country_Stats
    WHERE
        Year = 2016 AND NOC IN (SELECT DISTINCT NOC FROM athlete_events WHERE Year = 2016 AND Medal IS NOT NULL)
),
MedalCounts AS (
    -- This CTE counts medals for each country in 2016.
    SELECT
        NOC,
        COUNT(Medal) as MedalCount
    FROM
        athlete_events
    WHERE
        Year = 2016 AND Medal IS NOT NULL
    GROUP BY
        NOC
)
SELECT
    -- This CASE statement now compares two columns, not a column and a subquery.
    CASE
        WHEN cs.GDP < gm.MedianGDP THEN 'Group A (Below Median GDP)'
        ELSE 'Group B (Above Median GDP)'
    END AS GDP_Group,
    COUNT(DISTINCT mc.NOC) AS NumberOfCountries,
    AVG(CAST(mc.MedalCount AS FLOAT)) AS AvgMedalsPerCountry
FROM
    MedalCounts mc
JOIN
    Country_Stats cs ON mc.NOC = cs.NOC AND cs.Year = 2016
CROSS JOIN 
    GDP_Median gm
GROUP BY
    CASE
        WHEN cs.GDP < gm.MedianGDP THEN 'Group A (Below Median GDP)'
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
        -- The GROUP BY clause is now corrected to use the full expressions, not the aliases.
        CASE
            WHEN Year < 1980 THEN 'Era 1 (Pre-1980)'
            ELSE 'Era 2 (Post-1980)'
        END,
        CASE
            WHEN NOC IN ('USA', 'GBR', 'FRA', 'GER', 'ITA', 'CAN', 'AUS') THEN 'Group A (Western Powers)'
            WHEN NOC IN ('CHN', 'JPN', 'KOR', 'IND') THEN 'Group B (Asia)'
        END,
        NOC
)
-- This final SELECT statement was already correct.
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