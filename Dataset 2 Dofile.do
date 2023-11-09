*A) import delimited rawdataset from SQL 
 *edited brfss21 data from cdc
	
 *clean the data
ssc install mdesc
ssc install missings
missings report

*B) 
drop if bmi5cat == 1
drop if bmi5cat == . 
	*save file
	
*generate outcome variable
gen N_OO = .
replace N_OO = 0 if bmi5cat == 2 
replace N_OO = 1 if bmi5cat == 3 | bmi5cat == 4

*created column that binarized bmi5cat  2 = 0 ; 3 & 4 = 1
* dropping all missings marked as 9 ,99, 999 or blank 

replace racegr3 = .  if racegr3 == 9 | racegr3 == .
replace raceg21 = . if raceg21 == 9 

replace incomg1 = . if incomg1 == 9 | incomg1 ==.
replace employ1 = .  if employ1 == 9 | employ1 == .

replace educag = . if educag == . | educag == 9

replace frtlt1a = . if frtlt1a == 9 | frtlt1a == .

replace veglt1a = . if veglt1a == 9 | veglt1a == .

replace alcday5 = . if alcday5 == . | alcday5 == 999 

replace rfsmok3 = . if rfsmok3 == 9 | rfsmok3 == .

replace casthm1 = . if casthm1 == 9 | casthm1 == .

replace totinda = .  if totinda == 9 | totinda == .

replace rfhype6 = . if rfhype6 == 9 | rfhype6 == .

replace diabete4 = . if diabete4 == 9 | diabete4 == .

replace genhlth = . if genhlth == 6 | genhlth == 7 | genhlth == 9
replace exerany2 = . if exerany2 == 9 | exerany2 == 7
replace diffwalk = . if diffwalk == 9 | diffwalk == 7 | diffwalk == .

*take descriptive stats
sum 

*three variables with most missings =  means were taken after 9's were replaced. 
	 bmi5cat |   3.008274 --> 3
     racegr3 |   1.245493 --> 1  
	 raceg21 |	 1.245493 --> 1  
     incomg1 |   4.336194 --> 4   
     employ1 |   3.747225 --> 4   
      educag |   3.034501 --> 3 
     frtlt1a |   1.383611 --> 1  
     veglt1a |   1.186234 --> 1  
    alcday5  |   523.99    = 1.521972 = 2
     rfsmok3 |   1.130116  = 1 .
     casthm1 |   1.098039  = 1 
     totinda |   1.244485   = 1 
     rfhype6 |   1.394095  = 1 
    diabete4 |   2.756694  = 3
	genhlth  |   2.51124   = 3
	diffwalk |   1.853335  = 2
	exerany2 |   1.252586  = 1
	 metstat |   1.304113  = 1
	 metro_b |    .6958871 = 1

*mean imputation
*For Datasest 2 Only
*replace bmi5cat = 3 if bmi5cat == . *for data PP4.1
replace racegr3 = 1  if racegr3 == .
replace incomg1 = 5 if incomg1 ==.
replace employ1 = 4  if employ1 == .
replace educag = 3 if educa == . 
replace frtlt1a = 1 if frtlt1a == .
replace veglt1a = 1 if veglt1a == .
replace alcday5 = 2 if alcday5 == .
replace rfsmok3 = 1 if  rfsmok3 == .
replace casthm1 = 1 if casthm1 == .
replace totinda = 1  if totinda == .
replace rfhype6 = 1 if rfhype6 == .
replace diabete4 = 3 if  diabete4 == .

replace raceg21 = 1 if raceg21 == .
replace genhlth = 3 if health_cat == .
replace exerany2 = 1 if exerany2 == .
replace diffwalk = 2 if diffwalk == . 
replace metstat = 1 if metstat ==.



*drop seqno
*drop age_cat
*continuous variable

*drop age_class
*only if mistakes were made 
*gen age_class = age_g == 4 | age_g == 5 | age_g == 6 

gen age_cat = .
replace age_cat = 1 if (age_g == 1 | age_g == 2) 
replace age_cat = 2 if (age_g == 3 | age_g == 4) 
replace age_cat = 3 if (age_g == 5 | age_g == 6) 

gen income_cat = .
replace income_cat = 1 if (incomg1 == 1 | incomg1 == 2 | incomg1 == 3 ) 
replace income_cat = 2 if (incomg1 == 3 | incomg1 == 4 | incomg1 == 5)
replace income_cat = 3 if incomg1 == 6 | incomg1 == 7

*discrete variables
gen race_cat = .
*unbinarized version, left as categorical "continuous variables"
replace race_cat = 1 if  racegr3 == 1  
replace race_cat = 2 if racegr3 == 2 
replace race_cat = 3 if racegr3 == 5 
replace race_cat = 4 if (racegr3 ==3 | racegr3 == 4 )

gen race_cat =.
replace race_cat = 0 if racegr3 == 1
replace race_cat = 1 if racegr3 == 2 | racegr3 == 3 | racegr3 == 4 | racegr3 == 5

gen health_cat =.
replace health_cat = 1 if genhlth == 1 | genhlth == 2
replace health_cat = 2 if genhlth == 3 
replace health_cat = 3 if genhlth == 4 | genhlth == 5


*binzarized version
gen sex_b = . 
replace sex_b = 0 if sex == 1 
replace sex_b = 1 if sex == 2

gen race_b = .
replace race_b = 0 if racegr3 == 1
replace race_b = 1 if racegr3 == 2 | racegr3 == 3 | racegr3 == 4 | racegr3 == 5

gen race2_b =.
replace race2_b = 1 if raceg21 == 1 
replace race2_b = 0 if raceg21 == 2 

gen employ_b = . 
replace employ_b = 0 if ( employ1 == 1 | employ1 == 2) 
replace employ_b = 1 if ( employ1 == 3 | employ1 == 4 | employ1 == 5 | employ1 == 6 | employ1 == 7 | employ1 == 8) 

gen edu_b= .
replace edu_b = 0 if (educag == 1 | educag == 2) 
replace edu_b = 1 if (educag == 3 | educag == 4)

gen metro_b =. 
replace metro_b = 1 if metstat == 1
replace metro_b = 0 if metstat == 2

*energy in variables
gen fruit_b = .
replace fruit_b = 1 if frtlt1a == 1
replace fruit_b = 0 if frtlt1a == 2

gen veg_b = .
replace veg_b = 1 if veglt1a == 1
replace veg_b = 0 if veglt1a == 2

*Energy out variable
gen PA_b = .
replace PA_b = 1 if totinda == 2
replace PA_b = 0 if totinda == 1

gen Exercise_b =. 

replace Exercise_b = 1 if exerany2 == 1 
replace Exercise_b = 0 if exerany2 == 2

*risk behaviors
gen alco_b = .
replace alcday5 = 523 if alcday5 ==. 
replace alco_b = 1 if (alcday5 <= 777 )
replace alco_b = 0 if alcday5 == 888


gen smo_b = . 
replace smo_b = 0 if rfsmok3 == 1
replace smo_b = 1 if rfsmok3 == 2

*chronic conditions

gen asthma_b =.
replace asthma_b = 0 if casthm1 == 1
replace asthma_b = 1 if casthm1 == 2

gen diab_b = .
replace diab_b = 1 if (diabete4 == 1 | diabete4 == 2)
replace diab_b = 0 if (diabete4 == 3 | diabete4 == 4 | diabete4 == 7)

gen HBP_b = .
replace HBP_b = 0 if rfhype6 == 1 
replace HBP_b = 1 if rfhype6 == 2

*Extra variables 
drop walk_b
gen walk_b =. 
replace walk_b = 1 if diffwalk == 1 
replace walk_b = 0 if diffwalk == 2

gen metro_b =.
replace metro_b = 1 if metstat == 1 
replace metro_b = 0 if metstat == 2

gen RiskBehavior = . 
replace RiskBehavior = 0 if alco_b == 0 | smo_b == 0 
replace RiskBehavior = 1 if alco_b == 1 | smo_b == 1

gen ChronicCond =.
replace ChronicCond = 0 if asthma_b == 0 | diab_b == 0 | HBP_b == 0 
replace ChronicCond = 1 if asthma_b == 1 | diab_b == 1 | HBP_b == 1

gen EnergyIn = .
replace EnergyIn = 0 if fruit_b == 0 | veg_b == 0 
replace EnergyIn = 1 if fruit_b == 1 | veg_b == 1 

gen EnergyOut = .
replace EnergyOut = 0 if PA_b == 0 | exerany2 == 0
replace EnergyOut = 1 if PA_b == 1 | exerany2 == 1

*TESTING 
tab N_OO sex
tabulate sex_b N_OO, chi row
tabulate HBP_b N_OO, chi row
tabulate diab_b N_OO, chi row
tabulate walk_b N_OO, chi row
tabulate health_cat N_OO, chi row
tabulate PA_b N_OO, chi row
*extra if you need to drop any variable. 
  
drop sex_b
drop race_b 
drop race2_b 
drop employ_b 
drop edu_b 
drop metro_b 
drop fruit_b
drop veg_b   
drop PA_b   
drop Exercise_b  
drop alco_b 
drop smo_b 
drop asthma_b 
drop diab_b 
drop HBP_b 
drop walk_b 
