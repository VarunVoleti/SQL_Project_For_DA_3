
/*
What are most optimal skills to learn?/ High demand and high paying skills
- Identify skills in high demand and associated with high average salaries for data analyst roles
- Concentrate on remote positions with specified salaries
- What are target skills that offer job security and financial benefits?
*/

WITH remote_job_skills AS ( -- This CTE calculates the demand (count)
    SELECT 
        sdd.skill_id,
        sdd.skills,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS sjd
    INNER JOIN job_postings_fact AS jpf ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sdd ON sdd.skill_id = sjd.skill_id
    WHERE 
        jpf.job_work_from_home = TRUE 
        AND jpf.job_title_short = 'Data Analyst' 
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY sdd.skill_id, sdd.skills
),
average_salary AS ( -- This CTE calculates the average pay
    SELECT 
        sjd.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON sjd.job_id = jpf.job_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' 
        AND jpf.job_location = 'Anywhere' -- Usually synonymous with WFH in these datasets
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY sjd.skill_id
)

SELECT 
    remote_job_skills.skill_id,
    remote_job_skills.skills,
    remote_job_skills.skill_count,
    average_salary.avg_salary
FROM remote_job_skills
INNER JOIN average_salary ON remote_job_skills.skill_id = average_salary.skill_id
WHERE skill_count > 10 -- Adjust this threshold based on your dataset to focus on truly in-demand skills
ORDER BY avg_salary DESC -- Or ORDER BY avg_salary DESC depending on your goal
LIMIT 25;


--rewriting query
SELECT 
    sd.skill_id, 
    sd.skills, 
    COUNT(skills_job_dim.job_id) AS skill_count, 
    ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary 
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim AS sd ON sd.skill_id = skills_job_dim.skill_id 
WHERE 
    jpf.job_work_from_home = TRUE 
    AND jpf.job_title_short = 'Data Analyst' 
    AND jpf.salary_year_avg IS NOT NULL 
GROUP BY 
    sd.skill_id, 
    sd.skills -- Added this for SQL compliance
HAVING 
    COUNT(skills_job_dim.job_id) > 10 
ORDER BY 
    avg_salary DESC, 
    skill_count DESC 
LIMIT 25;

