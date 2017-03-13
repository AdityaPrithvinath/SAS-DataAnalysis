/* Problem 1.1 */ 
/*==============================================================*/

data hw1 ;
input ID Age Gender $ GPA CSCORE ; *Define the columns in the datalines input file;
datalines ;
1 18 M 3.7 650
2 18 F 2.0 490
3 19 F 3.3 580
4 23 M 2.8 530
5 21 M 3.5 640	
;
run;

/* Problem 1.1 b */

proc means data=hw1 mean;
var GPA CSCORE; *proc means for only the GPA and CSCORE;
run;

/* Problem 1.1 c */ 

data hw1_c;
set hw1; * importing the previously created dataset for further manipulation;
Index = GPA + (3 * CSCORE/500);
run;

proc sort data=hw1_c;
by Index; *Sorting based on the column Index;
run;

/*=====================================================================*/
/* Problem 1.2 */
/*=====================================================================*/

data hw2;
input Subj $ 1-3 Height 4-5 Wt_Init 6-8 Wt_Final 9-11; *Defining the columns in the dataline input;
BMI_Init= (Wt_Init / 2.2) / (Height ** 0.0254); *Computation based on formula provided;
BMI_Final= (Wt_Final / 2.2) / (Height ** 0.0254);
BMI_Diff= BMI_Final- BMI_Init;
datalines;
00768155150
00272250240
00563240200
00170345298
;
run;

/* Problem 1.2 b */

proc sort data=hw2 out=hw2_c(drop= Wt_Init Wt_Final); *Dropping unwanted columns;
by Subj;
run;

/*======================================================================*/
/* Problem 1.3 */
/*======================================================================*/

data hw3;
input SSN Annual_Salary Age Race $;
datalines;
123874414 28000 35 W
646239182 29500 37 B
012437652 35100 40 W
018451357 26500 31 W
;
run;

/* Problem 1.3 */

proc means data=hw3 mean;
var Annual_Salary Age ;
run;

/* Problem 1.3 b */

data hw3_b;
set hw3;
Tax = Annual_Salary * 0.3;
run;

proc sort data=hw3_b out=hw3_b_sorted(keep= SSN Annual_Salary Tax);
by SSN;
run;

/*=====================================================================*/
/* Problem 1.4 */
/*=====================================================================*/

DATA IQ_AND_TEST_SCORES;  
INPUT ID 1-3
	  IQ 4-6
	  MATH 7-9
	  SCIENCE 10-12;
DATALINES; *Reading data in-stream into a dataset;
001128550590
002102490501
003140670690
004115510510
;
run;
	
/* Problem 1.4 a */	  

data hw4;
set iq_and_test_scores;
OVERALL = ( IQ + MATH + SCIENCE)/500; *Overall value computation;
if IQ <= 100 and IQ >=0 Then GROUP = 1 ; *Bucketting based on IQ score into Groups;
else if IQ >100 and IQ < 141 Then GROUP = 2 ;
else if IQ >140 Then GROUP = 3;
run;

/* Problem 1.4 b*/

proc sort data=hw4 ;
by IQ;
run;

/*Problem 1.4 c */

proc freq data=hw4;
tables GROUP; *Studying the frequency of occurrence of each group;
run;

/*=================================================================*/
/* Problem 1.8 */
/*=================================================================*/

data hw8;
input EMPID 1-3 SALARY 5-10 JCLASS 11-12; *For variable width columns specifying a range of width to input as coulmns in the dataset;
if JCLASS = 1 Then Bonus = Salary * 0.1;
else if JCLASS = 2 Then Bonus = Salary * 0.15;
else if JCLASS = 3 Then Bonus = Salary * 0.20;
New_Salary = Bonus + Salary;
datalines;
137 28000 1
214 98000 3
199 150000 3
355 57000 2
;
run;

proc print data=hw8;
run;

/*==================================================================*/
  




