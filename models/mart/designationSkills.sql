with skills as (
    select s.empid,s.skill,u.designation from {{ ref('stg_submissions')}} as s 
    join {{ ref('stg_users')}} as u on u.empid = s.empid
)
SELECT 
    designation,
     count(*) as total,
    ROUND(COUNT(CASE WHEN skill = 'dbt' THEN 1 END)*100/total,2) AS DBT_PERCENT,
    ROUND(COUNT(CASE WHEN skill = 'snowflakes' THEN 1 END)*100/total,2) AS SNOWFLAKES_PERCENT,
    ROUND(COUNT(CASE WHEN skill = 'azure' THEN 1 END)*100/total,2) AS AZURE_PERCENT,
    ROUND(COUNT(CASE WHEN skill = 'knime' THEN 1 END)*100/total,2) AS KNIME_PERCENT ,
    ROUND(COUNT(CASE WHEN skill = 'databricks' THEN 1 END)*100/total,2) AS DATABRICKS_PERCENT ,

FROM 
    skills
GROUP BY 
    designation
order by 
    total desc


