/*
 * Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, 
 * projeví se to na cenách potravin či mzdách ve stejném
 * nebo následujícím roce výraznějším růstem?
 */

SELECT 
    a.year,
    ROUND(AVG(((a.gdp - b.gdp) / b.gdp) * 100), 2) AS gdp_increase,
    ROUND(AVG(((a.avg_value - b.avg_value) / b.avg_value) * 100), 2) AS price_increase,
    ROUND(AVG(((a.avg_salary - b.avg_salary) / b.avg_salary) * 100), 2) AS salary_increase
FROM t_albert_kereskeni_project_sql_secondary_final a
JOIN t_albert_kereskeni_project_sql_secondary_final b 
    ON a.name = b.name
    AND a.industry_branch = b.industry_branch
    AND b.year = a.year - 1
GROUP BY a.year
ORDER BY year ASC;