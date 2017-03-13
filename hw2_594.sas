title "&SYSUSERID. - HW2";
%let libpath=C:\Study_UIC\594\hw2;
libname HW2 "&libpath.";
%let pdfpath=C:\Users\adity\OneDrive\Documents\UIC\594\hw2;
ODS PDF FILE="&pdfpath.\HW2.pdf";


%let droprenamemv = (drop = CRSDepTime DepTime CRSArrTime ArrTime FirstDepTime WheelsOff WheelsOn Div1WheelsOn Div1WheelsOff Div2WheelsOn 
Div2WheelsOff Div3WheelsOn Div3WheelsOff Div4WheelsOn Div4WheelsOff Div5WheelsOn Div5WheelsOff 
rename =(CRSDepTimeF=CRSDepTime DepTimeF=DepTime CRSArrTimeF=CRSArrTime ArrTimeF=ArrTime FirstDepTimeF=FirstDepTime 
WheelsOffF=WheelsOff WheelsOnF=WheelsOn Div1WheelsOnF=Div1WheelsOn Div1WheelsOffF=Div1WheelsOff Div2WheelsOnF=Div2WheelsOn 
Div2WheelsOffF=Div2WheelsOff Div3WheelsOnF=Div3WheelsOn Div3WheelsOffF=Div3WheelsOff Div4WheelsOnF=Div4WheelsOn 
Div4WheelsOffF=Div4WheelsOff Div5WheelsOnF=Div5WheelsOn Div5WheelsOffF=Div5WheelsOff) ) ;

%let lengthmv = length Year 4. Quarter 4. Month 4. DayofMonth 4. DayOfWeek 4. FlightDate 8. UniqueCarrier $8. AirlineID  $4. 
Carrier  $4. TailNum  $10. FlightNum  $4. OriginAirportID  $8. OriginAirportSeqID  $8. OriginCityMarketID  $6. Origin  $32. 
OriginCityName  $32. OriginState  $32. OriginStateFips  $32. OriginStateName  $32. OriginWac  $32. DestAirportID  $6. 
DestAirportSeqID  $6. DestCityMarketID  $6. Dest  $32. DestCityName  $32. DestState  $32. DestStateFips  $32. 
DestStateName  $32. DestWac  $32. CRSDepTime  $8. CRSDepTimeF 8. DepTime  $8. DepTimeF  8. DepDelay 4. DepDelayMinutes 4. 
DepDel15 4. DepartureDelayGroups 4. DepTimeBlk  $9. TaxiOut 4. WheelsOff  $8. WheelsOffF  8. WheelsOn  $8. WheelsOnF  8. 
TaxiIn 4. CRSArrTime  $8. CRSArrTimeF  8. ArrTime  $8. ArrTimeF  8. ArrDelay 4. ArrDelayMinutes 4. ArrDel15 4. 
ArrivalDelayGroups  4. ArrTimeBlk  $9. Cancelled 4. CancellationCode  $8. Diverted  4. CRSElapsedTime 4. ActualElapsedTime 4. 
AirTime 4. Flights 4. Distance 4. DistanceGroup 4. CarrierDelay 4. WeatherDelay 4. NASDelay 4. SecurityDelay 4. LateAircraftDelay 4. 
FirstDepTime  $8. FirstDepTimeF  8. TotalAddGTime 4. LongestAddGTime 4. DivAirportLandings 4. DivReachedDest 4. DivActualElapsedTime 4. DivArrDelay 4. 
DivDistance 4. Div1Airport  $8. Div1AirportID  $8. Div1AirportSeqID  $8. Div1WheelsOn  $8. Div1WheelsOnF  8. Div1TotalGTime 4. Div1LongestGTime 4. 
Div1WheelsOff  $8. Div1WheelsOffF  8. Div1TailNum  $8. Div2Airport  $8. Div2AirportID  $8. Div2AirportSeqID  $8. Div2WheelsOn  $8. Div2WheelsOnF  8. Div2TotalGTime 4. 
Div2LongestGTime 4. Div2WheelsOff  $8. Div2WheelsOffF  8. Div2TailNum  $8. Div3Airport  $8. Div3AirportID  $8. Div3AirportSeqID  $8. Div3WheelsOn  $8. Div3WheelsOnF  8. 
Div3TotalGTime 4. Div3LongestGTime 4. Div3WheelsOff  $8. Div3WheelsOffF  8. Div3TailNum  $8. Div4Airport  $8. Div4AirportID  $8. Div4AirportSeqID  $8. 
Div4WheelsOn  $8. Div4WheelsOnF  8. Div4TotalGTime 4. Div4LongestGTime 4. Div4WheelsOff  $8. Div4WheelsOffF  8. Div4TailNum  $8. Div5Airport  $8. Div5AirportID  $8. 
Div5AirportSeqID  $8. Div5WheelsOn  $8. Div5WheelsOnF  8. Div5TotalGTime 4. Div5LongestGTime 4. Div5WheelsOff  $8. Div5WheelsOffF  8. Div5TailNum   $8.  ; 

%let inputmv = input Year Quarter Month DayofMonth DayOfWeek FlightDate :yymmdd10. UniqueCarrier $ AirlineID $ Carrier $ TailNum $ FlightNum $ 
OriginAirportID $ OriginAirportSeqID $ OriginCityMarketID $ Origin $ OriginCityName $ OriginState $ OriginStateFips $ 
OriginStateName $ OriginWac $ DestAirportID $ DestAirportSeqID $ DestCityMarketID $ Dest $ DestCityName $ DestState $ 
DestStateFips $ DestStateName $ DestWac $ CRSDepTime $ DepTime $ DepDelay DepDelayMinutes DepDel15 DepartureDelayGroups 
DepTimeBlk $ TaxiOut WheelsOff $ WheelsOn $ TaxiIn CRSArrTime $ ArrTime $ ArrDelay ArrDelayMinutes ArrDel15 ArrivalDelayGroups 
ArrTimeBlk $ Cancelled CancellationCode $ Diverted CRSElapsedTime ActualElapsedTime AirTime Flights Distance DistanceGroup 
CarrierDelay WeatherDelay NASDelay SecurityDelay LateAircraftDelay FirstDepTime $ TotalAddGTime LongestAddGTime 
DivAirportLandings DivReachedDest DivActualElapsedTime DivArrDelay DivDistance Div1Airport $ Div1AirportID $ Div1AirportSeqID $ 
Div1WheelsOn $ Div1TotalGTime Div1LongestGTime Div1WheelsOff $ Div1TailNum $ Div2Airport $ Div2AirportID $ Div2AirportSeqID $ 
Div2WheelsOn $ Div2TotalGTime Div2LongestGTime Div2WheelsOff $ Div2TailNum $ Div3Airport $ Div3AirportID $ Div3AirportSeqID $ 
Div3WheelsOn $ Div3TotalGTime Div3LongestGTime Div3WheelsOff $ Div3TailNum $ Div4Airport $ Div4AirportID $ Div4AirportSeqID $ 
Div4WheelsOn $ Div4TotalGTime Div4LongestGTime Div4WheelsOff $ Div4TailNum $ Div5Airport $ Div5AirportID $ Div5AirportSeqID $ 
Div5WheelsOn $ Div5TotalGTime Div5LongestGTime Div5WheelsOff $ Div5TailNum  $ ;

%macro timevars ;
if CRSDepTime="2400" then do ;
	CRSDepTimeF=input("23:59", time5.) ; end ;
		else do ;
			format CRSDepTimeF time5. ;
			CRSDepTimeF=input(substr(CRSDepTime,1,2)||":"||substr(CRSDepTime,3,2), time5.) ; end ;
if DepTime="2400" then do ;
	DepTimeF=input("23:59", time5.) ; end ;
		else do ;
			format DepTimeF time5. ;
			DepTimeF=input(substr(DepTime,1,2)||":"||substr(DepTime,3,2), time5.) ; end ;
if CRSArrTime="2400" then do ;
	CRSArrTimeF=input("23:59", time5.) ; end ;
		else do ;
			format CRSArrTimeF time5. ;
			CRSArrTimeF=input(substr(CRSArrTime,1,2)||":"||substr(CRSArrTime,3,2), time5.) ; end ;
if ArrTime="2400" then do ;
	ArrTimeF=input("23:59", time5.) ; end ;
		else do ;
			format ArrTimeF time5. ;
			ArrTimeF=input(substr(ArrTime,1,2)||":"||substr(ArrTime,3,2), time5.) ; end ;
if FirstDepTime="2400" then do ;
	FirstDepTimeF=input("23:59", time5.) ; end ;
		else do ;
			format FirstDepTimeF time5. ;
			FirstDepTimeF=input(substr(FirstDepTime,1,2)||":"||substr(FirstDepTime,3,2), time5.) ; end ;
if WheelsOff="2400" then do ;
	WheelsOffF=input("23:59", time5.) ; end ;
		else do ;
			format WheelsOffF time5. ;
			WheelsOffF=input(substr(WheelsOff,1,2)||":"||substr(WheelsOff,3,2), time5.) ; end ;
if WheelsOn="2400" then do ;
	WheelsOnF=input("23:59", time5.) ; end ;
		else do ;
			format WheelsOnF time5. ;
			WheelsOnF=input(substr(WheelsOn,1,2)||":"||substr(WheelsOn,3,2), time5.) ; end ;
if Div1WheelsOn="2400" then do ;
	Div1WheelsOnF=input("23:59", time5.) ; end ;
		else do ;
			format Div1WheelsOnF time5. ;
			Div1WheelsOnF=input(substr(Div1WheelsOn,1,2)||":"||substr(Div1WheelsOn,3,2), time5.) ; end ;
if Div1WheelsOff="2400" then do ;
	Div1WheelsOffF=input("23:59", time5.) ; end ;
		else do ;
			format Div1WheelsOffF time5. ;
			Div1WheelsOffF=input(substr(Div1WheelsOff,1,2)||":"||substr(Div1WheelsOff,3,2), time5.) ; end ;
if Div2WheelsOn="2400" then do ;
	Div2WheelsOnF=input("23:59", time5.) ; end ;
		else do ;
			format Div2WheelsOnF time5. ;
			Div2WheelsOnF=input(substr(Div2WheelsOn,1,2)||":"||substr(Div2WheelsOn,3,2), time5.) ; end ;
if Div2WheelsOff="2400" then do ;
	Div2WheelsOffF=input("23:59", time5.) ; end ;
		else do ;
			format Div2WheelsOffF time5. ;
			Div2WheelsOffF=input(substr(Div2WheelsOff,1,2)||":"||substr(Div2WheelsOff,3,2), time5.) ; end ;
if Div3WheelsOn="2400" then do ;
	Div3WheelsOnF=input("23:59", time5.) ; end ;
		else do ;
			format Div3WheelsOnF time5. ;
			Div3WheelsOnF=input(substr(Div3WheelsOn,1,2)||":"||substr(Div3WheelsOn,3,2), time5.) ; end ;
if Div3WheelsOff="2400" then do ;
	Div3WheelsOffF=input("23:59", time5.) ; end ;
		else do ;
			format Div3WheelsOffF time5. ;
			Div3WheelsOffF=input(substr(Div3WheelsOff,1,2)||":"||substr(Div3WheelsOff,3,2), time5.) ; end ;
if Div4WheelsOn="2400" then do ;
	Div4WheelsOnF=input("23:59", time5.) ; end ;
		else do ;
			format Div4WheelsOnF time5. ;
			Div4WheelsOnF=input(substr(Div4WheelsOn,1,2)||":"||substr(Div4WheelsOn,3,2), time5.) ; end ;
if Div4WheelsOff="2400" then do ;
	Div4WheelsOffF=input("23:59", time5.) ; end ;
		else do ;
			format Div4WheelsOffF time5. ;
			Div4WheelsOffF=input(substr(Div4WheelsOff,1,2)||":"||substr(Div4WheelsOff,3,2), time5.) ; end ;
if Div5WheelsOn="2400" then do ;
	Div5WheelsOnF=input("23:59", time5.) ; end ;
		else do ;
			format Div5WheelsOnF time5. ;
			Div5WheelsOnF=input(substr(Div5WheelsOn,1,2)||":"||substr(Div5WheelsOn,3,2), time5.) ; end ;
if Div5WheelsOff="2400" then do ;
	Div5WheelsOffF=input("23:59", time5.) ; end ;
		else do ;
			format Div5WheelsOffF time5. ;
			Div5WheelsOffF=input(substr(Div5WheelsOff,1,2)||":"||substr(Div5WheelsOff,3,2), time5.) ; end ;
%mend ;



/***************************************************************************************/
/**************** Reference Multiple Files in a SAS Dataset Manifest *******************/
/***************************************************************************************/
/***************************************************************************************/
data HW2.manifest ;
infile datalines firstobs=1 ;
length fil2read $70.;
input fil2read $70.;
datalines;
C:\Study_UIC\594\hw2\On_Time_On_Time_Performance_2015_3.csv
;


data HW2.BTS201503 &droprenamemv. ;
set HW2.manifest ;
infile dummy filevar=fil2read end=done dsd delimiter=',' firstobs=2 obs=max ;
	&lengthmv. ;
do while(not done);
	&inputmv. ;
	%timevars ;
output ;
end;
run ;


proc sort data=HW2.Bts201503;
by Carrier TailNum FlightDate CRSDepTime;
run ;


data HW2.BTS201503_Lag ;
retain DepDelayLag 0 DepDelayLagCum 0 ArrDelayLag 0 ArrDelayLagCum 0  CancelledLag1 0 ;
format flightdate yymmdd10. SeqNum1 DepDelayLagInd DepDelayLag DepDelayLagCum ArrDelayLagInd ArrDelayLag ArrDelayLagCum 4. ;
set HW2.Bts201503 ;
by Carrier TailNum FlightDate ;
if first.FlightDate=1 then do ;
	DepDelayLag=0 ;
	DepDelayLagInd=0 ;
	DepDelayLagCum=0 ;
	ArrDelayLag=0 ;
	ArrDelayLagInd=0 ;
	ArrDelayLagCum=0 ;
	CancelledLag1=0 ;
	SeqNum1=1 ;
end ;
else do ;
	SeqNum1+1 ;
	DepDelayLagInd=(DepDelayLag>0) ;
	DepDelayLagCum+DepDelayLag ;
	ArrDelayLagInd=(ArrDelayLag>0) ;
	ArrDelayLagCum+ArrDelayLag ;
	
end ;
output ;
DepDelayLag=DepDelay ;
ArrDelayLag=ArrDelay ;
CancelledLag1=Cancelled ;
run ;


proc stdize data=HW2.BTS201503_Lag reponly missing=0 out=HW2.BTS201503REP ;
var DepDelayLag ArrDelayLag;
run ;

data HW2.BTS201503;
set HW2.BTS201503REP;
if DepartureDelayGroups < = 0 then DepDelayClass=0;
else if DepartureDelayGroups IN (1,2,3) then DepDelayClass=1;
else if DepartureDelayGroups > 3 then DepDelayClass=2;
run;

proc sort data=HW2.BTS201503;
by Carrier TailNum FlightDate CRSDepTime ;
run;

data HW2.BTS201503_temp(drop=SeqNum SeqNum1);
set HW2.BTS201503;
run;


data HW2.BTS201503_Lag2;
retain  DepDelayLag2 0 ArrDelayLag2 0  ;
format flightdate yymmdd10. SeqNum DepDelayLag2 ArrDelayLag2 4. ;
set HW2.BTS201503_temp ;
by Carrier TailNum FlightDate ;
if first.FlightDate=1 then do ;
	DepDelayLag2=0 ;
	ArrDelayLag2=0 ;
	SeqNum=1 ;
end ;
else do ;
	SeqNum+1 ;
	if SeqNum eq 2 then do ;
		DepDelayLag2=0;
		ArrDelayLag2=0;
	end;		
end ;
output ;
DepDelayLag2=DepDelayLag ;
ArrDelayLag2=ArrDelayLag ;
run ;

proc logistic data=HW2.BTS201503_Lag2 ;
class DepDelayClass (param=ref ref='0');
model DepDelayClass = CRSDepTime SeqNum ArrDelayLagInd ArrDelayLag ArrDelayLagCum DepDelayLag2 ArrDelayLag2 CancelledLag1 ;
where Cancelled=0;
run;

filename in2015we 'C:\Study_UIC\594\hw2\Weather_ord_2015_miss.txt';

data HW2.Weather_ord_2015_miss;
infile in2015we firstobs=2 dlm='|' missover dsd ;
format FLIGHTDATE yymmdd10.;
length STATION_NAME $41. ;
input FLIGHTDATE :yymmdd10. STATION_NAME $ PRCP SNWD SNOW TMAX TMIN;
run;

proc sort data=HW2.BTS201503_Lag2 out=HW2.BTS201503_Sorted ;
by flightdate;
run;

proc sort data=HW2.Weather_ord_2015_miss out=HW2.Weather_ord_2015_miss_sorted ;
by flightdate;
run;

data HW2.BTS201503WTHR;
merge HW2.BTS201503_Sorted HW2.Weather_ord_2015_miss_sorted;
by FLIGHTDATE;
if origin='ORD';
run ;

proc sort data=HW2.BTS201503WTHR;
by flightdate;
run;

proc mi data=HW2.BTS201503WTHR nimpute=12 out=HW2.BTS201503WTHRIMP ;
* by monthnum ;
* class <variables> ;
FCS ; *nbiter=1 ; *[Imputation method];
var snow tmin tmax ;
run ;

proc sort data=HW2.BTS201503WTHRIMP;
by _imputation_;
run;

proc reg data=HW2.BTS201503WTHRIMP outest=HW2.BTS201503WTHRIMP_EST covout;
model DepDelayClass = CRSDepTime SeqNum ArrDelayLagInd ArrDelayLag ArrDelayLagCum DepDelayLag2 ArrDelayLag2 CancelledLag1 tmin tmax snow;
where Cancelled=0 and origin='ORD';
by  _imputation_ ;
run;
quit;

proc mianalyze data=HW2.BTS201503WTHRIMP_EST;
modeleffects tmin tmax snow;
run ;



ODS PDF CLOSE;
