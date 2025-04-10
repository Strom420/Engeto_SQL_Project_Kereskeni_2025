/* 
 * Otázka 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 */

SELECT DISTINCT
	a.industry_branch,
	a.YEAR,
	a.avg_salary,
	(a.avg_salary  - b.avg_salary) AS difference
FROM t_albert_kereskeni_project_sql_primary_final a
JOIN t_albert_kereskeni_project_sql_primary_final b 
    ON a.industry_branch = b.industry_branch 
    AND b.year = a.year - 1
ORDER BY
	industry_branch,
	year;