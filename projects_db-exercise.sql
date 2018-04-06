SELECT * FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id WHERE tech.id = 3;

SELECT project.name AS project_name, tech.name AS tech_name FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id WHERE project.name='Personal Website';

SELECT * FROM tech
LEFT OUTER JOIN project_uses_tech on tech.id = project_uses_tech.tech_id;

SELECT project.name AS project_name, COUNT(tech.id) FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id GROUP BY project.name;

SELECT * FROM project
LEFT OUTER JOIN project_uses_tech on project.id = project_uses_tech.project_id;

SELECT tech.name AS tech_name, COUNT(project.id) FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id GROUP BY tech.name;

SELECT project.name AS project_name, tech.name AS tech_name FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id ORDER BY project.name ASC;

SELECT DISTINCT (tech.name) FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id ORDER BY tech.name ASC;

SELECT * FROM tech
LEFT OUTER JOIN project_uses_tech on tech.id = project_uses_tech.tech_id WHERE project_id IS NULL;

SELECT DISTINCT (project.name) FROM project 
INNER JOIN project_uses_tech ON project.id = project_uses_tech.project_id
JOIN tech ON project_uses_tech.tech_id = tech.id ORDER BY project.name ASC;

SELECT * FROM project
LEFT OUTER JOIN project_uses_tech on project.id = project_uses_tech.project_id WHERE tech_id IS NULL;

SELECT project.name, COUNT(tech_id) AS tech_num FROM project
LEFT OUTER JOIN project_uses_tech ON project.id = project_uses_tech.project_id GROUP BY project.id ORDER BY tech_num DESC;

SELECT tech.name, COUNT(project_id) AS project_num FROM tech
LEFT OUTER JOIN project_uses_tech ON tech.id = project_uses_tech.tech_id GROUP BY tech.id ORDER BY project_num DESC;

SELECT project.name, ROUND(AVG(tech_id), 2) AS avg_tech_num FROM project
LEFT OUTER JOIN project_uses_tech ON project.id = project_uses_tech.project_id GROUP BY project.id ORDER BY avg_tech_num ASC;





