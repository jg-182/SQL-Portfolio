# Student Stress Factors: A Comprehensive Analysis

This project consists of analysing a [dataset](https://www.kaggle.com/datasets/rxnach/student-stress-factors-a-comprehensive-analysis/data) about the stress factors of secondary school and university students, according to the author.
This dataset contains 21 variables, divided into 5 groups: 

 - Psychological Factors;
 - Physiological Factors;
 - Environmental Factors;
 - Academic Factors;
 - Social Factor.

It is important to note that the variables do not all have the same scale. Some variables are **binary**, others range from **0 to 3**, others from **0 to 5** and others follow the **chosen scale**. For example, the "**anxiety**" variable has the value obtained from the [GAD-7 Assessment](https://adaa.org/sites/default/files/GAD-7_Anxiety-updated_0.pdf) ; the "**self-esteem**" variable follows the [Rosenberg scale](https://fetzer.org/sites/default/files/images/stories/pdf/selfmeasures/Self_Measures_for_Self-Esteem_ROSENBERG_SELF-ESTEEM.pdf); the "**depression**" variable follows the [Patient Health Questionnaire (PHQ-9)](https://med.stanford.edu/fastlab/research/imapp/msrs/_jcr_content/main/accordion/accordion_content3/download_256324296/file.res/PHQ9%20id%20date%2008.03.pdf) scale.


# Questions

### Descriptive Statistics
 - How many students are in the dataset?
 - What is the average anxiety level of students in the dataset?
 - How many students have reported a history of mental health problems?

### Psychological Factors
 - How many students have a self-esteem level below the average?
 - What percentage of students have reported experiencing depression?

### Physiological Factors
 - How many students experience headaches frequently?
 - How many students rate their sleep quality as poor?

### Environmental Factors
 - How many students live in conditions with high noise levels?
 - How many students rate their sleep quality as poor?

### Academic Factors
 - How many students rate their academic performance as below average?
 - What is the average study load reported by students?
 - How many students have concerns about their future careers?

### Social Factors
 - How many students feel they have strong social support?
 - What percentage of students have experienced bullying?
 - How many students participate in extracurricular activities?

# Findings

### Descriptive Statistics
 - There are **1100** students in this dataset.
 - On a scale from 0 to 21, the average anxiety level is **11**.
 - Considering that the **mental_health_history** variable is binary, there are 542 students who reported a history of mental health problems, which is almost **50%**.

### Psychological Factors
 - There are **467** students with a self-esteem below average. 
 - Considering the **Patient Health Questionnaire (PHQ-9)**:

| **Total Score** |    **Depression Severity**   |
|:---------------:|:----------------------------:|
|       1-4       |      Minimal depression      |  
|       5-9       |        Mild depression       |   
|      10-14      |      Moderate depression     |   
|      15-19      | Moderately severe depression |   
|      20-27      |       Severe depression      | 

The students who have not experienced any kind of depression are the ones with a score of 0.

Thus, **96%** of the students analysed experienced some kind of depression.

|    **Depression Severity**   | **Number of Students** |   
|:----------------------------:|:----------------------:|
|    No Signs of Depression    |           44           |
|      Minimal Depression      |           154          |
|        Mild Depression       |           216          |
|      Moderate Depression     |           295          |
| Moderately Severe Depression |           137          |
|       Severe Depression      |           254          |

These results are worrying. More than **60%** of the students scored above 10 on the questionnaire, with **254 showing signs of severe depression**.

### Physiological Factors
 - **269** students experience headaches frequently and **362** rate their sleep quality as poor.

### Environmental Factors
 - **19%** of the students feel unsafe in their living conditions and **274** students live in conditions with high noise levels. Additionally, **213** students reported not having their basic needs met.

### Academic Factors
 - **213** students rate their academic performance as below average.
 - On a scale from 0 to 5, the average study load reported by students is **2**.
 - **1070** students show some concern about their future careers.

### Social Factors
 - Only **458** students feel that they have strong social support.
 - It's very worrying to see that **96%** of students have experienced bullying.
 - On the other hand, it's good to see that **1066** students participate in extracurricular activities.
