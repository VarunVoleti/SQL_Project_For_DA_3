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
