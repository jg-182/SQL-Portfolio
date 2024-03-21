# The SQL Murder Mystery!

## 1. The Problem
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a **​murder​** that occurred sometime on ​**Jan.15, 2018​** and that it took place in ​**SQL City​**. Start by retrieving the corresponding crime scene report from the police department’s database.


**Credits**  
The SQL Murder Mystery was created by Joon Park and Cathy He and was adapted and produced for the web by Joe Germuska ([Website](http://mystery.knightlab.com/)).

## 2. Understanding the Problem
In the next image, we can see the visual representation of the distinct tables that we have in our problem, as well as the Primary Keys and the Foreign Keys.  ![ERD](https://mystery.knightlab.com/schema.png)

## 3. Solving the Problem
First off, let's try to find the crime scene report that I lost. I know for a fact that it was a murder in SQL City.

    SELECT * 
    FROM crime_scene_report 
    WHERE type = 'murder' AND city = 'SQL City' 
    ORDER BY date DESC

This is the result of the query:

date | type | description | city
|-----|-----|-----|-----|
| 20180215 | murder | REDACTED REDACTED REDACTED | SQL City |
| 20180215 | murder | Someone killed the guard! He took an arrow to the knee! | SQL City |
| 20180115 | murder | Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave". | SQL City |

Here is the first clue. Let's investigate.

    SELECT *
    FROM person
    WHERE address_street_name = 'Northwestern Dr' 
    ORDER BY address_number DESC
    LIMIT 1

The result:
 

| id    | name           | license_id | address_number | address_street_name | ssn       |
|-------|----------------|------------|----------------|---------------------|-----------|
| 14887 | Morty Schapiro | 118009     | 4919           | Northwestern Dr     | 111564949 |


We discovered one of the witnesses - **Morty Shapiro - ID:14887**. Let´s find the other one.

    SELECT *
    FROM person
    WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave'

And we found the other one - **Annabel Miller - ID:16371**.

| id    | name           | license_id | address_number | address_street_name | ssn       |
|-------|----------------|------------|----------------|---------------------|-----------|
| 16371 | Annabel Miller | 490173     | 103            | Franklin Ave        | 318771143 |

Now that we've found the witnesses, let's look at their statements.
 
| person_id | transcript | 
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| 
| 14887 | I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W". | 
| 16371 | I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.|

Let's follow the hints:

    SELECT *
    FROM get_fit_now_check_in
    WHERE membership_id LIKE '48Z%' AND check_in_date = '20180109'

| membership_id | check_in_date | check_in_time | check_out_time |
|---------------|---------------|---------------|----------------|
| 48Z7A         | 20180109      | 1600          | 1730           |
| 48Z55         | 20180109      | 1530          | 1700           |

So we know that our suspect is a gold member and has a membership number starting with '48Z'.

    SELECT *
    FROM get_fit_now_member
    WHERE id LIKE '48Z%' AND membership_status = 'gold'


| id    | person_id | name          | membership_start_date | membership_status |
|-------|-----------|---------------|-----------------------|-------------------|
| 48Z7A | 28819     | Joe Germuska  | 20160305              | gold              |
| 48Z55 | 67318     | Jeremy Bowers | 20160101              | gold              |

Now we have two suspects. Let's try to narrow it down to just one, using the information provided by Annabel.

    SELECT *
    FROM person person, drivers_license drivers
    ON person.license_id = drivers.id
    WHERE plate_number LIKE '%H42W%' AND
    	  person.id IN (28819,67318)

I've found our suspect. The murderer was **Jeremy Bowers**.
  
| id | name | license_id | address_number | address_street_name | ssn | id | age | height | eye_color | hair_color | gender | plate_number | car_make | car_model |
|-------|---------------|------------|----------------|-----------------------|-----------|--------|-----|--------|-----------|------------|--------|--------------|-----------|-----------| 
| 67318 | Jeremy Bowers | 423327 | 530 | Washington Pl, Apt 3A | 871539279 | 423327 | 30 | 70 | brown | brown | male | 0H42W2 | Chevrolet | Spark LS |

**Wait!** Jeremy has something to say! Let's check his interview transcript.

    SELECT *
    FROM interview
    WHERE person_id = 67318

| person_id | transcript                                                                                                                                                                                                                                       | 
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 67318     | I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. | 

Now we know that he was the murderer, but we have to find the **real villain behind this crime**.

### 3.1 Finding the villain behind the murder (Option 1)

We know that Jeremy was hired by a woman who's around **65''-67''** tall. She also has **red hair** and drives a **Tesla Model S**.

    SELECT *
    FROM drivers_license
    WHERE gender = 'female' AND 
    	  height BETWEEN 65 AND 67 AND
    	  hair_color = 'red' AND
    	  car_make = 'Tesla' AND
    	  car_model = 'Model S'

| id     | age | height | eye_color | hair_color | gender | plate_number | car_make | car_model |
|--------|-----|--------|-----------|------------|--------|--------------|----------|-----------|
| 202298 | 68  | 66     | green     | red        | female | 500123       | Tesla    | Model S   |
| 291182 | 65  | 66     | blue      | red        | female | 08CM64       | Tesla    | Model S   |
| 918773 | 48  | 65     | black     | red        | female | 917UU3       | Tesla    | Model S   |

We also have the information that this woman went **3 times** to the **SQL Symphnoy Concert** in **December**.

    SELECT *, COUNT(*) TimesConcert
    FROM facebook_event_checkin
    WHERE event_name = 'SQL Symphony Concert' AND
    	  date LIKE '201712%'
    GROUP BY person_id
    HAVING COUNT(*) = 3

We only have two people who went to the concert 3 times in December.

| person_id | event_id | event_name           | date     | TimesConcert | 
|-----------|----------|----------------------|----------|--------------|
| 24556     | 1143     | SQL Symphony Concert | 20171224 | 3 |   
| 99716     | 1143     | SQL Symphony Concert | 20171229 | 3 |

Let's check who they are:

    SELECT *
    FROM person
    WHERE id IN (24556,99716)


| id    | name             | license_id | address_number | address_street_name | ssn       |
|-------|------------------|------------|----------------|---------------------|-----------|
| 24556 | Bryan Pardo      | 101191     | 703            | Machine Ln          | 816663882 |
| 99716 | Miranda Priestly | 202298     | 1883           | Golden Ave          | 987756388 | 

As we can see, only one of them is a woman. **Miranda Priestly** is our crime mastermind.

### 3.2 Finding the villain behind the murder (Option 2)

We know that Jeremy was hired by a woman who's around **65''-67''** tall. She also has **red hair** and drives a **Tesla Model S**.

    SELECT *
    FROM drivers_license
    WHERE gender = 'female' AND 
    	  height BETWEEN 65 AND 67 AND
    	  hair_color = 'red' AND
    	  car_make = 'Tesla' AND
    	  car_model = 'Model S'

| id     | age | height | eye_color | hair_color | gender | plate_number | car_make | car_model |
|--------|-----|--------|-----------|------------|--------|--------------|----------|-----------|
| 202298 | 68  | 66     | green     | red        | female | 500123       | Tesla    | Model S   |
| 291182 | 65  | 66     | blue      | red        | female | 08CM64       | Tesla    | Model S   |
| 918773 | 48  | 65     | black     | red        | female | 917UU3       | Tesla    | Model S   |

Let's find out all the women who went 3 times to the SQL Symphony Concert.

    SELECT person.name, fbevent.*
    FROM  person person
    INNER JOIN facebook_event_checkin fbevent ON fbevent.person_id = person.id 
    INNER JOIN drivers_license driver ON person.license_id = driver.id
    WHERE person.license_id IN (202298,291182,918773)


| name             | person_id | event_id | event_name           | date     |
|------------------|-----------|----------|----------------------|----------|
| Miranda Priestly | 99716     | 1143     | SQL Symphony Concert | 20171206 |
| Miranda Priestly | 99716     | 1143     | SQL Symphony Concert | 20171212 |
| Miranda Priestly | 99716     | 1143     | SQL Symphony Concert | 20171229 |

As we can see, **Miranda** is the only one!

> Congrats, you found the brains behind the murder! Everyone in SQL City
> hails you as the greatest SQL detective of all time. Time to break out
> the champagne!
