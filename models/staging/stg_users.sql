select 
    empid,
    name,
    designation,
    role
  from {{source('skill_matrix','users')}} 
   



