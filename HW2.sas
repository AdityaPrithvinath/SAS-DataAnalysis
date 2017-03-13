/* Creating a library for creating Datasets */
 
libname Aditya "C:\Study_UIC\IDS 462\DataSets";

/* Creating SAS Data set */
/* Question 2.1 */
DATA Aditya.Prob1;
   INPUT ID AGE GENDER $ GPA CSCORE;
DATALINES;
1 18 M 3.7 650
2 18 F 2.0 490
3 19 F 3.3 580
4 23 M 2.8 530
5 21 M 3.5 640
;

/* Tabulating the number of males and females in the dataset */

proc freq data = Aditya.Prob1;
tables GENDER;
run;

/* Creating the dataset and the derived variables AVE_BP,DBP and SBP */
/*Question 2.2*/
DATA Aditya.CLINIC;
INPUT ID $ 1-3 GENDER $ 4 RACE $ 5 HR 6-8 SBP 9-11 DBP 12-14 N_PROC 15-16; 
DIFF_ABS = abs(DBP-SBP); /* Absolute difference between Diastolic Blood pressure and Systolic Blood Pressure */
AVE_BP = DBP + (1/3) * DIFF_ABS; /* Average Blood pressure */
DATALINES;
001MW08013008010
002FW08811007205
003MB05018810002
004FB   10806801
005MW06812208204
006FB101   07404
007FW07810406603
008MW04811207006
009FB07719011009
010FB06616410610
;
run;

/* Computing the number of nonmissing values,mean,standard deviation, median and Confidence interval for Mean*/ 
PROC MEANS DATA=ADITYA.CLINIC N MEAN STDDEV CLM MEAN MEDIAN;
VAR SBP DBP AVE_BP;
RUN;

/*Question 2.3*/
/* Creating new variable based on the value of Age variable*/
DATA Aditya.hw3;
INPUT SSN Annual_Salary Age Race $;
IF Age GE 0 AND Age LE 35
	THEN AGE_GROUP=1;
ELSE IF AGE GT 35 
	THEN AGE_GROUP = 2;
DATALINES;
123874414 28000 35 W
646239182 29500 37 B
012437652 35100 40 W
018451357 26500 31 W
;
run;

/*Computing the number people in each age category based on Race*/
PROC FREQ DATA=Aditya.hw3;
   TABLES RACE AGE_GROUP / NOCUM; /*NO CUMULATIVE STATISTICS */
RUN;


/*QUESTION 2.5 DATASET*/
DATA Aditya.Prob2_5;
LENGTH GROUP $ 1;
INPUT X Y Z GROUP $;
DATALINES;
2   4   6   A
3   3   3   B
1   3   7   A
7   5   3   B
1   1   5   B
2   2   4   A
5   5   6   A
;
RUN;

/*QUESTION A - HISTOGRAM FOR GROUP */ 
PROC GCHART DATA=Aditya.Prob2_5;
 VBAR GROUP;
RUN;

/* QUESTION B - PLOT OF Y AND X */
PROC GPLOT DATA=Aditya.Prob2_5;
PLOT Y*X;
RUN;

/* QUESTION C- PLOTTING Y AND X FOR EACH GROUP */
/* SORTING DATA BASED ON GROUPS BEFORE APPLYING THE PROC GPLOT TO GENERATE TWO SEPERATE PLOTS*/

PROC SORT DATA= Aditya.Prob2_5;
BY GROUP;
RUN;

PROC GPLOT DATA=Aditya.Prob2_5;
BY GROUP;
PLOT Y*X ;
RUN;

/* QUESTION 2.8 */

/*CHART1-FREQUENCY OF EACH GENDER BASED ON RACE */

PROC GCHART DATA=Aditya.CLINIC;
VBAR GENDER / GROUP = RACE WIDTH= 10;
RUN;

/* CHART2 - DISTRIBUTION OF HEART RATE FOR DIFFERENT GENDER */
PROC GCHART DATA=Aditya.CLINIC ;
VBAR HR / GROUP = GENDER MIDPOINTS=50 TO 100 BY 10 PATTERNID= GROUP ;
RUN;

/* QUESTION 2.10 A*/
/*PLOT OF HEART RATE vs SYSTOLIC BLOOD PRESSURE AND A CHOSEN PLOTTING SYMBOL*/
PROC GPLOT DATA=Aditya.CLINIC ;
PLOT HR * SBP= 'STAR';
RUN;

/*QUESTION 2.10 B*/
/* PLOT OF SBP VS DBP WITH PLOTTING SYMBOL AS GENDER*/
PROC GPLOT DATA=Aditya.CLINIC ;
PLOT SBP * DBP = GENDER;
RUN;

/*QUESTION 2.10 C*/
/*PLOT OF SBP vs DBP GROUPED BY RACE*/
PROC SORT DATA=Aditya.CLINIC;
BY RACE;
RUN;

PROC GPLOT DATA=Aditya.CLINIC ;
BY RACE;
PLOT SBP * DBP = GENDER;
RUN;

