*A) import csv sql file 

*NOTE this dofile was primarily used to create Dataset 1 but later was also used to test initially mean imputation method with extra Dataset 2 variables. Dataset 2 variables are noted throughout. 
	
 *clean the data and evaluate missings along the way
ssc install mdesc
ssc install missings
missings report

*B) 
drop if bmi5cat == 1
*C)	
drop if bmi5cat == . 
	*save file before and after BMI deletion 
	
gen N_OO = .
replace N_OO = 0 if bmi5cat == 2 
replace N_OO = 1 if bmi5cat == 3 | bmi5cat == 4

*created column that binarized bmi5cat  2 = 0 ; 3 & 4 = 1
*do descriptive stats
*summarize 
*mlogit N_OO sex age_g racegr3 incomg1 employ1 _educag frtlt1a veglt1a alcday5 rfsmok3 casthm1 totinda rfhype6 diabete4 genhlth diffwalk exerany2 metstat raceg21

*continous variables

*gen age_class = age_g == 4 | age_g == 5 | age_g == 6 

gen age_cat = .
replace age_cat = 1 if (age_g == 1 | age_g == 2) 
replace age_cat = 2 if (age_g == 3 | age_g == 4) 
replace age_cat = 3 if (age_g == 5 | age_g == 6) 

gen income_cat = .
replace income_cat = 1 if (incomg1 == 1 | incomg1 == 2 | incomg1 == 3 ) 
replace income_cat = 2 if (incomg1 == 3 | incomg1 == 4 | incomg1 == 5)
replace income_cat = 3 if incomg1 == 6 | incomg1 == 7

gen race_cat = .
*unbinarized version
replace race_cat = 1 if  racegr3 == 1  
replace race_cat = 2 if racegr3 == 2 
replace race_cat = 3 if racegr3 == 5 
replace race_cat = 4 if (racegr3 ==3 | racegr3 == 4 )

*binzarized version
replace race_cat = 0 if racegr3 == 1
replace race_cat = 1 if racegr3 == 2 | racegr3 == 3 | racegr3 == 4 | racegr3 == 5

* healthcat For Dataset2 only
gen health_cat =.
replace health_cat = 1 if genhlth == 1 | genhlth == 2
replace health_cat = 2 if genhlth == 3 
replace health_cat = 3 if genhlth == 4 | genhlth == 5


gen employ_cat = . 
replace employ_cat = 0 if ( employ1 == 1 | employ1 == 2) 
replace employ_cat = 1 if ( employ1 == 3 | employ1 == 4 | employ1 == 5 | employ1 == 6 | employ1 == 7 | employ1 == 8) 

gen edu_cat= .
replace edu_cat = 0 if (educag == 1 | educag == 2) 
replace edu_cat = 1 if (educag == 3 | educag == 4)

gen fruit_cat = .
replace fruit_cat = 0 if frtlt1a == 1
replace fruit_cat = 2 if frtlt1a == 2

gen veg_cat = .
replace veg_cat = 1 if veglt1a == 1
replace veg_cat = 2 if veglt1a == 2

gen PA_cat = .
replace PA_cat = 1 if totinda == 2
replace PA_cat = 2 if totinda == 1

gen HBP_cat = .
replace HBP_cat = 1 if rfhype6 == 1 
replace HBP_cat = 2 if rfhype6 == 2


gen alco_cat = .
replace alco_cat = 2 if (alcday5 <= 777 )
replace alco_cat = 1 if alcday5 == 888

gen smo_cat = . 
replace smo_cat = 1 if rfsmok3 == 1
replace smo_cat = 2 if rfsmok3 == 2

gen diab_cat = .
replace diab_cat = 2 if (diabete4 == 1 | diabete4 == 2)
replace diab_cat = 1 if (diabete4 == 3 | diabete4 == 4 | diabete4 == 7)

gen asthma_cat =.
replace asthma_cat = 1 if casthm1 == 1
replace asthma_cat = 2 if casthm1 == 2


*binzarized version
gen sex_b = . 
replace sex_b = 0 if sex == 1 
replace sex_b = 1 if sex == 2

gen race_b = .
replace race_b = 0 if racegr3 == 1
replace race_b = 1 if racegr3 == 2 | racegr3 == 3 | racegr3 == 4 | racegr3 == 5

gen employ_b = . 
replace employ_b = 0 if ( employ1 == 1 | employ1 == 2) 
replace employ_b = 1 if ( employ1 == 3 | employ1 == 4 | employ1 == 5 | employ1 == 6 | employ1 == 7 | employ1 == 8) 

gen edu_b= .
replace edu_b = 0 if (educag == 1 | educag == 2) 
replace edu_b = 1 if (educag == 3 | educag == 4)

*For Dataset 2 only
gen metro_b =. 
replace metro_b = 1 if metstat == 1
replace metro_b = 0 if metstat == 2

gen walk_b =. 
replace walk_b = 1 if diffwalk == 1 
replace walk_b = 0 if diffwalk == 2


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

*For Dataset 2 only
gen Exercise_b =. 
replace Exercise_b = 1 if exerany2 == 1 
replace Exercise_b = 0 if exerany2 == 2

*risk behaviors
gen alco_b = .
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

*other for Dataset 2 only
gen health_b =.
replace health_b = 1 if genhlth == 1 | genhlth == 2
replace health_b = 2 if genhlth == 3 
replace health_b = 3 if genhlth == 4 | genhlth == 5


*grouping variables between risk factors, energy in and out, chronic conditions


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
replace EnergyOut = 0 if PA_b == 0 | Exercise_b == 0
replace EnergyOut = 1 if PA_b == 1 | Exercise_b == 1

gen LifeStyle = .
replace LifeStyle = 0 if genhlth == 3 | genhlth == 2 | metro_b == 0 | walk_b == 0
replace LifeStyle = 1 if genhlth == 1 | metro_b == 1 | walk_b == 1

*three variables with most missings in Dataset 1 = income, vegetable, fruit intake
     racegr3 |   1.735145 --> 2  
     incomg1 |   5.151865 --> 5   
     employ1 |   3.788296 --> 4   
      educag |   3.063285 --> 3 
     frtlt1a |   1.821053  --> 2  
     veglt1a |   1.794338  -->2  
     alcday5 |   516.7012  --1.53 --> 2 
     rfsmok3 |   1.183955  = 1 .
     casthm1 |   1.156428  = 1 
     totinda |   1.251596  = 1 
     rfhype6 |   1.424751  = 1 
    diabete4 |   2.753343  = 3

*mean imputation
replace racegr3 = 2  if racegr3 == 9 | racegr3 == .
replace incomg1 = 5 if incomg1 == 9 | incomg1 ==.
replace employ1 = 4  if employ1 == 9 | employ1 == .
replace educag = 3 if educa == . | educa == 9
replace frtlt1a = 2 if frtlt1a == 9 | frtlt1a == .
replace veglt1a = 2 if veglt1a == 9 | veglt1a == .
replace alcday5 = 2 if alcday5 == . | alcday5 == 999 
replace rfsmok3 = 1 if rfsmok3 == 9 | rfsmok3 == .
replace casthm1 = 1 if casthm1 == 9 | casthm1 == .
replace totinda = 1  if totinda == 9 | totinda == .
replace rfhype6 = 1 if rfhype6 == 9 | rfhype6 == .
replace diabete4 = 3 if diabete4 == 9 | diabete4 == .

*For Dataset 2 only

*Means 
	 genhlth |   2.517024  = 3
	diffwalk |   1.857416  = 2
	exerany2 |   1.249348  = 1
   	 metstat |   1.308169  = 1
	
replace genhlth = 3 if genhlth == 6 | genhlth == 7 | genhlth == 9 | genhlth == .
replace diffwalk = 2 if diffwalk == 7| diffwalk == 9 | diffwalk == .
replace exerany2 = 1 if exerany2 == 7| exerany2 == 9 | exerany2 == .
replace metstat = 1 if metstat == . 


*Statistical testing
sum 
tab
pwcorr 

