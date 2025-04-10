/* 
 * Otázka 2: Kolik je možné si koupit litrů mléka a kilogramů chleba 
 * za první a poslední srovnatelné období v dostupných datech cen a mezd?
 */

SELECT
	industry_branch,
	name,
	round(avg_salary / avg_value::NUMERIC) AS quantity,
	price_unit,
	"year"
FROM t_albert_kereskeni_project_SQL_primary_final
WHERE
	name IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový')
	AND "year" IN (2006, 2018)
ORDER BY
	industry_branch,
	name,
	YEAR;