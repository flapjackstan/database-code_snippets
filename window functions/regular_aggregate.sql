-- https://platform.stratascratch.com/coding/10302-distance-per-dollar?code_type=1

-- You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. 

-- For each date, find the difference between the distance-per-dollar for that date and the average distance-per-dollar for that year-month. Distance-per-dollar is defined as the distance traveled divided by the cost of the ride.

-- The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).

-- You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.

-- My notes

-- for each date signifies that we do want a fairly large view. 
-- count both success and failed requests also tells me that it will be partioned by these categories


-- Functions possibly used
-- OVER(PARTITION BY x)
-- long_calculated_field AS short_name
-- ORDER BY date_field


-- Target Table
--	request_date		formated_date,	‘distance_to_travel’,	‘monetary_cost’,	calculated_distance_per_dollar,		request_status,		calculated_avg_distance_per_dollar_for_year_month by request_status,	abs(calculated_distance_per_dollar - calculated_avg_distance_per_dollar_for_year_month)

--	2022-01-05,				2022-01,				3,						15,						5,								a,											10, 																			5
--	2022-01-20,				2022-01,				5,						35,						7,								a,											10,																				3
--	2022-02-05,				2022-02,				5,						50,						10,								b,											5,																				5