# DATA CLEANING AND EDA

#CLEANING

CREATE TABLE layoffs2
LIKE layoffs;
INSERT INTO layoffs2
SELECT *
FROM LAYOFFS;

SELECT * FROM layoffs2;

SELECT DISTINCT company
FROM layoffs2
order by 1; # there are 1888 total comapanies

UPDATE layoffs2
SET company = TRIM(company); # removed trailing and leading spaces.

SELECT DISTINCT country
FROM layoffs2
ORDER BY 1;  # we have an entry of "United States." (next step: standardize)

UPDATE layoffs2
SET country = TRIM(TRAILING '.' FROM country);   # we had an entry of "United States.", removed '.'

# Finding Redundant Reords

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as ROW_NUM
FROM layoffs2;
-- order by ROW_NUM ;     # ROW_NUM > 2 are redundant

CREATE TABLE layoffs3 (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  ROW_NUM INT    # for new column
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs3
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as ROW_NUM
FROM layoffs2;

SELECT * FROM layoffs3;

DELETE
FROM layoffs3
WHERE ROW_NUM > 1; # removed redundant records

SELECT * 
FROM layoffs3 
WHERE ROW_NUM >1; # NO REDUNDANT RECORDS 

SELECT DISTINCT industry
FROM layoffs3; # We have NULL and BLANK values in industry column
# also industry column has ambiguos names for crypto


UPDATE layoffs3
SET industry = NULL
WHERE industry= ''; # we converrted blank values into null

UPDATE layoffs3
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT * FROM layoffs3
WHERE industry IS NULL;

SELECT * 
FROM layoffs3
WHERE company='Airbnb' AND industry IS NOT NULL; 

SELECT * 
FROM layoffs3 as t1
JOIN layoffs3 as t2
ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layOffs3 as t1
JOIN layoffs3 as t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT * 
FROM layoffs3 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; # these roes mean nothing for analysis, so drop them

DELETE
FROM layoffs3
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; # DELETED

SELECT `date` 
FROM layoffs3; # `date` column is in text format and day, month and year are not arranged in order

SELECT `date`,STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs3;

UPDATE layoffs3
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y'); # date format adjusted

ALTER TABLE layoffs3
MODIFY COLUMN `date` DATE; # `date` format changed to DATE from text

#drop ROW_NUM column that we created
ALTER TABLE layoffs3
DROP COLUMN ROW_NUM;

SELECT * 
FROM layoffs3;

----- DATASET CLEANED --------

# EDA



SELECT * FROM layoffs3;

#company-wise layoffs and ranking
SELECT company, SUM(total_laid_off) AS COMPANY_WISE_TOTAL_LAYOFFS
FROM layoffs3
GROUP BY company
ORDER BY COMPANY_WISE_TOTAL_LAYOFFS DESC;   # AMAZON LAID OFF THE MOST

# COUNTRY_WISE LAYOFFS
SELECT country, SUM(total_laid_off) AS COUNTRY_WISE_TOTAL_LAYOFFS
FROM layoffs3
GROUP BY country
ORDER BY COUNTRY_WISE_TOTAL_LAYOFFS DESC;   # AMAZON LAID OFF THE MOST

# yearwise layoffs
SELECT YEAR(`date`), SUM(total_laid_off) AS TOTAL_LAYOFFS
FROM layoffs3
GROUP BY YEAR(`date`)
ORDER BY TOTAL_LAYOFFS DESC;

# Rolling total of layoffs date_wise
WITH ROLLING_TOTAL AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,
SUM(total_laid_off) AS lay_offs_
FROM layoffs3
GROUP BY `MONTH`
ORDER BY lay_offs_
)
SELECT `MONTH`, SUM(lay_offs_)
FROM ROLLING_TOTAL;

SELECT company, YEAR(`date`), SUM(total_laid_off) AS layoff_
FROM layoffs3
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;

SET SESSION sql_mode = REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', '');







SELECT company, SUM(total_laid_off)
OVER(PARTITION BY company)
FROM layoffs3;
 





