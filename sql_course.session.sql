CREATE TABLE job_applied (
    job_id INT,
    application_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
)
;

select *
from job_applied;

INSERT INTO job_applied
(job_id, application_date, custom_resume, resume_file_name, cover_letter_sent,
 cover_letter_file_name, status)

 VALUES (1, '3-15-2026', true, 'varun_da_resume.1', false, 'none', 'Submitted'),
        (2, '3-17-2026', true, 'varun_da_resume.2', true, 'varun_ba_cover_letter', 'Submitted'),
        (3, '3-20-2026', true, 'varun_da_resume.3', false, 'none', 'Submitted'),
        (4, '3-22-2026', true, 'varun_da_resume.4', true, 'varun_ha_cover_letter', 'Submitted'),
        (5, '3-25-2026', true, 'varun_da_resume.5', false, 'none', 'Submitted');

select *
from job_applied;

ALTER TABLE job_applied
ADD contact VARCHAR(50);

select *
from job_applied;

UPDATE job_applied
SET contact = 'Varun Voleti'
WHERE job_id=1;

UPDATE job_applied
SET contact = 'Pranitha Patel'
WHERE job_id=2;

UPDATE job_applied
SET contact = 'Varun Singh'
WHERE job_id=3;

UPDATE job_applied
SET contact = 'Pranitha Pichi'
WHERE job_id=4;

UPDATE job_applied
SET contact = 'Pranitha Pakodi'
WHERE job_id=5;

select *
from job_applied;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

select *
from job_applied;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN status;

SELECT count(*) FROM job_applied;
SELECT count(*) FROM company_dim;
SELECT count(*) FROM skills_dim;
SELECT count(*) FROM job_postings_fact;