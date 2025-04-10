/*
 * Otázka 3: Která kategorie potravin zdražuje nejpomaleji 
 * (je u ní nejnižší percentuální meziroční nárůst)?
 */

SELECT 
    a.name,
    ROUND(AVG(((b.avg_value - a.avg_value) / a.avg_value) * 100), 2) AS increase
FROM t_albert_kereskeni_project_sql_primary_final a
JOIN t_albert_kereskeni_project_sql_primary_final b 
    ON a.name = b.name 
    AND b.year = a.year + 1
GROUP BY a.name
ORDER BY increase ASC;