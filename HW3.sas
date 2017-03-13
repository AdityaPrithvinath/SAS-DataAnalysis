libname DIR1 'C:\Study_UIC\IDS 462\DataSets' ;
/* Problem 3.1 */
PROC FORMAT ;
VALUE GROUP_FRM 1='CONTROL GROUP'
			2='ASPIRIN'
			3='IBUPROFEN';
RUN;

data DIR1.HW331;
INPUT GROUP ;
DATALINES;
1
1
1
2
2
2
3
3
3
;



ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB3_1.PDF";
PROC PRINT DATA=DIR1.HW331;
FORMAT GROUP GROUP_FRM.;
RUN;
ODS PDF CLOSE;

/* PROBLEM 3.4 */

DATA DIR1.BLOOD;
DO I = 1 TO 500;      
WBC = INT(RANNOR(1368)*2000 + 5000);      
X = RANUNI(0);
IF X LT .05 THEN WBC = .;      
ELSE IF X LT .1 THEN WBC = WBC - 3000;      
ELSE IF X LT .15 THEN WBC = WBC + 4000;
OUTPUT;   
END;   
DROP I X;
RUN;


ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB3.4.PDF";
DATA DIR1.HW3_4_a;
SET DIR1.BLOOD;
IF (WBC < 3000) THEN WBC_N = 'Abnormally Low';
IF (WBC >= 3000) and (WBC < 4001) THEN WBC_N = 'Low';
IF (WBC >= 4001) and (WBC < 6001) THEN WBC_N = 'Medium';
IF (WBC >= 6001) and (WBC < 12001) THEN WBC_N = 'High';
IF (WBC > 12000) THEN WBC_N = 'Abnormally High';
IF (WBC = .)THEN WBC_N = 'Not Available';
RUN;

PROC FREQ DATA=DIR1.HW3_4_a;
TABLES WBC_N / MISSING NOCUM;
RUN;


PROC FORMAT;
VALUE WBC_COUNT LOW-3000   = 'Abnormally Low'
             	3000-4000  = 'Low'
             	4001-6000  = 'Medium'
             	6001-12000 = 'High'
				12001-HIGH = 'Abnormally High'
                    . = 'Not Available';
RUN;



DATA DIR1.HW3_4_B;
SET DIR1.BLOOD;
FORMAT WBC WBC_COUNT.;
RUN;

PROC FREQ DATA=DIR1.HW3_4_B;
TABLES WBC / MISSING NOCUM;
RUN;
ODS PDF CLOSE;

/* Problem 3.7 */
ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB3.7.PDF";
DATA DIR1.HW3_7;
INPUT ASTHMA $ SES $ COUNT;
DATALINES;
YES LOW 40
NO LOW 100
YES HIGH 30
NO HIGH 130
;

PROC FREQ DATA=DIR1.HW3_7;
TITLE "Chi Square Test for Relationship between Asthma and Socioeconomic Status";
TABLES SES*ASTHMA / CHISQ;
WEIGHT COUNT;
RUN;
ODS PDF CLOSE;

/* PROBLEM 3.14*/

PROC FORMAT;
VALUE PAIN 1='YES' 2='NO';
VALUE DOSE 1='LOW' 2='MEDIUM' 3='HIGH';
RUN;

DATA DIR1.DOSE;
DO DOSE = 1 TO 3;
	DO I = 1 TO 50;
		PAIN = 2 - (RANUNI(135) GT (0.6 +0.08*DOSE));
		OUTPUT;
	END;
END;
FORMAT PAIN PAIN. DOSE DOSE.;
RUN;

ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB3.14.PDF";
PROC FREQ DATA=DIR1.DOSE;
TABLES PAIN * DOSE / CHISQ;
RUN;

ODS PDF CLOSE;

/* As seen from the output generated from the Proc Freq output, the proportion of patients with significant pain shows considerable
drop as the dosage increases. The p-value associated with this test is 0.0194 hence the linear association between these two variables is significant.*/

/* Problem 5.1*/

DATA DIR1.PROB5_1;
INPUT X Y Z;
DATALINES;
1 3 15
7 13 7
8 12 5
3 4 14
4 7 10
;

/*pROBLEM 5.1 A */
ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB5.1.PDF";
PROC CORR DATA=DIR1.PROB5_1;
VAR X ;
WITH Y Z;
RUN;

/* PROBLEM 5.1 B */

PROC CORR DATA=DIR1.PROB5_1;
VAR X Y Z;
RUN;
ODS PDF CLOSE;


/*PROBLEM 5.2 */

DATA DIR1.EXAM;
INPUT (Q1-Q8)(1.);
DATALINES;
10101010
11111111
11110101
01100000
11110001
11111111
11111101
11111101
10110101
00010110
;

ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB5_2.PDF";
DATA DIR1.HW5_2;
SET DIR1.EXAM;
TOTAL = SUM(OF Q1-Q8);
RUN;

PROC CORR DATA=DIR1.HW5_2;
TITLE "Correlation of Total with"
VAR Q1-Q8;
WITH TOTAL;
RUN;
ODS PDF CLOSE;

/*Problem 5.3*/

DATA DIR1.SYSBP;
INPUT AGE SBP;
DATALINES;
15 116
20 120
25 130
30 132
40 150
50 148
;
ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB5_3.PDF";
PROC CORR DATA=DIR1.SYSBP;
VAR SBP AGE;
RUN;
ODS PDF CLOSE;

/* Problem 5.5*/

ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\HW3\PROB5_5.PDF";
PROC REG DATA=DIR1.PROB5_1;
MODEL Y = X ;
RUN;
ODS PDF CLOSE;

/* Problem 5.5 b and c*/
/* The intercept is 0.78916 and the slope is 1.524 */
/* The p-value for slope is 0.0078 and that for intercept is 0.5753. Hence we can reject the NULL hypothesis that
the coefficient is equal to zero for the slope but not for the intercept(since it has a high p value and is not significantly 
different from zero.*/

