# Netflix-Data-Cleaning-Analysis-and-Visualization

1: Title 
      Title: Netflix Data Analysis Project
      Subtitle: Cleaning, Analyzing & Visualizing Netflix Data using MySQL & Excel
      Presented by: Shivam Patel

________________________________________
2: Introduction
    •	Netflix is a leading global streaming service with a vast content library.
    •	This project aims to analyze Netflix data by: 
          o	Cleaning raw data using MySQL.
          o	Identifying duplicate and missing values.
          o	Performing data analysis to extract insights.
          o	Visualizing findings in Excel.

________________________________________
3: Problem Statement
    •	The dataset contains: 
          o	Missing values in fields like director and country.
          o	Duplicate records that can affect analysis accuracy.
          o	Inconsistent formats in date, duration, and rating columns.
    •	Goals: 
          o	Clean and preprocess the data using MySQL.
          o	Analyze and visualize trends in Netflix content.
________________________________________



4: Data Cleaning Using SQL Queries
    Handling Missing Values.
      •	Standardized date formats for consistency.
                    SQL Query:
                    CREATE TABLE netflix_cleaned AS
                    SELECT
                        show_id,
                        type,
                        title,
                        director,
                        country,
                        STR_TO_DATE(date_added, '%m/%d/%Y') AS date_added,
                        release_year,
                        rating,
                        Coalesce(CASE
                                    WHEN duration LIKE '%min' THEN    
                                    CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
                                    ELSE NULL
                                 END, 0) AS duration_min,
                        Coalesce(CASE
                                    WHEN duration LIKE '%Season%' THEN 
                                    CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
                                	  ELSE NULL
                        	    	END,0) AS num_seasons,
                        listed_in
                    FROM netflix1;
________________________________________
5: Checking for Duplicate Values
    Finding Duplicate Entries
        SQL Query:
                  SELECT show_id, title, COUNT(*) AS duplicate_count
                  FROM netflix_cleaned
                  GROUP BY show_id, title
                  HAVING COUNT(*) > 1;
•	No duplicate records were found in the dataset.
________________________________________



6: Data Analysis Using SQL Queries
    Top 10 Countries with Most Content
                SELECT country, COUNT(*) AS total_shows
                FROM netflix_cleaned
                GROUP BY country
                ORDER BY total_shows DESC
                LIMIT 10;
    Most Popular Genres
                SELECT listed_in, COUNT(*) AS genre_count
                FROM netflix_cleaned
                GROUP BY listed_in
                ORDER BY genre_count DESC
                LIMIT 10;
    Trend of New Content Over the Years
                SELECT release_year, COUNT(*) AS total_releases
                FROM netflix_cleaned
                GROUP BY release_year
                ORDER BY release_year ASC;
    Average Movie Duration
                SELECT ROUND(AVG(duration_min), 2) AS avg_movie_duration
                FROM netflix_cleaned
                WHERE type = 'Movie';
________________________________________
7: Data Visualization in Excel
    Key Visualizations Created:
        ✅ Bar Chart: Top 10 countries with the most Netflix content.
        ✅ Bar Chart: Distribution of Netflix content by genre.
        ✅ Line Chart: Trend of new Netflix content releases.
        ✅ Bar Chart: Average movie duration.
________________________________________
8: Key Insights & Results
        •	USA leads with the highest number of Netflix shows.
        •	Drama and Comedy are the most common genres.
        •	Increase in Netflix content releases after 2015.
        •	Average movie duration is around 99.73 minutes.
________________________________________

9: Conclusion
        •	Netflix content is highly concentrated in specific regions and genres.
        •	SQL helped clean and analyze the data efficiently.
        •	Excel provided clear visual insights into content trends.
        •	This project showcases skills in data cleaning, SQL analysis, and Excel visualization.

________________________________________
10: THANK YOU!
        📌 Open for Questions!
        📧 Contact: sp030.4050607@gmail.com

