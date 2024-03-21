SELECT *
FROM StressLevelDataset

-- DESCRIPTIVE STATISTICS
-- Number of students in the dataset

SELECT COUNT(*) NumberOfStudents
FROM StressLevelDataset

-- Average anxiety level
-- Anxiety: range from 0 to 21, Measure : GAD-7

SELECT AVG(anxiety_level) AvgAnxietyLevel
FROM StressLevelDataset

-- Number of students who reported a history of mental health problems
-- Mental Health History: 0 if no mental health history, 1 if mental health history

SELECT COUNT(*) NumStudentsMH
FROM StressLevelDataset
WHERE mental_health_history = 1


-- PSYCHOLOGICAL FACTORS
-- How many students have a self-esteem level below the average?
-- Self-esteem : range 0 to 30, Measure: Rosenberg Self Esteem Scale

SELECT COUNT(*) NumStudentsLowSE
FROM StressLevelDataset
WHERE self_esteem < (
	SELECT AVG(self_esteem) 
	FROM StressLevelDataset
	)

-- What percentage of students have reported experiencing depression?
-- Depression : range 0 to 27, Measure: Patient Health Questionnaire (PHQ-9)

WITH CTE_1 AS (
SELECT CASE WHEN depression > 0 THEN 1.0
	   ELSE 0
	   END depression_calc
FROM StressLevelDataset
)
SELECT SUM(depression_calc)/COUNT(*) DepressionPctg
FROM CTE_1

--1-4 Minimal depression
--5-9 Mild depression
--10-14 Moderate depression
--15-19 Moderately severe depression
--20-27 Severe depression 

SELECT SUM(CASE WHEN depression BETWEEN 1 AND 4 THEN 1 ELSE 0 END) Minimal_Depression,
	   SUM(CASE WHEN depression BETWEEN 5 AND 9 THEN 1 ELSE 0 END) Mild_Depression,
	   SUM(CASE WHEN depression BETWEEN 10 AND 14 THEN 1 ELSE 0 END) Moderate_Depression,
       SUM(CASE WHEN depression BETWEEN 15 AND 19 THEN 1 ELSE 0 END) Moderately_Severe_Depression,
	   SUM(CASE WHEN depression BETWEEN 20 AND 27 THEN 1 ELSE 0 END) Severe_Depression,
	   SUM(CASE WHEN depression = 0 THEN 1 ELSE 0 END) No_Signs_of_Depression
FROM StressLevelDataset


-- PHYSIOLOGICAL FACTORS
-- How many students experience headaches frequently?

SELECT COUNT(*) NumStudHeadaches
FROM StressLevelDataset
WHERE headache in (4,5)

-- How many students rate their sleep quality as poor?

SELECT COUNT(*) NumStudPoorSleep
FROM StressLevelDataset
WHERE sleep_quality IN (0,1)


-- ENVIRONMENTAL FACTORS
-- How many students live in conditions with high noise levels?

SELECT COUNT(*) NumStudHighNoise
FROM StressLevelDataset
WHERE noise_level IN (4,5)

-- What percentage of students feel unsafe in their living conditions?

SELECT ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM StressLevelDataset),2) PctgStudUnsafe
FROM StressLevelDataset
WHERE living_conditions < 2

-- How many students have reported not having their basic needs met?

SELECT COUNT(*) StudWithoutBasicNeeds
FROM StressLevelDataset
WHERE basic_needs < 2


-- ACADEMIC FACTORS
-- How many students rate their academic performance as below average?

SELECT COUNT(*) NumStudBelowAvg
FROM StressLevelDataset
WHERE academic_performance < (
	SELECT AVG(academic_performance) 
	FROM StressLevelDataset
	)

-- What is the average study load reported by students?

SELECT AVG(study_load) AvgStudyLoad
FROM StressLevelDataset

-- How many students have concerns about their future careers?

SELECT COUNT(future_career_concerns) StuConcerned
FROM StressLevelDataset
WHERE future_career_concerns > 0


-- SOCIAL FACTORS
-- How many students feel they have strong social support?

SELECT COUNT(social_support) StuStrgSocialSupport
FROM StressLevelDataset
WHERE social_support = 3

-- What percentage of students have experienced bullying?

SELECT ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM StressLevelDataset),2) PctgBullying
FROM StressLevelDataset
WHERE bullying > 0

-- How many students participate in extracurricular activities?

SELECT COUNT(*) StuExtraActv
FROM StressLevelDataset
WHERE extracurricular_activities > 0
