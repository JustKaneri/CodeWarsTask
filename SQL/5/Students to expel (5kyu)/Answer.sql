-- Substitute with your SQL
WITH cours AS (
    select s.id, cour.course_name, cour.score
    from students s
    left join courses cour on cour.student_id = s.id
    where cour.score < 60
    Group by s.id, cour.course_name, cour.score
    order by s.id
),
cours_filter as (
    Select * 
    from cours
    Where id in (Select id
                From cours
                Group by id
                Having count(id)>2)
)


Select s.id as student_id , s.name, 'quit studying' as reason
from students s
left join courses cour on cour.student_id = s.id
where  cour.student_id is null
union
Select st.id as student_id, st.name, (Select Concat('failed in ',string_agg(CONCAT(cr.course_name,'(',score::text,')'), ', '))
                                      from cours_filter cr
                                      where cr.id = st.id )  as reason
from students st join cours_filter  cr on st.id = cr.id
group by st.id, st.name
Order by student_id



