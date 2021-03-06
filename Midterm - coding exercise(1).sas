
%let UID1=657758531 ;
/***********************************************************************************/


/* Use the appropriate LIBNAME syntax to define a permanent SAS library on your machine */
libname PERM1 'C:\Study_UIC\IDS 462\DataSets' ;



ODS TRACE ON;
ODS PDF FILE="C:\Users\adity\OneDrive\Documents\UIC\sas\Coding_Assignment.pdf";

/***********************************************************************************/
/* Create Data Set from .CSV File                                                  */
/***********************************************************************************/
filename in1 'C:\Study_UIC\IDS 462\DataSets\Midterm Exam Data File.csv' ;

data Midterm_Exam (drop=Gender) ;
format ACCT_REP $32. ;
infile in1 delimiter=',' firstobs=2 missover ;
input ACCT_REP $ AGE Region $ Gender $ 
Revenue_Product1 Revenue_Product2 Revenue_Product3 Revenue_Product4 Revenue_Product5 
Mktg_Spend_Product1 Mktg_Spend_Product2 Mktg_Spend_Product3 Mktg_Spend_Product4 Mktg_Spend_Product5 ;
ACCT_REP = substr(ACCT_REP, 1 , 1) ||" "|| substr(ACCT_REP, index(ACCT_REP , " ")+1 ) ;
run ;


data PERM1.Midterm_Exam_&UID1. (drop=Revenue_Product4 Revenue_Product5 Mktg_Spend_Product4 Mktg_Spend_Product5 );
set Midterm_Exam ;
E=ranuni(&UID1.) ;
if E > .5 then do ; GENDER="F" ; end ;
	else do ; GENDER="M" ; end ;
YRS_EXPERIENCE = int( 10+(ranuni(&UID1.)-.5)*4+4*rannorm(&UID1.) ) ;
Revenue_Product1=int(Revenue_Product1*(1-(E/10))  );
Revenue_Product2=int(Revenue_Product2*(1-(E/10))  );
Revenue_Product3=int(Revenue_Product3*(1-(E/10))  );
/*Revenue_Product4=int(Revenue_Product4*(1-(E/10))  );
Revenue_Product5=int(Revenue_Product5*(1-(E/10))  ); */
Mktg_Spend_Product1=int(Mktg_Spend_Product1*(1-(E/10))  );
Mktg_Spend_Product2=int(Mktg_Spend_Product2*(1-(E/10))  );
Mktg_Spend_Product3=int(Mktg_Spend_Product3*(1-(E/10))  ); 
/*Mktg_Spend_Product4=int(Mktg_Spend_Product4*(1-(E/10))  ); 
Mktg_Spend_Product5=int(Mktg_Spend_Product5*(1-(E/10))  ); */
run ;






/***********************************************************************************/
/* Begin exam exercises here               */
/***********************************************************************************/

/***********************************************************************************/
/* Question Set 1: Data management                                                 */
/***********************************************************************************/
/*New variable creation in the data step and formatting of the variables*/
data PERM1.Midterm2 ;
set PERM1.Midterm_Exam_&UID1. ;
REVENUE_TTL=REVENUE_PRODUCT1+REVENUE_PRODUCT2+REVENUE_PRODUCT3;
MKTG_SPEND_TTL=MKTG_SPEND_PRODUCT1+MKTG_SPEND_PRODUCT2+MKTG_SPEND_PRODUCT3;
FORMAT REVENUE_TTL REVENUE_PRODUCT1 REVENUE_PRODUCT2 REVENUE_PRODUCT3 MKTG_SPEND_TTL 
MKTG_SPEND_PRODUCT1 MKTG_SPEND_PRODUCT2 MKTG_SPEND_PRODUCT3 DOLLAR10.2;
run ;



/***********************************************************************************/
/* Generate output that describes the contents of PERM1.MIDTERM2                   */
/***********************************************************************************/
PROC SORT DATA=PERM1.Midterm2 out=PERM1.MIDTERM2_SORTED; 
BY DESCENDING REVENUE_TTL ; *sorting based on column REVENUE_TTL in descending;
run ;
/*Printing the data set to find the first record in the sorted data set*/
PROC PRINT DATA=PERM1.Midterm2_SORTED;
title " First Value of  ACCT_REP";
run;


/* Eliminate original (perm) version of midterm dataset */
/*proc datasets lib=PERM1 ;*/
*delete ... /* Reference the custom dataset name that includes your UID at the end*/ ;
*run ; 
*quit ;



/********************************************************/
/* Question Set 2: Describe variables in PERM1.MIDTERM2 */
/********************************************************/
PROC CONTENTS DATA=PERM1.MIDTERM2;
title "Describing the PERM1.MIDTERM2 dataset";
RUN;

proc means data=PERM1.Midterm2 N MEAN MIN MAX STDDEV ;
title "Proc Means of  REVENUE_TTL and MKTG_SPEND_TTL";
var REVENUE_TTL MKTG_SPEND_TTL;
run ;

/*PROC UNIVARIATE and histogram of REVENUE_TTL and MKTG_SPEND_TTL*/
proc univariate data=PERM1.Midterm2 ;
title "Univariate analysis of REVENUE_TTL and MKTG_SPEND_TTL(normal overlay)";
VAR REVENUE_TTL MKTG_SPEND_TTL;
HISTOGRAM /normal (midpercents); *normal curve overlay on the histogram output;
run ;


proc univariate data=PERM1.Midterm2 ;
title "Univariate analysis of REVENUE_TTL and MKTG_SPEND_TTL(Lognormal overlay)";
VAR REVENUE_TTL MKTG_SPEND_TTL;
HISTOGRAM / lognormal (midpercents); *lognormal curve overlay on histogram;
run ;

/*One way frequency distribution of REGION using PROC FREQ*/
proc freq data=PERM1.Midterm2;
title "REGION 05 occurences in Data Set";
TABLE REGION;
run ;


proc freq data=PERM1.Midterm2;
title "Chi-Square Test for Uniform Proportions";
TABLE REGION / CHISQ;
run ;

proc freq data=PERM1.Midterm2;
title "Chi-Square Test for Uniform Proportions with Weight REVENUE_TTL";
TABLE REGION / CHISQ;
WEIGHT REVENUE_TTL;
run ;

/****************************************************/
/* Question Set 3: Association between variables    */
/****************************************************/
proc plot data=PERM1.Midterm2;
title "Plot of REVENUE_TTL and MKTG_SPEND_TTL";
plot REVENUE_TTL*MKTG_SPEND_TTL; 
run ; quit ;


proc plot data=PERM1.Midterm2;
title "Plot of REVENUE_TTL and MKTG_SPEND_TTL for GENDER= Male";
plot REVENUE_TTL*MKTG_SPEND_TTL=GENDER; 
WHERE GENDER='M';
run ; quit ;

/* Discretize Total Revenue and Total Mktg Spend variables via formats. */
proc format ;
value rev_ttlfmt low-700 = 'Low'
				700-1100='Med'
				1100-high='High' ;
value mktg_ttlfmt low-200 = 'Low'
				200-300='Med'
				300-high='High' ;
run ;

/* Analyze discretized Total Revenue and Total Mktg Spend variables for association 
data PERM1.Midterm_Discrete;
set PERM1.Midterm2;
input REVENUE_TTL rev_ttlfmt. MKTG_SPEND_TTL mktg_ttlfmt.;
RUN;*/

proc freq data=PERM1.Midterm2;
title "Chi-Sq test for association between REVENUE_TTL and MKTG_SPEND_TTL";
tables REVENUE_TTL * MKTG_SPEND_TTL / chisq ;
format REVENUE_TTL rev_ttlfmt. MKTG_SPEND_TTL mktg_ttlfmt.;
RUN;
run ;

/* Analyze pairwise relationships between continuous variables. */
proc corr data=PERM1.Midterm2;
var REVENUE_TTL REVENUE_PRODUCT1 REVENUE_PRODUCT2 REVENUE_PRODUCT3
MKTG_SPEND_TTL MKTG_SPEND_PRODUCT1 MKTG_SPEND_PRODUCT2 MKTG_SPEND_PRODUCT3;
run ;

proc corr data=PERM1.Midterm2 PEARSON;
title "Correlations with PROC CORR for all REVENUE.. and MKTG.. Variables";
var REVENUE_TTL REVENUE_PRODUCT1 REVENUE_PRODUCT2 REVENUE_PRODUCT3
MKTG_SPEND_TTL MKTG_SPEND_PRODUCT1 MKTG_SPEND_PRODUCT2 MKTG_SPEND_PRODUCT3 ;
run ;


proc corr data=PERM1.Midterm2;
title "Partial Correlation with PROC CORR for all REVENUE.. and MKTG.. Variables";
var REVENUE_TTL REVENUE_PRODUCT1 REVENUE_PRODUCT2 REVENUE_PRODUCT3
MKTG_SPEND_TTL MKTG_SPEND_PRODUCT1 MKTG_SPEND_PRODUCT2 MKTG_SPEND_PRODUCT3;
partial YRS_EXPERIENCE; *Controlling for shared effects of YRS_EXPERIENCE;
run ;


/* Estimate the best linear fit between Revenue_TTL and Mktg_Spend_TTL */
proc reg data=PERM1.Midterm2;
title "Linear regression of REVENUE_TTL and MKTG_SPEND_TTL";
model REVENUE_TTL = MKTG_SPEND_TTL;
run ; quit ;


/* Estimate a two-sample t-test for the difference in average value of PRODUCT1_REVENUE across values of GENDER */
proc ttest data=PERM1.Midterm2 ;
title "Difference in average value of PRODUCT1_REVENUE between GENDER";
class GENDER;
var REVENUE_PRODUCT1;
run ; quit ;

/*Sorting the data set based on gender*/
proc sort data=PERM1.Midterm2 out=PERM1.Midterm2_Sorted;
BY GENDER;
run;

DATA PERM1.MIDTERM2_SAMPLE;
SET PERM1.Midterm2_Sorted;
RNum = RANUNI (76543);
run;

/* Creating a sample of 10% using seed 76543 from the original dataset*/

DATA PERM1.MIDTERM2_SAMPLE(where=(RNum le 0.1));
SET PERM1.Midterm2_Sample;
run;

/* unable to Run Wilcoxon Test on this dataset(PERM1.MIDTERM2.SAMPLE) ,since it contain only Male*/

/*generating a 10% dataset from original set*/
DATA PERM1.MIDTERM2_SAMPLE_Wilcoxon;
SET PERM1.Midterm2(obs=10);
run;

/* Estimate a non-parametric two-sample test for the difference in average value of PRODUCT1_REVENUE across values of GENDER */
proc NPAR1WAY data=PERM1.MIDTERM2_SAMPLE_Wilcoxon wilcoxon;
title "Nonparametric test to compare average value of PRODUCT1_REVENUE across values of GENDER";
class GENDER;
var REVENUE_PRODUCT1;
exact wilcoxon;
 run;
 quit ;

ODS PDF CLOSE;
ODS TRACE OFF;	

