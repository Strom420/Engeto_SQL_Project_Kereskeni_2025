/*
 * Otázka 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin 
 * výrazně vyšší než růst mezd (větší než 10 %)?
 */

SELECT 
    a.year,
    ROUND(AVG(((a.avg_value - b.avg_value) / b.avg_value) * 100), 2) AS price_increase,
    ROUND(AVG(((a.avg_salary - b.avg_salary) / b.avg_salary) * 100), 2) AS salary_increase,
    ROUND(
        AVG(((a.avg_value - b.avg_value) / b.avg_value) * 100)
        - AVG(((a.avg_salary - b.avg_salary) / b.avg_salary) * 100), 2) AS difference
FROM t_albert_kereskeni_project_sql_primary_final a
JOIN t_albert_kereskeni_project_sql_primary_final b 
    ON a.name = b.name
    AND a.industry_branch = b.industry_branch
    AND b.year = a.year - 1
GROUP BY a.year
ORDER BY year ASC;