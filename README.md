# Project 3 on SQL for data analysis
## Introduction
    In this project I dove into data job market, Focusing on Data Analyst roles. This project explores top paying jobs, in demand skills and were high demand meets high salary in data analytics.

    My SQL Queries! Check them out here: [SQL_Project3 folder](/SQL_Project3/)

## Background
While I am serching for Data Analyst roles in job market, I found a dataset from Luke B and this project was born from a desire to pinpoint top-paid and in demand skills to find optimal jobs

### Questions that I am answering in the SQL project
 - What are top paying jobs for my role?
 - What are the skills required for the top paying jobs for my role?
 - What are most in demand skills for my role?
 - What are the top skills based on salary for my role?
 - What are most optimal skills to learn?

## Tools Used
I harnessed the power of several tools
 - **SQL:** backbone of my analysis, allowing me to query the database and unearth critical insights
 - **PostgreSQL:** Database management system, ideal for handling job postings datasets
 - **Visual Studio Code:** My go-to for database management and executing SQL queries.
 - **GitHub:** Essential for version control and sharing my SQL scripts and analysis, it also ensures coloboration and project trcking. 

## Analysis part
Each query for this project aimed at investing specific aspects of the data analyst job market. 
Here's how I approached each question:

###  - What are top paying jobs for my role?
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
jpf.job_id, jpf.job_title, jpf.job_location, jpf.job_schedule_type, jpf.salary_year_avg, jpf.job_posted_date,
name as company_name
FROM  job_postings_fact as jpf
    LEFT JOIN company_dim as cd ON cd.company_id = jpf.company_id
WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' 
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
limit 10;
```
### What are the skills required for the top paying jobs for my role?
To identify the skills required for the highest-paying Data Analyst roles, I used a Common Table Expression (CTE) to first isolate the top 10 highest-paying jobs. Then, I joined this result with the skills tables to extract the specific skills associated with these roles. This helps understand what technical expertise is expected for top-tier positions.
```sql
WITH top_paying_jobs AS (
    SELECT 
        jpf.job_id, 
        jpf.job_title, 
        jpf.job_location, 
        jpf.job_schedule_type, 
        jpf.salary_year_avg, 
        jpf.job_posted_date,
        name AS company_name
    FROM job_postings_fact AS jpf
    LEFT JOIN company_dim AS cd 
        ON cd.company_id = jpf.company_id
    WHERE job_title_short = 'Data Analyst' 
      AND job_location = 'Anywhere' 
      AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT tpj.*, sd.skills
FROM top_paying_jobs AS tpj
INNER JOIN skills_job_dim AS sjd 
    ON tpj.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sd.skill_id = sjd.skill_id
ORDER BY tpj.salary_year_avg DESC
LIMIT 10;
```
### What are the most in-demand skills for my role?
To determine the most in-demand skills, I analyzed remote Data Analyst job postings and counted how frequently each skill appeared. This approach highlights the skills that employers are actively seeking in the current job market.
```sql
WITH remote_job_skills AS (
    SELECT 
        sdd.skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS sjd
    INNER JOIN job_postings_fact AS sd 
        ON sd.job_id = sjd.job_id
    INNER JOIN skills_dim AS sdd 
        ON sdd.skill_id = sjd.skill_id
    WHERE sd.job_work_from_home = TRUE 
      AND job_title_short = 'Data Analyst'
    GROUP BY sdd.skill_id
    LIMIT 5
)
SELECT 
    skd.skill_id, 
    skd.skills, 
    skill_count
FROM remote_job_skills AS rjs
INNER JOIN skills_dim AS skd 
    ON skd.skill_id = rjs.skill_id;
```

### What are the top skills based on salary?
To understand which skills offer the highest financial return, I calculated the average salary associated with each skill for Data Analyst roles. This helps identify which technical skills are most valuable in terms of compensation.
```sql
SELECT 
    sd.skills,  
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON sjd.job_id = jpf.job_id
INNER JOIN skills_dim AS sd 
    ON sd.skill_id = sjd.skill_id
WHERE salary_year_avg IS NOT NULL 
  AND job_title_short = 'Data Analyst'
  AND job_location = 'Anywhere'
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 10;
```
What are the most optimal skills to learn?
To find the most optimal skills, I combined both demand (frequency of job postings) and salary data. By filtering skills with significant demand and high average salaries, this query identifies the best skills to focus on for maximizing career growth and earning potential.
```sql
SELECT 
    sd.skill_id, 
    sd.skills, 
    COUNT(skills_job_dim.job_id) AS skill_count, 
    ROUND(AVG(jpf.salary_year_avg), 2) AS avg_salary 
FROM job_postings_fact AS jpf 
INNER JOIN skills_job_dim 
    ON jpf.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim AS sd 
    ON sd.skill_id = skills_job_dim.skill_id 
WHERE jpf.job_work_from_home = TRUE 
  AND jpf.job_title_short = 'Data Analyst' 
  AND jpf.salary_year_avg IS NOT NULL 
GROUP BY 
    sd.skill_id, 
    sd.skills
HAVING COUNT(skills_job_dim.job_id) > 10 
ORDER BY 
    avg_salary DESC, 
    skill_count DESC 
LIMIT 25;
```


## What I learned
Throughout this adventure, I have turbocharged my SQL toolkit with some serious firepower:

- **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding with clauses for ninja level temp table maneuvers.
- **Data Aggregation:** Got to know more about GROUP BY and turned aggregate functions like COUNT() and AVG() into my data summary sidekicks.
- **Analytical Wizardry:** Leveled up my real world problem solving skills, turning questions into actionable, insightful SQL Queries.

## Conclusion
## Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in
SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential tory)o seekers.
4. **5kaLLs with Hagher SaLaries**： Specialized
skills, such as SWN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics!
