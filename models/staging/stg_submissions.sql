with users as (
    select * from {{ ref('stg_users')}}
)

select 
    s.empid,
    u.name,
    s.skill,
    s.certification,
    s.profeciency as proficiency,
    s.rating,
    s.projectcount as project_Count,
    s.duration as total_Duration,
    DATE(s.createdon) as completed_On
from 
  {{source('skill_matrix','submissions')}} as s
  left join  users as u
    on s.empid = u.empid
    where status = 'approved' 
   



