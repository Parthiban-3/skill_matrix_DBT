with skills as (
    select * from {{ ref('stg_submissions')}} 
)

SELECT DISTINCT
    skill,
    COUNT(CASE WHEN proficiency = 'beginner' THEN 1 END) AS BEGINNER,
    COUNT(CASE WHEN proficiency = 'intermediate' THEN 1 END) AS INTERMEDIATE,
    COUNT(CASE WHEN proficiency = 'advance' THEN 1 END) AS ADVANCE,
    BEGINNER+INTERMEDIATE+ADVANCE AS TOTAL

FROM 
    skills
GROUP BY 
    skill 
ORDER BY 
    TOTAL DESC