WITH remote_job_skills AS 
(
    SELECT sdd.skill_id,count(*)as skill_count
    FROM skills_job_dim as sjd
    INNER JOIN job_postings_fact as sd on sd.job_id =  sjd.job_id
    INNER JOIN skills_dim as sdd ON sdd.skill_id = sjd.skill_id
    where sd.job_work_from_home = TRUE AND job_title_short = 'Data Analyst'
    GROUP BY  sdd.skill_id
    limit 5
)
SELECT skd.skill_id, skd.skills, skill_count
FROM remote_job_skills as   rjs
INNER JOIN skills_dim as skd ON skd.skill_id =  rjs.skill_id;