-- -------------------------------------------Cognifyz Data Analysis-------------------------------------------------------------------------------
create database cognifyz;
use cognifyz;
################################################################################################
 SELECT city,count(`restaurant id`) as top3  FROM restaurant_analysis group by city order by  top3 desc limit 3;
 select * from restaurant_cuisine_split;
 select * from restaurant_map_view;
#####################################################   
SELECT 
    `restaurant id`, COUNT(`restaurant id`) AS restaurant_number
FROM
    restaurant_analysis
GROUP BY `restaurant id`
HAVING restaurant_number > 1;
###################################################################################################
SELECT 
    COUNT(*) AS total_rows,
    SUM(latitude = 0 AND longitude = 0) AS both_zero,
    SUM(latitude = 0 AND longitude <> 0) AS lat_missing,
    SUM(latitude <> 0 AND longitude = 0) AS long_missing,
    SUM(latitude <> 0 AND longitude <> 0) AS valid_geo
FROM
    restaurant_analysis;
###########################################################################################	
-- replacement of longitude and latitude where values are 0.
##############################################################
-- Fixing rows where both latitude and longitude value is 0 on the basis of locality verbose
start transaction;
UPDATE restaurant_analysis r
        JOIN
    (SELECT 
        `locality verbose`,
            ROUND(AVG(NULLIF(Latitude, 0)), 6) AS avg_lat,
            ROUND(AVG(NULLIF(longitude, 0)), 6) AS avg_long
    FROM
        restaurant_analysis
    GROUP BY `locality verbose`
    HAVING avg_lat IS NOT NULL
        AND avg_long IS NOT NULL) AS lv ON r.`locality verbose` = lv.`locality verbose` 
SET 
    r.latitude = lv.avg_lat,
    r.longitude = lv.avg_long
WHERE
    r.latitude = 0 AND r.longitude = 0;
CREATE VIEW after_localverbose AS
    SELECT 
        *
    FROM
        restaurant_analysis;
SELECT 
    *
FROM
    after_localverbose;
-- ###############################################################################    
--  Fixing remaining rows where both lat and long have 0 values using city fallback.
UPDATE restaurant_analysis r
        JOIN
    (SELECT 
        city,
            ROUND(AVG(NULLIF(latitude, 0)), 6) AS avg_lat,
            ROUND(AVG(NULLIF(longitude, 0)), 6) AS avg_long
    FROM
        restaurant_analysis
    GROUP BY city
    HAVING avg_lat IS NOT NULL
        AND avg_long IS NOT NULL) AS c ON r.city = c.city 
SET 
    r.latitude = c.avg_lat,
    r.longitude = c.avg_long
WHERE
    r.latitude = 0 AND r.longitude = 0;
##############################################################################    
CREATE VIEW after_city AS
    SELECT 
        *
    FROM
        restaurant_analysis;
SELECT 
    *
FROM
    after_city;
-- ###############################################################################    
--  Fixing rows where only latitude have 0 values using locality verbose
UPDATE restaurant_analysis AS r
        JOIN
    (SELECT 
        `locality verbose`,
            ROUND(AVG(NULLIF(latitude, 0)), 6) AS avg_lat
    FROM
        restaurant_analysis
    GROUP BY `locality verbose`
    HAVING avg_lat IS NOT NULL) AS lvv ON r.`locality verbose` = lvv.`locality verbose` 
SET 
    r.latitude = lvv.avg_lat
WHERE
    r.latitude = 0 AND r.longitude <> 0;
-- ###############################################################################    
--  Fixing rows where only longitude have 0 values using locality verbose
UPDATE restaurant_analysis AS r
        JOIN
    (SELECT 
        `locality verbose`,
            ROUND(AVG(NULLIF(longitude, 0)), 6) AS avg_long
    FROM
        restaurant_analysis
    GROUP BY `locality verbose`
    HAVING avg_long IS NOT NULL) AS lvvv ON r.`locality verbose` = lvvv.`locality verbose` 
SET 
    r.longitude = lvvv.avg_long
WHERE
    r.longitude = 0 AND r.latitude <> 0;
UPDATE restaurant_analysis AS r
        JOIN
    (SELECT 
        city, ROUND(AVG(NULLIF(latitude, 0)), 6) AS avg_lat
    FROM
        restaurant_analysis
    GROUP BY city
    HAVING avg_lat IS NOT NULL) AS c ON r.city = c.city 
SET 
    r.latitude = c.avg_lat
WHERE
    r.latitude = 0 AND r.longitude <> 0;
--  Fixing rows where only longitude have 0 values using city fallback.
UPDATE restaurant_analysis AS r
        JOIN
    (SELECT 
        city, ROUND(AVG(NULLIF(longitude, 0)), 6) AS avg_long
    FROM
        restaurant_analysis
    GROUP BY city
    HAVING avg_long IS NOT NULL) AS c ON r.city = c.city 
SET 
    r.longitude = c.avg_long
WHERE
    r.latitude <> 0 AND r.longitude = 0;
SELECT 
    `restaurant id`, COUNT(`restaurant id`) AS restaurant_number
FROM
    restaurant_analysis
GROUP BY `restaurant id`
HAVING restaurant_number > 1;
##############################################################################
-- create view for mapping
CREATE VIEW restaurant_map_view AS
    SELECT 
        `Restaurant ID`,
        `Restaurant Name`,
        `Country code`,
        `City`,
        `Locality Verbose`,
        Longitude,
        Latitude,
        `price range`,
        `aggregate rating`,
        votes
    FROM
        restaurant_analysis
    WHERE
        longitude <> 0 AND latitude <> 0;
##########################################################################################
select * from restaurant_map_view;         
###########################################################################################   
-- update cusines missing value as 'Not specified' missing data is 0.09%      
UPDATE restaurant_analysis 
SET 
    cuisines = 'Not Specified'
WHERE
    TRIM(cuisines) = '' OR cuisines IS NULL;   
########################################################################################
-- transaction commited   
commit; 
#######################################################################################
-- - create view for splited cuisins
-- -------------------------------------------               
CREATE or replace VIEW restaurant_cuisine_split AS
SELECT
    `restaurant Id`,city,TRIM(j.cuisine) AS cuisine
FROM restaurant_analysis r
JOIN JSON_TABLE(
	CONCAT(
        '["',
         REPLACE(trim(r.Cuisines), ', ', '","'),
         '"]'
     ),
	
    '$[*]' COLUMNS (
        cuisine VARCHAR(100) PATH '$'
    )
) as j
WHERE r.Cuisines IS NOT NULL
  AND TRIM(j.cuisine) <> '';        
-- ---------------------------------------------------
select * from  restaurant_cuisine_split;
#######################################################################################

###################################  Level -1 ##########################################
-- Task-1: Top Cuisines 
SELECT 
    cuisine, COUNT(Cuisine) AS total_no_of_cuisines
FROM
    restaurant_cuisine_split
GROUP BY cuisine
ORDER BY COUNT(Cuisine) DESC
LIMIT 3;
### calculate the percentage of restaurant that serve each of the top cuisines.
with CuisineRanks as (select cuisine,count(distinct(`restaurant id`)) as total_restaurant,
rank() over (order by count(distinct(`restaurant id`)) desc) as cuisine_rank 
from  restaurant_cuisine_split group by cuisine)
select cr.cuisine,round(cr.total_restaurant*100/(select count(distinct(`restaurant id`)) from  restaurant_cuisine_split),2) as total_percentage from
CuisineRanks as cr 
where cr.cuisine_rank <=3;
############################################################################################################
-- -----------------------------------------------------Task City Analysis---------------------------------------------------
-- main table
-- Identify the city with the highest number of restaurants in the dataset
SELECT 
    city, COUNT(DISTINCT `restaurant id`) AS highest_no_of_restaurants
FROM
    restaurant_analysis
GROUP BY city
ORDER BY highest_no_of_restaurants DESC
LIMIT 1;
############-- Calculate the average rating for restaurants in each city
SELECT 
    city, ROUND(AVG(`aggregate rating`), 2) AS avg_rating
FROM
    restaurant_analysis
GROUP BY city
ORDER BY avg_rating DESC;
########### Determine the city with the highest average rating
SELECT 
    city, ROUND(AVG(`aggregate rating`), 2) AS avg_rating
FROM
    restaurant_analysis
GROUP BY city
ORDER BY avg_rating DESC limit 1;
#################################################################################
-- - ------------------------ Task: Price Range Distribution-------------------------------------------
-- Create a histogram or bar chart to visualize the distribution of price ranges among the restaurants

##########################################################################
### calculate the percentage of restaurant that in each price range category.
with CuisineRanks_PR as (select `price range`,count(distinct(`restaurant id`)) as total_restaurant,
rank() over (order by count(distinct(`restaurant id`)) desc) as cuisine_rank_pr
from restaurant_analysis group by `price range`)
select pr.`price range`,round(pr.total_restaurant*100/(select count(distinct(`restaurant id`)) from restaurant_analysis),2) as total_percentage from
CuisineRanks_PR as pr ;
-- -----------------------------------------------------Task4 Online Delivery ---------------------------------------------------
## Determine the percentage of restaurant that offer online delivery.
with online_delivery_CTE as(select count(distinct`restaurant id`) as total_restaurant, `Has Online delivery` from restaurant_analysis group by `Has Online delivery`)
select od.`Has Online delivery`, round(od.total_restaurant*100/(select count(distinct`restaurant id`) from restaurant_analysis),2)  as restaurant_percentage  
from online_delivery_CTE as od where od.`Has Online delivery` = 'yes';
## Compare the average ratings of restaurants with and without online delivery.
SELECT 
    ROUND(AVG(`Aggregate rating`), 2) as common_aggregate_rating,
    `Has Online delivery`
FROM
    restaurant_analysis
GROUP BY `Has Online delivery`;
#################################################   level 2   ####################################################################
--  --------------------------------------------------- Task1 Restaurant Ratings-- ---------------------------------------------------
-- Analyze the distribution of aggregate ratings and determine the most common rating range.
SELECT 
    COUNT(`rating text`) AS distribution_of_rating,
    CASE
        WHEN `rating text` = 'Not Rated' THEN 0
        WHEN `rating text` = 'Poor' THEN 1
        WHEN `rating text` = 'Average' THEN 2
        WHEN `rating text` = 'Good' THEN 3
        WHEN `rating text` = 'Very Good' THEN 4
        WHEN `rating text` = 'Excellent' THEN 5
    END AS Rating_range
FROM
    restaurant_analysis
GROUP BY Rating_range
ORDER BY Rating_Range DESC;
### Calculate the average number of votes  received by restaurants
select round(avg(votes),2) as avg_votes from restaurant_analysis where votes is not null;
--  --------------------------------------------------- Task2: Cuisine Combination-- ---------------------------------------------------
-- Identify the most common combinations of cuisines in the dataset
SELECT 
    cuisines, COUNT(cuisines) AS combo_count
FROM   restaurant_analysis
where cuisines like '%,%'
GROUP BY Cuisines
ORDER BY combo_count DESC
LIMIT 10;
-- Determine if certain cuisine combinations tend to have higher ratings.
select cuisines as cuisines_combo,count(distinct `restaurant id`) as restaurant_count, 
round(avg(`aggregate rating`),2) as avg_rating
from(SELECT 
    *
FROM   restaurant_analysis
where cuisines like '%,%') as cusines_combo
group by cuisines_combo
having restaurant_count >5
order by avg_rating desc;
--  --------------------------------------------------- Task3 : Geographic analysis-- ---------------------------------------------------
-- Power BI task
-- Plot the locations of restaurants on a map using longitude and latitude coordinates.
-- Identify any patterns or clusters of restaurants in specific areas.
--  --------------------------------------------------- Task4 : Restaurant Chain analysis-- ---------------------------------------------------
-- Identify if there are any restaurant chains present in the dataset
SELECT 
    `restaurant name`,
    COUNT(`restaurant name`) AS number_of_locations
FROM
    restaurant_analysis
GROUP BY `restaurant name`
HAVING number_of_locations > 25
ORDER BY number_of_locations DESC,
 `restaurant name` asc ;
-- Analyze the ratings and popularity of different restaurant chains
 SELECT 
    `restaurant name`,
    count(*) AS number_of_locations,
    round(avg((`Aggregate rating`)),2) as avg_ratings,
    round(avg(votes),0) as  Popularity_by_votes 
FROM
    restaurant_analysis
GROUP BY `restaurant name`
HAVING number_of_locations > 1
order by number_of_locations desc;
#######################################################################################################
-- -------------------------------  Level -3 ----------------------------------------------------------
-- -------------------------------- Task -1  Restaurant Reviews ----------------------------------------------------------
use cognifyz;
-- Analyze the text reviews to identify the most
-- common positive and negative keywords
select round(count(*),0) as total,`Rating text` 
from restaurant_analysis group by `Rating text` order by total desc;
-- Calculate the average length of reviews and explore if there is a relationship between review length and rating
select avg(length(`rating text`)) as text_len,`Aggregate rating` from restaurant_analysis group by `Aggregate rating`
order by text_len desc;
-- Insights if avg length is 9 then there is 90% chances data rating is above to 4 or equal to 4
-- -----------------Vote Analysis--------------------------------
-- Identify the restaurants with the highest and lowest number of votes.
-- Analyze if there is a correlation between the number of votes and the rating of a restaurant
select `restaurant name`,avg(`aggregate rating`) as avg_rating,avg(votes) as total from restaurant_analysis 
group by `Restaurant Name` order by total desc;
-- Task: Price Range vs. Online Delivery and Table Booking
-- Analyze if there is a relationship between the price range and the availability of online
-- delivery and table booking.
select * from restaurant_analysis;
select `price range`,count(*) as restaurant_count,sum(case when `Has Online delivery`='Yes' then 1 else 0 end) as online_delivery_availible,
round(sum(case when `Has Online delivery`='Yes' then 1 else 0 end)*100/count(*),2) as Percentage_Online_Delivery
from restaurant_analysis group by `Price range`; 
   