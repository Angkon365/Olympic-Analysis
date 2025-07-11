-- This script creates the Host_Cities table and populates it with a
-- comprehensive list of all modern Olympic Games hosts.
-- This table is essential for analyzing the "host country advantage" by
-- joining it with the main athlete_events table.

-- 1. CREATE the Host_Cities table
CREATE TABLE Host_Cities (
    Games VARCHAR(50) PRIMARY KEY, -- Unique identifier for each game, e.g., '2016 Summer'
    Year INT,
    Season VARCHAR(10),
    City VARCHAR(50),
    Host_NOC VARCHAR(3)            -- The NOC of the host country
);

-- 2. INSERT data for all modern Olympic Games
INSERT INTO Host_Cities (Games, Year, Season, City, Host_NOC) VALUES
('1896 Summer', 1896, 'Summer', 'Athina', 'GRE'),
('1900 Summer', 1900, 'Summer', 'Paris', 'FRA'),
('1904 Summer', 1904, 'Summer', 'St. Louis', 'USA'),
('1906 Summer', 1906, 'Summer', 'Athina', 'GRE'), -- Intercalated Games
('1908 Summer', 1908, 'Summer', 'London', 'GBR'),
('1912 Summer', 1912, 'Summer', 'Stockholm', 'SWE'),
('1920 Summer', 1920, 'Summer', 'Antwerpen', 'BEL'),
('1924 Summer', 1924, 'Summer', 'Paris', 'FRA'),
('1924 Winter', 1924, 'Winter', 'Chamonix', 'FRA'),
('1928 Summer', 1928, 'Summer', 'Amsterdam', 'NED'),
('1928 Winter', 1928, 'Winter', 'Sankt Moritz', 'SUI'),
('1932 Summer', 1932, 'Summer', 'Los Angeles', 'USA'),
('1932 Winter', 1932, 'Winter', 'Lake Placid', 'USA'),
('1936 Summer', 1936, 'Summer', 'Berlin', 'GER'),
('1936 Winter', 1936, 'Winter', 'Garmisch-Partenkirchen', 'GER'),
('1948 Summer', 1948, 'Summer', 'London', 'GBR'),
('1948 Winter', 1948, 'Winter', 'Sankt Moritz', 'SUI'),
('1952 Summer', 1952, 'Summer', 'Helsinki', 'FIN'),
('1952 Winter', 1952, 'Winter', 'Oslo', 'NOR'),
('1956 Summer', 1956, 'Summer', 'Melbourne', 'AUS'),
('1956 Winter', 1956, 'Winter', 'Cortina d''Ampezzo', 'ITA'),
('1960 Summer', 1960, 'Summer', 'Roma', 'ITA'),
('1960 Winter', 1960, 'Winter', 'Squaw Valley', 'USA'),
('1964 Summer', 1964, 'Summer', 'Tokyo', 'JPN'),
('1964 Winter', 1964, 'Winter', 'Innsbruck', 'AUT'),
('1968 Summer', 1968, 'Summer', 'Mexico City', 'MEX'),
('1968 Winter', 1968, 'Winter', 'Grenoble', 'FRA'),
('1972 Summer', 1972, 'Summer', 'Munich', 'GER'),
('1972 Winter', 1972, 'Winter', 'Sapporo', 'JPN'),
('1976 Summer', 1976, 'Summer', 'Montreal', 'CAN'),
('1976 Winter', 1976, 'Winter', 'Innsbruck', 'AUT'),
('1980 Summer', 1980, 'Summer', 'Moskva', 'RUS'),
('1980 Winter', 1980, 'Winter', 'Lake Placid', 'USA'),
('1984 Summer', 1984, 'Summer', 'Los Angeles', 'USA'),
('1984 Winter', 1984, 'Winter', 'Sarajevo', 'YUG'),
('1988 Summer', 1988, 'Summer', 'Seoul', 'KOR'),
('1988 Winter', 1988, 'Winter', 'Calgary', 'CAN'),
('1992 Summer', 1992, 'Summer', 'Barcelona', 'ESP'),
('1992 Winter', 1992, 'Winter', 'Albertville', 'FRA'),
('1994 Winter', 1994, 'Winter', 'Lillehammer', 'NOR'),
('1996 Summer', 1996, 'Summer', 'Atlanta', 'USA'),
('1998 Winter', 1998, 'Winter', 'Nagano', 'JPN'),
('2000 Summer', 2000, 'Summer', 'Sydney', 'AUS'),
('2002 Winter', 2002, 'Winter', 'Salt Lake City', 'USA'),
('2004 Summer', 2004, 'Summer', 'Athina', 'GRE'),
('2006 Winter', 2006, 'Winter', 'Torino', 'ITA'),
('2008 Summer', 2008, 'Summer', 'Beijing', 'CHN'),
('2010 Winter', 2010, 'Winter', 'Vancouver', 'CAN'),
('2012 Summer', 2012, 'Summer', 'London', 'GBR'),
('2014 Winter', 2014, 'Winter', 'Sochi', 'RUS'),
('2016 Summer', 2016, 'Summer', 'Rio de Janeiro', 'BRA');

--verify the data by running a SELECT statement
--SELECT * FROM Host_Cities;
