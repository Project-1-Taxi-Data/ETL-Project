CREATE table latlong (
	latlong VARCHAR(30) NOT NULL PRIMARY KEY,
	lat INTEGER, 
	long INTEGER, 
	zip_code INTEGER,
	neighborhood VARCHAR(30)
);

CREATE table taxi_data (
	unique_key	VARCHAR(50) PRIMARY KEY,
	trip_start_timestamp TIMESTAMPTZ,
	lat FLOAT, 
	long FLOAT, 
	duration_in_minutes	FLOAT,
	trip_miles FLOAT,
	fare FLOAT,
	latlong VARCHAR(30),
	FOREIGN KEY (latlong) REFERENCES latlong(latlong)
);

CREATE table census_data (
	zip_code INTEGER,
	median_age FLOAT,	
	per_capita_income FLOAT,	
	median_age_transportation FLOAT,	
	time_work FLOAT,	
	means_transportation FLOAT
);

ALTER TABLE census_data
ADD COLUMN id SERIAL PRIMARY KEY;

CREATE INDEX	latlong_zip_code_idx ON latlong(zip_code);

CREATE INDEX	census_zip_code_idx ON census_data(zip_code);

SELECT
	latlong.zip_code,
	round(CAST(AVG(taxi_data.duration_in_minutes) AS NUMERIC),2) AS avg_taxi_trip_duration,
	round(CAST(AVG(taxi_data.trip_miles) AS NUMERIC),2) AS avg_taxi_trip_miles,
	round(CAST(AVG(taxi_data.fare) AS NUMERIC),2) AS avg_taxi_fare,
	round(CAST(AVG(census_data.median_age) AS NUMERIC),2) AS avg_median_age,
	round(CAST(AVG(census_data.per_capita_income) AS NUMERIC),2) AS avg_per_capita_income,
	round(CAST(AVG(census_data.median_age_transportation) AS NUMERIC),2) AS avg_median_age_transportation,
	round(CAST(AVG(census_data.time_work) AS NUMERIC),2) AS avg_time_work,
	round(CAST(AVG(census_data.means_transportation) AS NUMERIC),2) AS avg_means_transportation
FROM
	taxi_data
JOIN latlong ON latlong.latlong = taxi_data.latlong
JOIN census_data ON latlong.zip_code = census_data.zip_code
GROUP BY latlong.zip_code;