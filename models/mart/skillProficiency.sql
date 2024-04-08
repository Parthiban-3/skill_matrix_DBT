with skills as (
    select * from {{ ref('stg_submissions')}} 
)

SELECT 
    skill,
    COUNT(CASE WHEN proficiency = 'beginner' THEN 1 END) AS BEGINNER,
    COUNT(CASE WHEN proficiency = 'intermediate' THEN 1 END) AS INTERMEDIATE,
    COUNT(CASE WHEN proficiency = 'advance' THEN 1 END) AS ADVANCE,

FROM 
    skills
GROUP BY 
    skill