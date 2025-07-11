-- This script creates the Country_Stats table and populates it with data
-- sourced from the World Bank. This provides a more accurate basis for
-- correlating Olympic performance with national statistics.

-- 1. CREATE the Country_Stats table with a composite primary key
-- This ensures that each country has a unique entry per year.
CREATE TABLE Country_Stats (
    NOC VARCHAR(3),            -- National Olympic Committee code
    Year INT,                  -- Year of the data
    Population BIGINT,         -- Total population of the country
    GDP BIGINT,                -- Gross Domestic Product in current USD
    PRIMARY KEY (NOC, Year)    -- Composite key
);

-- 2. INSERT data sourced from the World Bank
-- Data for key countries and Olympic years.

-- Data for the 2016 Olympic Year
INSERT INTO Country_Stats (NOC, Year, Population, GDP) VALUES
('USA', 2016, 323071755, 18745075000000), -- United States
('CHN', 2016, 1378665000, 11233277442320),-- China
('GBR', 2016, 65595563, 2709229551365),  -- Great Britain
('RUS', 2016, 144342396, 1282723549915),  -- Russia
('GER', 2016, 82348669, 3467482059021),  -- Germany
('JPN', 2016, 126994511, 5003678333333),  -- Japan
('FRA', 2016, 66859768, 2471285558266),  -- France
('CAN', 2016, 36264604, 1527939990381),  -- Canada
('AUS', 2016, 24210809, 1206562612425),  -- Australia
('ITA', 2016, 60627498, 1909437804499),  -- Italy
('KOR', 2016, 51245707, 1500111949001),  -- South Korea
('BRA', 2016, 207847528, 1793989287955),  -- Brazil
('NED', 2016, 17018408, 777227539683),   -- Netherlands
('ESP', 2016, 46484099, 1237255149390);  -- Spain

-- Data for the 2012 Olympic Year
INSERT INTO Country_Stats (NOC, Year, Population, GDP) VALUES
('USA', 2012, 313877662, 16253970000000),-- United States
('CHN', 2012, 1354040000, 8532231008249), -- China
('GBR', 2012, 63700300, 2714571118521),  -- Great Britain
('RUS', 2012, 143201675, 2208294000000),  -- Russia
('GER', 2012, 80425823, 3527143370786),  -- Germany
('JPN', 2012, 127515000, 6203213121212),  -- Japan
('FRA', 2012, 65659789, 2683825189171),  -- France
('CAN', 2012, 34714000, 1828368866337),  -- Canada
('AUS', 2012, 22742475, 1546151921870),  -- Australia
('ITA', 2012, 59539717, 2087073428571),  -- Italy
('KOR', 2012, 50004441, 1305604204451),  -- South Korea
('BRA', 2012, 200560983, 2465189049382),  -- Brazil
('NED', 2012, 16754962, 839049488183),   -- Netherlands
('ESP', 2012, 46773083, 1336019131637);  -- Spain

-- Data for the 2008 Olympic Year
INSERT INTO Country_Stats (NOC, Year, Population, GDP) VALUES
('USA', 2008, 304093966, 14769862000000),-- United States
('CHN', 2008, 1324655000, 4598205942060), -- China
('GBR', 2008, 61824400, 2933964964965),  -- Great Britain
('RUS', 2008, 142742361, 1660844237288),  -- Russia
('GER', 2008, 82110097, 3752366000000),  -- Germany
('JPN', 2008, 128063000, 5037908493562),  -- Japan
('FRA', 2008, 64374979, 2930302158273),  -- France
('CAN', 2008, 33247117, 1552998899510),  -- Canada
('AUS', 2008, 21262641, 1060447204403),  -- Australia
('ITA', 2008, 58834677, 2390729000000),  -- Italy
('KOR', 2008, 49182038, 1002219903421),  -- South Korea
('BRA', 2008, 192979029, 1695855073282),  -- Brazil
('NED', 2008, 16445593, 893967520000),   -- Netherlands
('ESP', 2008, 45958367, 1635015000000);  -- Spain

-- Data for the 2004 Olympic Year
INSERT INTO Country_Stats (NOC, Year, Population, GDP) VALUES
('USA', 2004, 292805298, 12213730000000),-- United States
('CHN', 2004, 1296075000, 1955347293582), -- China
('GBR', 2004, 59944536, 2492484000000),  -- Great Britain
('RUS', 2004, 143809500, 591012500000),  -- Russia
('GER', 2004, 82516265, 2853310000000),  -- Germany
('JPN', 2004, 127761000, 4802113000000),  -- Japan
('FRA', 2004, 62704514, 2141441000000),  -- France
('CAN', 2004, 31940733, 1023240000000),  -- Canada
('AUS', 2004, 20029316, 695339000000),  -- Australia
('ITA', 2004, 57715225, 1863553000000),  -- Italy
('KOR', 2004, 48039988, 765427000000),  -- South Korea
('BRA', 2004, 184534066, 669319000000),  -- Brazil
('NED', 2004, 16281851, 624559000000),   -- Netherlands
('ESP', 2004, 42691792, 1070200000000);  -- Spain

-- Data for the 2000 Olympic Year
INSERT INTO Country_Stats (NOC, Year, Population, GDP) VALUES
('USA', 2000, 281710909, 10252347000000),-- United States
('CHN', 2000, 1262645000, 1211346749673), -- China
('GBR', 2000, 58892514, 1662366000000),  -- Great Britain
('RUS', 2000, 146596647, 259708000000),  -- Russia
('GER', 2000, 82211508, 1949954000000),  -- Germany
('JPN', 2000, 126843000, 4887413000000),  -- Japan
('FRA', 2000, 60912386, 1373742000000),  -- France
('CAN', 2000, 30685730, 744426000000),  -- Canada
('AUS', 2000, 19053186, 415834000000),  -- Australia
('ITA', 2000, 56942108, 1162399000000),  -- Italy
('KOR', 2000, 46829000, 561633000000),  -- South Korea
('BRA', 2000, 174790340, 655421000000),  -- Brazil
('NED', 2000, 15925574, 409939000000),   -- Netherlands
('ESP', 2000, 40582294, 633333000000);  -- Spain

-- Data for the 1996 Olympic Year
INSERT INTO Country_Stats (NOC, Year, Population, GDP) VALUES
('USA', 1996, 269394000, 8073122000000), -- United States
('CHN', 1996, 1223890000, 863747000000),  -- China
('GBR', 1996, 58164000, 1292829000000),  -- Great Britain
('RUS', 1996, 148166000, 391724000000),  -- Russia
('GER', 1996, 81897000, 2500000000000),  -- Germany
('JPN', 1996, 125757000, 4833238000000),  -- Japan
('FRA', 1996, 59695000, 1592437000000),  -- France
('CAN', 1996, 29611000, 631089000000),  -- Canada
('AUS', 1996, 18283000, 401053000000),  -- Australia
('ITA', 1996, 57343000, 1346371000000),  -- Italy
('KOR', 1996, 45525000, 585325000000),  -- South Korea
('BRA', 1996, 162662000, 785899000000),  -- Brazil
('NED', 1996, 15527000, 439077000000),   -- Netherlands
('ESP', 1996, 39754000, 642284000000);  -- Spain

--verify the data by running a SELECT statement
--SELECT * FROM Country_Stats;
