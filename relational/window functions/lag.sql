-- https://platform.stratascratch.com/coding/9637-growth-of-airbnb?code_type=1
-------------------------------------------------------------------------------------------------
-- Question:
-- Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric. 
-- The rate of growth is calculated by 
--      -((number of hosts registered in the current year - number of hosts registered in the previous year) / the number of hosts registered in the previous year) * 100.
-- Output 
--      - the year, 
--      - number of hosts in the current year, 
--      - number of hosts in the previous year, 
--      - and the rate of growth. Round the rate of growth to the nearest percent 
--      - and order the result in the ascending order based on the year.
--
-- Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.
-------------------------------------------------------------------------------------------------
-- Target Table
--
-- Year | Number of hosts current year | Number of hosts previous year | Rounded rate of growth
-- 2019                100                              50                 (100-50)/50   = 100%
-- 2020                120                              100                (120-100)/120 =  16%
-- 2021                100                              120                (100-120)/115 = -17%
-------------------------------------------------------------------------------------------------
-- Insight above question would provide:
--
-- Increase/decrease in hosts helps a traveler make a decision on whether or not to book
-- Less people hosting might discourage other people from hosting
-------------------------------------------------------------------------------------------------
-- More interesting questions:
--
-- What are a hosts role in the business model of AirBnB?
-- Does a decrease in growth mean its bad?
-- Does an increase actually mean good?

-------------------------------------------------------------------------------------------------

with transform_cte as (
    select
    "id",
    to_char("host_since", 'YYYY') as "year"
    from airbnb_search_details
)

select
sub_create_growth."year",
sub_create_growth."number_of_current_year_host",
sub_create_growth."number_of_previous_year_host",
round((sub_create_growth."number_of_current_year_host" - sub_create_growth."number_of_previous_year_host") / sub_create_growth."number_of_previous_year_host"::FLOAT * 100) as "growth"
from
(select
sub_create_count."year",
sub_create_count."number_of_current_year_host",
lag(sub_create_count."number_of_current_year_host", 1) over(order by sub_create_count."year") as "number_of_previous_year_host"
from
(select
transform_cte."year",
count(transform_cte."id") as "number_of_current_year_host"
from transform_cte
group by ("year")
order by "year" asc) sub_create_count) sub_create_growth