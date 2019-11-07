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

SELECT * FROM taxi_data

