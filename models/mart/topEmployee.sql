with skills as (
    select * from {{ ref('stg_submissions')}} 
),

ranked as(
SELECT 
        empid, 
        skill, 
        proficiency, 
        rating,
        ROW_NUMBER() OVER (PARTITION BY skill ORDER BY rating DESC) AS skill_rank
    FROM 
        skills
    WHERE 
        proficiency = 'advance')
select skill_rank,
max(CASE WHEN skill = 'dbt' THEN empid END )as DBT

from ranked where skill_rank <=10 group by skill_rank order by skill_rank 