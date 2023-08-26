-- Step 1: Add new columns
ALTER TABLE airports_data
ADD COLUMN longitude double precision,
ADD COLUMN latitude double precision;

-- Step 2: Update new columns using data from coordinates
UPDATE airports_data
SET longitude = CAST(SUBSTRING(coordinates::text FROM 2 FOR POSITION(',' IN coordinates::text) - 2) AS double precision),
    latitude = CAST(SUBSTRING(coordinates::text FROM POSITION(',' IN coordinates::text) + 1 FOR LENGTH(coordinates::text) - POSITION(',' IN coordinates::text) - 2) AS double precision);

-- Step 3: Optionally, drop the original coordinates column
ALTER TABLE airports_data
DROP COLUMN coordinates;


ALTER TABLE airports_data
ALTER COLUMN coordinates TYPE text;
