					create database netflix;
                    
					use netflix;
                    
					select * from netflix1;
                    

                   
/*   STEP 1:- CLEAN THE DATA :---------

1) CREATED A CLEAN TABLE CALLED netflix_cleaned:-----

 Issue: Some columns (like director, country, and date_added) might have missing or empty values.
Solution: Convert the "date_added" column into a proper date format to ensure consistency.      */

				CREATE TABLE netflix_cleaned AS
				SELECT 
					show_id,
					type,
					title,
					director,
					country,
					-- Convert 'date_added' to a proper date format
					STR_TO_DATE(date_added, '%m/%d/%Y') AS date_added,
					release_year,
					rating,
					-- Extract duration for movies
					         CASE 
					              WHEN duration LIKE '%min' THEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
						       ELSE NULL 
						  END AS duration_min,
					-- Extract the number of seasons for TV shows
					         CASE 
						        WHEN duration LIKE '%Season%' THEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
						        ELSE NULL 
						 END AS num_seasons,
					listed_in
				FROM netflix1;

                        
						select * from netflix_cleaned;
    
 LET'S CHECK IF DUPLICATE VAVLUE IS EXIST OR NOT ------------------

						select show_id, title, director, 
	 						date_added, release_year,
						       rating, count(*) as duplicate_count
						from 
	 						netflix_cleaned
						group by show_id, title, director, date_added, release_year, rating
						having count(*) > 1;
               
    
/* NO DUPLICATE FOUND AND IF FOUND ANY DUPLICATE THEN REMOVE DUPLICATE BY USING BELOW QUERY:-------
CLEANING PART IS COMPLETED.   */

/*
  STEP 2:- LET'S ANALYZE OUR DATA:---------
  
  1) TOP 10 COUNTRIES WITH MOST NETFLIX CONTENTS ---------  */
  
						  select 
							country, 
							count(*) as total_shows
						  from 
							netflix_cleaned
						  group by country
						  order by total_shows desc
						  limit 10;

#  2)  MOST COMMON MOVIES GENERS------------
						   
						   select 
							listed_in, count(*) as genre_count
						   from 
							netflix_cleaned
						   group by listed_in
						   order by genre_count desc
						   limit 10;
       
# TREND OF NEW CONTENT OVER THE YEARS--------------
							
						select 
	                                              release_year, 
	                                              count(*) as total_releases
						from 
	                                               netflix_cleaned
						group by release_year
						order by release_year desc
						limit 10;
            
# AVERAGE MOVIE DURATION-------------

						  select 
	            					round(avg(duration_min),2) as avg_movie_duration
						  from 
							netflix_cleaned
						  where  type = 'movie';
                          
                   



