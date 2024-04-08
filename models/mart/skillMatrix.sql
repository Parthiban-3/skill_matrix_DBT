with skills as (
    select * from {{ ref('stg_submissions')}} 
),
users as (
    select * from {{ref('stg_users')}}
),
dbt as (
    select empid from skills where skill = 'dbt'
),
azure as (
    select empid from skills where skill = 'azure'
),
databricks as (
    select empid from skills where skill = 'databricks'
),
snowflakes as (
    select empid from skills where skill = 'snowflakes'
),
knime as (
    select empid from skills where skill = 'knime'
),

matrix as(
select 
distinct
u.empid,
u.name,
        CASE WHEN d.empid IS NOT NULL THEN 1 ELSE 0 END AS DBT,
        CASE WHEN a.empid IS NOT NULL THEN 1 ELSE 0 END AS AZURE,
        CASE WHEN k.empid IS NOT NULL THEN 1 ELSE 0 END AS KNIME,
        CASE WHEN db.empid IS NOT NULL THEN 1 ELSE 0 END AS DATABRICKS,
        CASE WHEN s.empid IS NOT NULL THEN 1 ELSE 0 END AS SNOWFLAKES,
        DBT+AZURE+KNIME+DATABRICKS+SNOWFLAKES as TOTAL
from users u left join dbt d on u.empid = d.empid 
left join azure a on u.empid = a.empid 
left join knime k on u.empid = k.empid
left join databricks db on u.empid = db.empid
left join snowflakes s on u.empid = s.empid
order by total desc ),
percent as (

    select 'SKILL'as EMPLOYEE_ID,
    'PERCENTAGE'as NAME,
    sum(dbt)*100/200 AS DBT,
    sum(azure)*100/200 AS AZURE,
    sum(knime)*100/200 AS KNIME,
    sum(databricks)*100/200 AS DATABRICKS,
    sum(snowflakes)*100/200 AS SNOWFLAKES,
    0 as TOTAL
     from matrix 
)
SELECT * FROM percent
UNION ALL
SELECT * FROM matrix