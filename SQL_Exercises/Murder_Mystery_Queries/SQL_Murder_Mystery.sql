-- Trying to find the crime scene report

SELECT *
FROM crime_scene_report
WHERE type = 'murder' AND city = 'SQL City'
ORDER BY date DESC

-- Following the clues and find the witnesses

SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC
LIMIT 1

-- Finding the other witness

SELECT *
FROM person
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave'

-- Searching for the witnesses' statements

SELECT *
FROM interview
WHERE person_id = 14887 OR person_id = 16371

-- Finding the suspects

SELECT *
FROM get_fit_now_check_in
WHERE membership_id LIKE '48Z%' AND check_in_date = '20180109' 

-- Finding suspect with gold membership

SELECT *
FROM get_fit_now_member
WHERE id LIKE '48Z%' AND membership_status = 'gold'

-- Finding the responsable fot the murderer

SELECT *
FROM person person, drivers_license drivers
ON person.license_id = drivers.id
WHERE plate_number LIKE '%H42W%' AND
	  person.id IN (28819,67318)

-- Murderer's statement

SELECT *
FROM interview
WHERE person_id = 67318

-- Trying to find the villain behind the crime with the description provided by the murderer

SELECT *
FROM drivers_license
WHERE gender = 'female' AND 
	  height BETWEEN 65 AND 67 AND
	  hair_color = 'red' AND
	  car_make = 'Tesla' AND
	  car_model = 'Model S'

-- The villain went 3 times to the SQL Symphnoy Concert in December

SELECT *, COUNT(*) TimesConcert
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert' AND
	  date LIKE '201712%'
GROUP BY person_id
HAVING COUNT(*) = 3

-- Only two people who went to the concert 3 times in December

SELECT *
FROM person
WHERE id IN (24556,99716)

-- Looking for all the women that went 3 times to the concert

SELECT person.name, fbevent.*
FROM  person person
INNER JOIN facebook_event_checkin fbevent ON fbevent.person_id = person.id 
INNER JOIN drivers_license driver ON person.license_id = driver.id
WHERE person.license_id IN (202298,291182,918773)
