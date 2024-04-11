select 
    name, 
    certificates 
from {{source('skill_matrix','skills')}}