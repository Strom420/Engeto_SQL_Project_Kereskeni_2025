--Pomocná tabulka s údaji o mzdách
CREATE TABLE t_help_a AS
SELECT
	cpib.name AS industry_branch, 
	round(avg(cp.value)::NUMERIC, 2) AS avg_salary,
	cp.payroll_year
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cpib.code = cp.industry_branch_code
WHERE 
	value_type_code = 5958
	AND industry_branch_code IS NOT NULL
	AND payroll_year BETWEEN 2006 AND 2018
GROUP BY
	cp.payroll_year,
	cpib.name;

-- Pomocná tabulka s údaji o cenách potravin
CREATE TABLE t_help_b AS
SELECT
	cpc.name,
	cp.value,
	cpc.price_value,
	cpc.price_unit,
	EXTRACT(YEAR FROM cp.date_from) AS price_year
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc
	ON cpc.code = cp.category_code
WHERE 
	cp.region_code IS NULL
GROUP BY
	cpc.name,
	cpc.price_value,
	cpc.price_unit,
	cp.value,
	cp.date_from;

-- Primární tabulka spojená z pomocných tabulek 

CREATE TABLE t_albert_kereskeni_project_SQL_primary_final AS
SELECT
	t_help_a.industry_branch,
	t_help_a.avg_salary,
	t_help_a.payroll_year AS "year",
	t_help_b.name,
	round(avg(t_help_b.value)::numeric, 2) AS avg_value,
	t_help_b.price_value,
	t_help_b.price_unit
FROM t_help_a
LEFT JOIN t_help_b
	ON t_help_b.price_year = t_help_a.payroll_year
GROUP BY
	t_help_a.industry_branch,
	t_help_a.avg_salary,
	t_help_a.payroll_year,
	t_help_b.name,
	t_help_b.price_value,
	t_help_b.price_unit;

-- Tvorba sekundární tabulky

CREATE TABLE t_albert_kereskeni_project_SQL_secondary_final AS
	SELECT
		t_albert_kereskeni_project_SQL_primary_final.*,
		economies.gdp::numeric
	FROM t_albert_kereskeni_project_SQL_primary_final 
	LEFT JOIN economies
		ON economies.YEAR = t_albert_kereskeni_project_SQL_primary_final.year
	WHERE 
		economies.country = 'Czech Republic'
		AND economies.YEAR BETWEEN 2006 AND 2018;