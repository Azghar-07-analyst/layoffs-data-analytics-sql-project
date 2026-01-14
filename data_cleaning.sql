-- DATA CLEANING PROJECT --

SELECT *
FROM layoffs;

-- 1. Removing Duplicates 

CREATE TABLE layoffs_staging 
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT * ,
row_number() OVER(
partition by company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
FROM layoffs_staging;

WITH duplicate_cte AS (
SELECT * ,
row_number() OVER(
partition by company,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging
)
select*
from duplicate_cte 
WHERE row_num>1 ;

SELECT * FROM layoffs_staging
WHERE company= '2TM';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * ,
row_number() OVER(
partition by company,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2
WHERE  row_num =1;

-- 2. Standardizing the data 

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company= TRIM(company);

SELECT distinct industry 
FROM layoffs_staging2
order by industry asc;

UPDATE layoffs_staging2 
SET industry ='Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET country ='United States'
WHERE country like 'United States%';

SELECT distinct country
from layoffs_staging2
order by 1;

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

-- 3. Null values or blank values 

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE funds_raised_millions IS NULL;

DELETE 
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL;

-- 4. Remove any columns 

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;
