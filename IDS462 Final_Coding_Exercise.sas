

%let UID=657758531;
%let UID8=%substr(&UID., 1, 8);
%put &UID. &UID8. ;



filename in1 'C:\Users\adity\OneDrive\Documents\UIC\sas\CodingExercise2\FINAL.csv' ;



data FINAL ;
infile in1 delimiter=',' firstobs=2 missover ;
format ID 6. CUSTOMER $20. AGE 4. INCOME dollar10.2 DATA_PLAN $2. VOICE_PLAN $2. MARKET $10. DEVICE_PRIMARY $8.
	DEVICES_NUM 4. BASE_PLAN_RATE dollar10.2 DATA_OVERAGE_MO dollar10.2 DATA_PLAN_UPSELL_YN $2. 
	DATA_PLAN_UPSELL_REVENUE dollar10.2 ;
input ID CUSTOMER $ AGE INCOME DATA_PLAN $ VOICE_PLAN $ MARKET $ DEVICE_PRIMARY $ DEVICES_NUM BASE_PLAN_RATE 
	DATA_OVERAGE_MO DATA_PLAN_UPSELL_YN $ DATA_PLAN_UPSELL_REVENUE ;
run ;

data FINAL ;
set FINAL ;
AGE=AGE*(1+(ranuni(&UID8.)-.5)/100) ;
INCOME=INCOME*(1+(ranuni(&UID8.)-.5)/100) ;
BASE_PLAN_RATE=BASE_PLAN_RATE*(1+(ranuni(&UID8.)-.5)/100) ;
DATA_OVERAGE_MO=DATA_OVERAGE_MO*(1+(ranuni(&UID8.)-.5)/100) ;
run ;


/****************************************************************************************/
/****************************************************************************************/
ods pdf file='C:\Users\adity\OneDrive\Documents\UIC\sas\CodingExercise2\IDS462FINAL.pdf';





PROC MEANS DATA=final MEAN MIN MAX STDDEV ;
TITLE "QUESTION 1-A";
var AGE BASE_PLAN_RATE DATA_OVERAGE_MO DATA_PLAN_UPSELL_REVENUE DEVICES_NUM INCOME;
RUN;

PROC FREQ DATA=FINAL;
TITLE "QUESTION 1-B";
TABLES DATA_PLAN DATA_PLAN_UPSELL_YN DEVICE_PRIMARY MARKET VOICE_PLAN;
RUN;



proc anova data=final ;
TITLE " QUESTION 2-A ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
run ; quit ;

proc anova data=final ;
TITLE " QUESTION 2-B ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
WHERE MARKET = "N AMERICA";
run ; quit ;

proc anova data=final ;
TITLE " QUESTION 2-C ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MEANS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY /SCHEFFE;
WHERE MARKET = "N AMERICA";
run ; quit ;


proc glm data=final ;
TITLE " QUESTION 3-A ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
run ; quit ;

proc glm data=final ;
TITLE " QUESTION 3-B ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
WHERE MARKET = "N AMERICA";
run ; quit ;

ods trace on;
proc glm data=final ;
TITLE " QUESTION 3-D ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY ;
MEANS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY /SCHEFFE;
ods exclude "Type I Model ANOVA";
WHERE MARKET = "N AMERICA";
run ; quit ;
ods trace off;

proc glm data=final ;
TITLE " QUESTION 3-E ";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY;
MODEL DATA_OVERAGE_MO = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY DATA_PLAN*DEVICE_PRIMARY;
MEANS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY DATA_PLAN*DEVICE_PRIMARY/SCHEFFE;
ods exclude "Type I Model ANOVA";
WHERE MARKET = "N AMERICA";
run ; quit ;



PROC LOGISTIC DATA=FINAL DESCENDING;
TITLE "QUESTION 4";
CLASS DATA_PLAN VOICE_PLAN DEVICE_PRIMARY DEVICES_NUM / PARAM=REFERENCE REF=FIRST;
MODEL DATA_PLAN_UPSELL_YN = DATA_PLAN VOICE_PLAN DEVICE_PRIMARY DEVICES_NUM AGE INCOME BASE_PLAN_RATE DATA_OVERAGE_MO / SELECTION=STEPWISE;
WHERE MARKET= "N AMERICA";
RUN;



/* Create Dummy Variables w EFFECT CODING */
data WORK.FINAL_DV ;
set WORK.FINAL ;
TITLE "QUESTION 5";
if DATA_PLAN = "A" then do ; DATA_PLAN_A=1; DATA_PLAN_B=0; DATA_PLAN_C=0; end;
ELSE if DATA_PLAN = "B" then do ; DATA_PLAN_A=0; DATA_PLAN_B=1; DATA_PLAN_C=0; end;
ELSE if DATA_PLAN = "C" then do ; DATA_PLAN_A=0; DATA_PLAN_B=0; DATA_PLAN_C=1; end;
ELSE if DATA_PLAN = "D" then do ; DATA_PLAN_A=-1; DATA_PLAN_B=-1; DATA_PLAN_C=-1; end;
WHERE DATA_PLAN IN ('A','B','C','D');
if VOICE_PLAN = "A" then do ; VOICE_PLAN_A=1; VOICE_PLAN_B=0; VOICE_PLAN_C=0; end;
ELSE if VOICE_PLAN = "B" then do ; VOICE_PLAN_A=0; VOICE_PLAN_B=1; VOICE_PLAN_C=0; end;
ELSE if VOICE_PLAN = "C" then do ; VOICE_PLAN_A=0; VOICE_PLAN_B=0; VOICE_PLAN_C=1; end;
ELSE if VOICE_PLAN = "D" then do ; VOICE_PLAN_A=-1; VOICE_PLAN_B=-1; VOICE_PLAN_C=-1; end;
WHERE VOICE_PLAN IN ('A','B','C','D');
if VOICE_PLAN = "A" then do ; VOICE_PLAN_A=1; VOICE_PLAN_B=0; VOICE_PLAN_C=0; end;
ELSE if VOICE_PLAN = "B" then do ; VOICE_PLAN_A=0; VOICE_PLAN_B=1; VOICE_PLAN_C=0; end;
ELSE if VOICE_PLAN = "C" then do ; VOICE_PLAN_A=0; VOICE_PLAN_B=0; VOICE_PLAN_C=1; end;
ELSE if VOICE_PLAN = "D" then do ; VOICE_PLAN_A=-1; VOICE_PLAN_B=-1; VOICE_PLAN_C=-1; end;
WHERE VOICE_PLAN IN ('A','B','C','D');
if DEVICE_PRIMARY = "BANANA" then do ; DEVICE_PRIMARY_BANANA=1; DEVICE_PRIMARY_BERRY=0; DEVICE_PRIMARY_KIWI=0; DEVICE_PRIMARY_MANGO=0;end;
ELSE if DEVICE_PRIMARY = "BERRY" then do ; DEVICE_PRIMARY_BANANA=0; DEVICE_PRIMARY_BERRY=1; DEVICE_PRIMARY_KIWI=0;DEVICE_PRIMARY_MANGO=0; end;
ELSE if DEVICE_PRIMARY = "KIWI" then do ; DEVICE_PRIMARY_BANANA=0; DEVICE_PRIMARY_BERRY=0; DEVICE_PRIMARY_KIWI=1;DEVICE_PRIMARY_MANGO=0; end;
ELSE if DEVICE_PRIMARY = "MANGO" then do ; DEVICE_PRIMARY_BANANA=0; DEVICE_PRIMARY_BERRY=0; DEVICE_PRIMARY_KIWI=0;DEVICE_PRIMARY_MANGO=1; end;
ELSE if DEVICE_PRIMARY = "ORANGE" then do ; DEVICE_PRIMARY_BANANA=-1; DEVICE_PRIMARY_BERRY=-1; DEVICE_PRIMARY_KIWI=-1;DEVICE_PRIMARY_MANGO=-1; end;
WHERE DEVICE_PRIMARY IN ('BANANA','BERRY','KIWI','MANGO','ORANGE');
RUN ;


/* Linear  Regression */
proc reg data=work.FINAL_DV ;
TITLE "QUESTION 6";
model DATA_PLAN_UPSELL_REVENUE =AGE INCOME DEVICES_NUM BASE_PLAN_RATE DATA_OVERAGE_MO DATA_PLAN_A 
DATA_PLAN_B DATA_PLAN_C DEVICE_PRIMARY_BANANA DEVICE_PRIMARY_BERRY DEVICE_PRIMARY_KIWI 
DEVICE_PRIMARY_MANGO VOICE_PLAN_A VOICE_PLAN_B VOICE_PLAN_C /VIF ;
WHERE MARKET= "N AMERICA" and DATA_PLAN_UPSELL_REVENUE > 0;
run ; quit ;

proc reg data=work.FINAL_DV outest=FINAL_COEFF ;
TITLE "QUESTION 6-with STEPWISE SELECTION";
model DATA_PLAN_UPSELL_REVENUE =AGE INCOME DEVICES_NUM BASE_PLAN_RATE DATA_OVERAGE_MO DATA_PLAN_A 
DATA_PLAN_B DATA_PLAN_C DEVICE_PRIMARY_BANANA DEVICE_PRIMARY_BERRY DEVICE_PRIMARY_KIWI 
DEVICE_PRIMARY_MANGO VOICE_PLAN_A VOICE_PLAN_B VOICE_PLAN_C / vif SELECTION=STEPWISE ALPHA=0.05;
WHERE MARKET= "N AMERICA" and DATA_PLAN_UPSELL_REVENUE > 0;
run ; quit ;

DATA  WORK.FINAL_PRESCORE;
SET WORK.FINAL_DV;
WHERE MARKET ^="N AMERICA";
RUN;

PROC CONTENTS DATA=WORK.FINAL_PRESCORE;
TITLE "QUESTION 7-FINAL_PRESCORE DATASET";
RUN;


PROC SCORE DATA=work.FINAL_PRESCORE score=work.FINAL_COEFF out=work.FINAL_SCORED type="PARMS" ;
var INCOME DEVICES_NUM BASE_PLAN_RATE DATA_OVERAGE_MO DATA_PLAN_A DEVICE_PRIMARY_BANANA DEVICE_PRIMARY_KIWI ;
run ;

PROC MEANS DATA=WORK.FINAL_SCORED MIN MAX MEAN STDDEV SKEW;
TITLE "QUESTION 8- SCORING";
VAR MODEL1;
RUN;



ods pdf close ;

