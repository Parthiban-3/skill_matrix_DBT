with skills as (
    select * from {{ ref('stg_submissions')}} 
),

ranked as(
SELECT 
        empid, 
        name,
        skill, 
        proficiency, 
        rating,
        ROW_NUMBER() OVER (PARTITION BY skill ORDER BY rating DESC) AS skill_rank
    FROM 
        skills
    WHERE 
        proficiency = 'advance'
)
select 
skill_rank,
    max(CASE WHEN skill = 'dbt' THEN concat(empid,'-',name) END )as DBT,
    max(CASE WHEN skill = 'azure' THEN concat(empid,'-',name) END )as AZURE,
    max(CASE WHEN skill = 'snowflakes' THEN concat(empid,'-',name) END )as SNOWFLAKES,
    max(CASE WHEN skill = 'databricks' THEN concat(empid,'-',name) END )as DATABRICKS,
    max(CASE WHEN skill = 'knime' THEN concat(empid,'-',name) END )as KNIME
from 
    ranked 
where 
    skill_rank <=10 
group by 
    skill_rank 
order by 
    skill_rank 