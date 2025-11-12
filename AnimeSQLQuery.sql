USE AnimeDB;
SELECT TOP 100* FROM cleaned_anime;

--Queries for Analysis
-- 1) Average Rating by Genre
USE AnimeDB;
GO

SELECT 
    Main_Genre AS Genre,
    ROUND(AVG(CAST([Score] AS FLOAT)), 2) AS AvgRating,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL
GROUP BY Main_Genre
ORDER BY AvgRating DESC
 
 GO

CREATE VIEW AvgRatingByGenre AS
SELECT 
    Main_Genre AS Genre,
    ROUND(AVG(TRY_CAST([Score] AS FLOAT)), 2) AS AvgRating,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL
GROUP BY Main_Genre;

GO


--2)Anime count by type

SELECT 
    Type AS AnimeType,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
GROUP BY Type
ORDER BY AnimeCount DESC;

GO
CREATE VIEW AnimeCountByType AS
SELECT 
    Type AS AnimeType,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
GROUP BY Type;

GO

--3)Top10 most popular anime
SELECT TOP 10
    Name AS AnimeName,
    Members,
    TRY_CAST([Score] AS FLOAT) AS Rating
FROM cleaned_anime
ORDER BY Members DESC;

GO

CREATE VIEW Top10PopularAnime AS
SELECT TOP 10
    Name AS AnimeName,
    Members,
    TRY_CAST([Score] AS FLOAT) AS Rating
FROM cleaned_anime
ORDER BY Members DESC;
GO

--4) Top studio by average score


SELECT 
    Studios,
    ROUND(AVG(TRY_CAST([Score] AS FLOAT)), 2) AS AvgRating,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL
  AND Studios IS NOT NULL
GROUP BY Studios
HAVING COUNT(*) >= 5   
ORDER BY AvgRating DESC;
GO


CREATE VIEW TopStudiosByAvgScore AS
SELECT 
    Studios,
    ROUND(AVG(TRY_CAST([Score] AS FLOAT)), 2) AS AvgRating,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL
  AND Studios IS NOT NULL
GROUP BY Studios
HAVING COUNT(*) >= 5;
GO
--5)Source material vs average rating
SELECT 
    Source AS SourceMaterial,
    ROUND(AVG(TRY_CAST([Score] AS FLOAT)), 2) AS AvgRating,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL
  AND Source IS NOT NULL
GROUP BY Source
ORDER BY AvgRating DESC;
GO

CREATE VIEW SourceMaterialAvgRating AS
SELECT 
    Source AS SourceMaterial,
    ROUND(AVG(TRY_CAST([Score] AS FLOAT)), 2) AS AvgRating,
    COUNT(*) AS AnimeCount
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL
  AND Source IS NOT NULL
GROUP BY Source;
GO

--6) correlation between members and score
SELECT 
    Name,
    TRY_CAST([Score] AS FLOAT) AS Rating,
    Members
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL 
AND Members IS NOT NULL;

GO

CREATE VIEW PopularityVsScore AS
SELECT 
    Name,
    TRY_CAST([Score] AS FLOAT) AS Rating,
    Members
FROM cleaned_anime
WHERE TRY_CAST([Score] AS FLOAT) IS NOT NULL 
AND Members IS NOT NULL;
