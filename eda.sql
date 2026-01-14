-- EXPLORATORY DATA ANALYSIS --

SELECT * 
FROM layoffs_staging2;



-- 1. Understanding the Range of Layoffs -----------------------------

SELECT MIN(total_laid_off), MAX(total_laid_off)
FROM layoffs_staging2;

SELECT MIN(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;



-- 2. Companies That Laid Off 100% of Employees ----------------------

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
AND total_laid_off
ORDER BY funds_raised_millions DESC;



-- 3. Layoffs by Company and Industry --------------------------------

SELECT industry ,company, SUM(total_laid_off), avg(total_laid_off)
FROM layoffs_staging2
GROUP BY company,industry
ORDER BY 1 DESC;



-- 4. Date Range of the Dataset --------------------------------------

SELECT MIN(`date`), MAX(`date`) 
FROM layoffs_staging2;



-- 5. Total Layoffs by Country ---------------------------------------

SELECT country, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;



-- 6. Total Layoffs by Industry --------------------------------------

SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;



-- 7. Top 10 Companies by Layoffs ------------------------------------

SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 10;



-- 8. Layoffs by Year -------------------------------------------------

SELECT YEAR(`date`) AS year, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY year;



-- 9. Average Layoffs by Stage ---------------------------------------

SELECT stage, AVG(total_laid_off) AS avg_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY avg_layoffs DESC;



-- 10. Dataset Size --------------------------------------------------

SELECT COUNT(*) AS total_records
FROM layoffs_staging2;

-- 11. Final Dataset Preview --------------------------------------------

SELECT * 
FROM layoffs_staging2;
