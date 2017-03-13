libname Proj_462 'C:\Study_UIC\IDS 462\DataSets\Proj_Data' ;

proc import datafile="C:\Study_UIC\IDS 462\Project\Crimes_- OCT-oct2016.csv" 
dbms=csv  out=Proj_462.Project_data REPLACE ;
	 run;

data PROJ_462.PROJECT_DATA    ;
      %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
      infile 'C:\Study_UIC\IDS 462\Project\Crimes_- OCT-oct2016.csv' delimiter = ',' MISSOVER DSD lrecl=13106 firstobs=2 ;
         informat ID best32. ;
         informat Case_Number $8. ;
         informat Date anydtdtm40. ;
         informat Block $21. ;
         informat IUCR $10. ;
         informat Primary_Type $20. ;
         informat Description $35. ;
         informat Location_Description $31. ;
         informat Arrest $5. ;
         informat Domestic $5. ;
         informat Beat best32. ;
         informat District best32. ;
         informat Ward best32. ;
         informat Community_Area best32. ;
         informat FBI_Code $3. ;
         informat X_Coordinate best32. ;
         informat Y_Coordinate best32. ;
         informat Year best32. ;
         informat Updated_On anydtdtm40. ;
         informat Latitude best32. ;
         informat Longitude best32. ;
         informat Location $31. ;
         format ID best12. ;
         format Case_Number $8. ;
         format Date datetime. ;
         format Block $21. ;
         format IUCR $10. ;
         format Primary_Type $20. ;
         format Description $35. ;
         format Location_Description $31. ;
         format Arrest $5. ;
         format Domestic $5. ;
         format Beat best12. ;
         format District best12. ;
         format Ward best12. ;
         format Community_Area best12. ;
         format FBI_Code $3. ;
         format X_Coordinate best12. ;
         format Y_Coordinate best12. ;
         format Year best12. ;
         format Updated_On datetime. ;
         format Latitude best12. ;
         format Longitude best12. ;
         format Location $31. ;
      input
                  ID
                  Case_Number $
                  Date
                  Block $
                  IUCR $
                  Primary_Type $
                  Description $
                  Location_Description $
                  Arrest $
                  Domestic $
                  Beat
                  District
                  Ward
                  Community_Area
                  FBI_Code $
                  X_Coordinate
                  Y_Coordinate
                  Year
                  Updated_On
                  Latitude
                  Longitude
                  Location $
      ;
      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
      run;

	 proc contents data=Proj_462.Project_data;
	 run;

	 proc means data = Proj_462.Project_data n nmiss;
	run;

	data Proj_462.Project_data_1 (drop=Updated_On Year X_Coordinate Y_Coordinate Location Case Number);
	set Proj_462.Project_data;
	run;

	proc delete data=Proj_462.Project_data (gennum=all);
	run;

	proc contents data=Proj_462.Project_data_1;
	 run;

	 proc means data = Proj_462.Project_data_1 n nmiss;
	run;

	proc freq data=Proj_462.Project_data_1;
	tables Arrest Domestic;
	run;

	data Proj_462.Project_data(drop= Arrest Domestic);
	set Proj_462.Project_data_1;
	if Arrest = 'true' then Arrest_B = 1;
	else Arrest_B = 0;
	if  Domestic = 'true' then Domestic_B = 1;
	else Domestic_B = 0;
	run;

	proc delete data=Proj_462.Project_data_1 (gennum=all);
	run;

	proc contents data=Proj_462.Project_data;
	run;

	proc means data = Proj_462.Project_data n nmiss;
	run;
	
	data Proj_462.Project_data_1;
	set Proj_462.Project_data;
	Hour= Hour(Date);
	Crime_Date=DATEPART(date);
	run;

	data Proj_462.Project_data(drop=Latitude Longitude);
	set Proj_462.Project_data_1;
	Weekday=WEEKDAY(Crime_Date);
	Day_of_Month=Day(Crime_Date);
	Month=Month(Crime_Date);
	run;

	proc delete data=Proj_462.Project_data_1 (gennum=all);
	run;

	proc means data=Proj_462.Project_data ;
	run;

	proc freq data=Proj_462.Project_data;
	tables Primary_Type / plots= (freqplot (scale=percent)) ;
	title   "Most prevalent types of Crime";
	run;

		proc freq data=Proj_462.Project_data;
		where Arrest_B=1;
	tables Primary_Type / plots= (freqplot (scale=percent)) ;
	title   "Most prevalent types of Crime leading to An Arrest";
	run;

	proc freq data=Proj_462.Project_data;
	tables Month / out=Proj_462.Month_fre;
	title  "Crime Rate by Month";
	run;
	proc freq  data=Proj_462.Project_data;
	where Arrest_B=1;
tables Month /out=Proj_462.Arrest_By_Month ;
title  "Arrests made by Month";
run;

symbol1 color=black interpol=join value=dot height=2;
proc gplot data=Proj_462.Month_fre ;
title  "Crime Rate by Month";
   plot count*month / haxis=1 to 12 by 1
                    hminor=3
                    vminor=1
                    vref=1000
                    lvref=2;
run;

symbol1 color=blue interpol=join value=dot height=2;
proc gplot data=Proj_462.Arrest_By_Month ;
title  "Arrests made by Month";
   plot count*month / haxis=1 to 12 by 1
                    hminor=3
                    vminor=1
                    vref=1000
                    lvref=2;
run;


proc freq  data=Proj_462.Project_data;
tables Day_of_Month / chisq plots=(deviationplot (type=dotplot ));
title  "Crime by Day of the Month";
run;


proc freq  data=Proj_462.Project_data;
where Arrest_B=1;
tables Day_of_Month / chisq plots=(deviationplot (type=dotplot ));
title  "Arrests made by Day of the Month";
run;

proc freq  data=Proj_462.Project_data;
tables Weekday / chisq plots=(deviationplot (type=dotplot ));
title  "Crime by Weekday";
run;


proc freq  data=Proj_462.Project_data;
where Arrest_B=1;
tables Weekday / chisq plots=(deviationplot (type=dotplot ));
title  "Arrests made by Weekday";
run;


proc freq  data=Proj_462.Project_data;
tables Hour / chisq plots=(deviationplot (type=dotplot ));
title  "Crime by Time of Day";
run;


proc freq  data=Proj_462.Project_data;
where Arrest_B=1;
tables Hour / chisq plots=(deviationplot (type=dotplot ));
title  "Arrests made by Time of Day";
run;


proc freq data=Proj_462.Project_data;
	tables Month*Weekday / chisq plots=(freqplot(twoway=stacked
 scale=freq));
 title  "Chi-Square Test for Association of Crime Rate Across Months for Different Weekdays";
	run;


proc freq data=Proj_462.Project_data;
	tables Month*Weekday*Hour/ chisq out=Proj_462.Threeway_ProcFreq plots=(freqplot(twoway=groupvertical
 scale=freq));
title  "Chi-Square Test for Crime Rate for Time of Day across Weekdays Stratified for Months";
	run;

 

	proc anova data=Proj_462.Threeway_ProcFreq;
	title "Anova Multiple Comparison Test for Frequency of Crime based on Time of Day";
	class  Hour ;
	model PERCENT= Hour;
	means Hour / tukey;
run;



proc anova data=Proj_462.Threeway_ProcFreq;
	class Month Hour Weekday;
	model PERCENT= Month;
	means Month / snk;
run;


proc freq data=proj_462.project_data ;
tables Community_Area /  out=Proj_462.Community_freq_DT;
title "Community Area";
run;

proc sort data=Proj_462.Community_freq_DT;
by descending count;
run;

data proj_462.Top_Crime_Community;
set proj_462.Community_freq_DT(obs=15);
run;


proc gchart data = Proj_462.Top_Crime_Community;
title1 'Top 15 Dangerous Communities';
vbar Community_Area / sumvar=count discrete  width = 8 ;
run;

proc freq data=proj_462.project_data ;
tables Primary_Type*Community_Area / chisq  out=Proj_462.Community_crime_freq;
title "Comparison of Crime Type & Community Area";
run;	

proc sort data=proj_462.Community_crime_freq;
by descending count;
run;

data proj_462.Community;
set proj_462.Community_crime_freq(obs=10);
run;



proc gchart data=proj_462.Community;
vbar Community_Area /sumvar=count discrete group=Primary_Type;
title "Most Dangerous Communities and Prevalent Crime";
run;

	proc freq data=Proj_462.Project_data;
	tables Primary_Type * Description /  out=Proj_462.Crime_type_freq;
	title "Crime Sub Types";
	run;

	proc sort data=proj_462.Crime_type_freq;
by descending count;
run;

data proj_462.Crime;
set proj_462.Crime_type_freq(obs=5);
run;


	proc freq data=Proj_462.Project_data;
	where Arrest_B=1;
	tables Primary_Type * Description /  out=Proj_462.Description_type_top5;
	title "Crime Sub Types for arrests";
	run;

	proc sort data=proj_462.Description_type_top5;
by descending count;
run;

data proj_462.Top_5;
set proj_462.Description_type_top5(obs=5);
run;


goptions reset=all cback=white border htitle=12pt;  

title1 "Pie charts of Top Crime Types Leading to An Arrest";
 
 /* Create the graph using the RADIUS option */
 /* on the PIE statement.                    */
proc gchart data=proj_462.Top_5;
   pie Primary_Type / detail=description
              detail_slice=best
              detail_threshold=0.5
              legend 
              radius=35
   ;
run;
quit;
/*proc gchart data=proj_462.Crime;
pie Description Primary_Type / sumvar=percent noheading slice=inside value=inside;
title "Pie charts of Top Crime Types";
run;
*/	
 /* Set the graphics environment */
goptions reset=all cback=white border htitle=12pt;  

title1 "Pie charts of Top Crime Types";
 
 /* Create the graph using the RADIUS option */
 /* on the PIE statement.                    */
proc gchart data=proj_462.Crime;
   pie Primary_Type / detail=description
              detail_slice=best
              detail_threshold=0.5
              legend 
              radius=35
   ;
run;
quit; 


	proc contents data=Proj_462.Crime_type_freq;
	run;

	proc sort data=Proj_462.Crime_type_freq;
	by descending Count ;
	run;

proc gchart data=Proj_462.Crime_type_freq;
	pie Description / sumvar=percent noheading slice=inside value=inside group=Primary_type across=3;
title "Pie charts of Crime Types";
run;

	
	proc freq data=Proj_462.Project_data;
	tables Location_Description /out=Proj_462.Location;
	title "Location wise Study of Crime";
run;

	proc gchart data=Proj_462.Location;
	pie Location_Description / sumvar=percent noheading slice=inside value=inside;
	title "Crime Rate by Location";
run;


	proc freq data=Proj_462.Project_data;
	where Domestic_B =1;
	tables Primary_type*Description /out=Proj_462.Domestic_Primary;
	title "Domestic Crimes";
run;

proc sort data=proj_462.Domestic_Primary;
by descending count;
run;

data proj_462.Domestic_1;
set proj_462.Domestic_Primary(obs=5);
run;

goptions reset=all cback=white border htitle=12pt;  

title1 "Top Domestic Crime Types";
 
 /* Create the graph using the RADIUS option */
 /* on the PIE statement.                    */
proc gchart data=proj_462.Domestic_1;
   pie Primary_Type / detail=description
              detail_slice=best
              detail_threshold=0.5
              legend 
              radius=35
   ;
run;
quit; 

	

	proc freq data=Proj_462.Project_data;
	where Domestic_B =1;
	tables Weekday /plots= (freqplot (scale=percent)) ;
	title "Domestic Crime by Weekday";
run;

proc freq data=Proj_462.Project_data;
	where Domestic_B =1;
	tables Weekday*Hour /out=Proj_462.Domestic_Weekday_hour;
	title "Domestic Crimes Weekday/Hour";
run;


proc sort data=proj_462.Domestic_Weekday_hour;
by descending count;
run;

data proj_462.Domestic_Weekday;
set proj_462.Domestic_Weekday_hour(obs=5);
run;

goptions reset=all cback=white border htitle=12pt;  

title1 "Top Domestic Crime Types By Day of Week and Time of Day";
 
 /* Create the graph using the RADIUS option */
 /* on the PIE statement.                    */
proc gchart data=proj_462.Domestic_Weekday;
   pie Weekday / detail=hour
              detail_slice=best
              detail_threshold=0.5
              legend 
              radius=35
   ;
run;
quit;

	proc logistic data=Proj_462.Project_data descending;
	class Hour Weekday Month / PARAM=REFERENCE REF=FIRST;
	model Arrest_B = Hour Weekday Month /  SELECTION=STEPWISE ;
	run;





   proc export data=Proj_462.Project_data
    outfile='C:\Study_UIC\IDS 462\Project\Crimes_Final.csv'
    dbms=csv
    replace;
run;



