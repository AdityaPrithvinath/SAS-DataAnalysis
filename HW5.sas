libname dlib 'C:\Study_UIC\IDS 462\DataSets' ;

ods pdf file="C:\Users\adity\OneDrive\Documents\UIC\sas\hw5\Homework5.PDF";
ODS TRACE ON;


data dlib.Q91;
input yeild light water @@;
datalines;
12 1  1  20 2  2
9  1  1  16 2  2
8  1  1  16 2  2
13 1  2  18 3  1
15 1  2  25 3  1
14 1  2  20 3  1
16 2  1  25 3  2
14 2  1  27 3  2
12 2  1  29 3  2
;
run;

proc format;
 value l_trans 1=5
 			 2=10
             3=15;
run;


proc reg data=dlib.Q91;
   title "Question 9-1";
   format light l_trans.;
   model yeild = light water;
run;

data dlib.tomato1;
set dlib.Q91;
if light=2 then light_b2=1;else light_b2=0;
if light=3 then light_b3=1;else light_b3=0;
if water= 2 then water_b=1;
else water_b=0;
run;

proc print data=dlib.tomato1;
title "Dummy Variable Encoding Q 9-2";
run;

data dlib.library;
   input BOOKS S_ENROLL DEGREE AREA;
datalines;
 4   5  3   20
 5   8  3   40
10  40  3  100
 1   4  2   50
 5   2  1  300
 2   8  1  400
 7  30  3   40
 4  20  2  200
 1  10  2    5
 1  12  1  100
;
proc reg data=dlib.library;
title "Question 9-3";
   model BOOKS = S_ENROLL DEGREE AREA / selection=FORWARD;
run;

data dlib.library1;
set dlib.library;
if degree=2 then degree_b1=1; else degree_b1=0;
if degree=3 then degree_b2=1; else degree_b2=0;
if degree=1 then degree_b1=0 and degree_b2=0;
area_log=log(area);
run;

proc print data=dlib.library1;
title "Dummy Variable Encoding and Transformation Question 9-4";
run;

PROC FORMAT;  
VALUE YESNO 1='YES' 0='NO';   
VALUE OUTCOME 1='Case' 0='Control';
RUN;

DATA DLIB.SMOKING;   
DO SUBJECT = 1 TO 1000;
	DO OUTCOME = 0,1;        
		IF RANUNI(567) LT .1 OR RANUNI(0)*OUTCOME GT .5 
		THEN             
			SMOKING = 1;         
		ELSE 
			SMOKING = 0;         
		IF RANUNI(0) LT .05 OR (RANUNI(0)*OUTCOME + .1*SMOKING) GT .6
		THEN 
			ASBESTOS = 1;    
 		ELSE 
			ASBESTOS = 0;         
		IF RANUNI(0) LT .3 OR OUTCOME*RANUNI(0) GT .9 
		THEN 
			SES = '1-Low   ';        
		ELSE IF RANUNI(0) LT .3 OR OUTCOME*RANUNI(0) GT .8 
		THEN 
			SES = '2-Medium';         
		ELSE 
			SES = '3-High';         
	OUTPUT;      
	END;   
END;   
FORMAT SMOKING ASBESTOS YESNO. OUTCOME OUTCOME.;
RUN;

PROC FREQ DATA=DLIB.SMOKING;
TITLE "QUESTION 9-8";
TABLES OUTCOME*SMOKING /CHISQ RELRISK ;
RUN;

PROC LOGISTIC DATA=DLIB.SMOKING;
TITLE "LOGISTIC REGRESSION 9-8";
MODEL OUTCOME = SMOKING;
RUN;

PROC LOGISTIC DATA=DLIB.SMOKING ;
title "Question 9.10";
CLASS SES(PARAM=REF REF='2-Medium');
MODEL OUTCOME= SMOKING ASBESTOS SES;
RUN;
ODS TRACE OFF;
ODS PDF CLOSE;

