# Predicting-Weight-Status

**Predicting Weight Status Using Risk Factors, Chronic Conditions, Energy Input and Output, and Sociodemographic Information**

**Introduction**

The primary emphasis of this study will be to find and analyze the best classification model to  predict an individual's weight status using attributes based on chronic conditions, risk factors, the individual's energy intake or output, and the individual's sociodemographic information. The primary dataset used to pull these variables is the 2021 Behavioral Risk Factor Surveillance System. Many of those who participated in this research endeavor are from the United States, where over half of the adult population is overweight or obese (Rosenthal Being et al. 2017). Throughout a person's lifetime, if they consume more calories than they burn off through physical activity, they are more likely to become overweight or obese. An energy imbalance occurs when the amount of energy you consume (in the form of calories) does not match the amount of energy you expend, leading your body to strive for equilibrium constantly. 

Obesity is the accumulation of abnormal or excessive fat in the body. Obesity is caused by an unhealthy amount of fat deposited in the body due to poor eating habits; consuming more calories than your body requires, eating excessive foods high in saturated fat, and eating meals high in sugar are all examples of unhealthy eating habits. Another element that may lead to poor eating behaviors are high stress levels which affect the brain and stimulates hormones that cause one to eat more. A lack of physical exercise, the environment, and social determinants of health are all variables that might contribute to bad eating habits. (Mozaffari, H., and B. Nabaei (2007) 

Being overweight or obese is regarded as one of the most severe threats to public health due to its link to major health risks associated with the majority of chronic diseases, including high blood pressure, heart disease, high cholesterol, stroke, diabetes, mental illness, cancer, and a variety of other diseases and conditions. As a result of these health risk factors, most obese people have a poor quality of life. It should come as no surprise that the risk of morbidity and mortality has grown among the population that is either overweight or obese. 

When determining a weight range, if a person's body mass index (BMI) is less than 18.5, they are considered to be underweight; however, if their BMI is between 18.5 and 24.9, they are considered healthy. Individuals with a BMI between 25.0 and 29.5 are considered overweight, while those with a BMI greater than 30.0 are considered obese. The Body Mass Index (BMI) is a metric used to determine whether or not a person is overweight. Our study references and utilizes a BMI variable in BRFSS that will be broken down into its parts to predict weight status of those aged 18 years and older.
 

Significance of this study 

To understand which combination of factors impacting weight status to help in creating a predictive model that can additionally strive to instill the importance of a healthy lifestyle to reduce diseases caused by obesity and increase the life span of individuals in the United States. 
 

**Methods**

To address our research question, we used a 2021 dataset from the Behavioral Risk Factor Surveillance System (BRFSS) provided through the Centers for Disease Control (CDC). Data was collected using landline telephone and consisted of telephone-based and self-reported surveys. Data was collected from all 50 states as well as the District of Columbia and participating US territories. Total observations were 438,693 adults aged 18 years and older. (CDC - 2021 BRFSS Survey Data and Documentation, 2022)
Initial variable selection occurred using two ways; researching literature to see which variables often come up in relation to understanding overweight and obesity in combination with factors we typically would associate with causing overweight or obesity. Such typical factors and literature pointed us towards using BMI, demographic variables, energy input and output, risky behaviors, and chronic conditions. Using BRFSS 2021 data provided us with variables including a body mass index (BMI) variable (underweight, normal, overweight, obese), age (18 – 65+), sex (Male, Female), race/ethnicity, income, employment, education (no-high school to graduated college), fruit intake and vegetable intake (individual variables asking for greater than or less than consumption of one per day), if there was physical activity level within past 30 days, if they drank alcohol, smoked, if they were told they had diabetes, high  	Figure 1. Overall methodology for predicting obesity.
blood pressure, and asthma (each their own variable).  Later in our experimentation, we additionally added variables that described health status (ranging excellent to poor), if they had difficulty walking, whether someone exercised or not, if they lived in a metropolitan area, and a binarized race variable (split between non-Hispanic White and non-White or Hispanic; used to replace initial race variable used) (see Appendix G).  These additional variables were chosen to see whether they would positively impact our modeling. Total of 20 variables were used throughout. To further assess significance of the top attributes, attribute selection through correlation evaluation using Ranker method provided top ranking attributes. Chi-square analysis of the top five attributes for both datasets were calculated based off Dataset 2 data. 


Preprocessing

The first steps in preprocessing included isolating the chosen variables in SQL, using Microsoft SQL Server Management Studio 18. Once the raw data file was created, it was uploaded to STATA Basic Edition version 17.0. The raw datafile included all variables mentioned previously with an initial observation count of 438,693. The BRFSS dataset includes variables in numeric and categorical form; for example, the age category was split between Male and Female, where Male = 1 and Female = 2. For other variables BRFSS coded missings as either an outlier value such as “9”, “99”, “999”, or left as blank. See Appendix G.  
Two separate datasets were created. The first dataset assessed descriptive statistics of the raw file and isolated the BMI variable. Secondly, was producing the outcome variable. To isolate normal, overweight, and obese weight individuals, BRFSS 21 coded a variable called BMI5CAT that split BMI into five categories of  1 – 5 in order of underweight (BMI < 18.5), normal weight (18.5 <= BMI < 25) , overweight ( 25 <= BMI < 30 BMI), obese (BMI > 30) and the fifth category as BLANK designated for those who did not know, refused, or information was missing (BLANK category was shown as an empty cell with no value). Values of 1 and BLANKS (underweight and missing) were deleted. After deletion, BMI5CAT was recategorized, binarized, and re-named to “n_oo” (normal_overweight/obese). All values of overweight and obese (value 3 and value 4) were grouped together. To binarize, where BMI5CAT = 2 (normal weight), was marked as 0; where BMI5CAT = 2 or 3 (overweight and obese), was marked as 1. Dataset was now made up of 385,554 observations, where Class 0 = 115,489 and Class 1 = 270,065 observations. Already, the dataset is skewed towards Class 1. 
Following deletion missing values were addressed, and this is where the datasets diverged. To address missings, mean imputation in Dataset 1 was done by taking the mean of all variables after the deletion of BMI values 1 and “blank”, and substituting each outlier and missing value with that variable’s respective mean. In Dataset 2, the mean of all variables was taken before deletion of BMI5CAT values 1, “blank”, and missings. This was done to see the difference in rank of attribute selection. Mean imputation was chosen to deal with missing values as it appears to be a common method used in data mining to mimic a complete dataset and help account for missing observations that would otherwise impact the dataset. From here, all variables were re-categorized into two categories, aside from age, race, and income, which we treated as continuous variables, see Appendix A. From there, each variable was binarized into 0 and 1 besides age, race, and income. Dataset 1 additionally included the grouping of variables; RiskBehavior = smoking and alcohol consumption, EnergyIn = fruit and vegetable Intake, EnergyOut = physical activity, ChronicChond = diabetes, asthma, highblood pressure. This concluded creation of Dataset 1. 
Dataset 2 included additional variables describing health status (ranging excellent to poor, also treated as a continuous variable), if they had difficulty walking, whether someone exercised or not, if they lived in a metropolitan area, and a binarized race variable (split between non-Hispanic White and non-White or Hispanic; used to replace initial race variable used). In Dataset 2, the grouping of variables into categories (riskbehavior, chroniccond, energyout and energyin) was done in STATA, however, did not make it to final dataset tested in Weka as when Dataset 1 was tested, it showed no visible difference. This was done by viewing attribute selection rank and going through various classifiers and noting that Precision, Recall, and ROC measures did not change drastically, concluding that the use of the grouped variables did not contribute to creating an effective model for prediction. 
Upon completion of the binarization of variables in STATA, additional statistical tests were conducted, Summary statistics and tabulation, pie and bar charts, Chi-square analysis of top-ranking attributes. See Table 3 and Appendix D.
The final step in preprocessing was uploading the dataset files into WEKA software version 3.8.6 and conducting attribute selection. For this, variables selected were changed from Numeric to Nominal, and Correlation Attribute Evaluation using Ranker method was conducted to assess the best attributes. Table 1 shows the differences in attributes selected between Datasets. For Dataset 1, the top 10 attributes were chosen, with the cutoff happening to be .025; variables for race, smoking habit, vegetable intake, and income were removed before running through classifiers for Dataset 1. For Dataset 2, the main purpose was to test different attributes against the outcome variable and additionally resample to find significant differences. Resampling was done at 50%, testing the attributes above .025 correlation.
Classifiers used included ones which are typically associated with classification models; Logistic Regression, Multiclass Classifier, Naïve Bayes, Random Forest, IBk Nearest Neighbors. We additionally tested out Logitboost and RandomTree. In Weka, tests were run at a 66% percentage split. 
 
 Table 1.  Ranked attributes using Correlation Attribute Evaluation in Weka using select variables show the top 5 attributes to consist of chronic conditions, Sex, Energy Output and Lifestyle factors of health status and ability to walk. 


**Results **
Initial testing of Dataset 1 with top 10 attributes used Naïve Bayes, Logistic, Multiclass, LogtiBoost classifiers. Of them, Random Tree produced the best ROC value (.671). Precision and Recall values varied with each Class, those that scored the highest are bolded in Table 2. Precision numbers for Class 0 were around .5, Class 1 were around .7; Recall numbers; Class 0 about .1 and Class 1 about .9. Overall, Precision and Recall was ok for the normal weight class (Class 0), but much closer to 1 for overweight and obese class (Class 1). 
For Dataset 2, Naïve Bayes, Logistic, Random Forest, and IBk (Nearest Neighbors) was used. Multiclass Classifier was not used throughout as it portrayed the exact results of Logistic. The initial Dataset 2 showed Logistic performed the best with ROC = .684. Precision and Recall numbers varied between Class but showed the best numbers between Naïve Bayes and Logistic, as seen bolded in Table 2.  
Testing the top 10 attributes within Dataset 2 showed best ROC using RandomForest and Nearest Neighbors classifiers (ROC = .680).  Among the 50% resampled data, which used the top 15 attributes after attribute selection methods, IBk (nearest neighbors) produced best ROC value (.679).
Testing with Datasets 1 and 2


	Dataset 1 	Dataset 2
	Classifier	Precision	Recall	ROC	Precision	Recall	ROC
Class 0	Naïve Bayes	0.497	0.193	0.661	0.476	0.382	0.663
Class 1	 	0.727	0.917	0.661	0.756	0.820	0.663
Class 0	Logistic 	0.523	0.116	0.667	0.545	0.143	0.684
	 	0.717	0.955	0.667	0.722	0.949	0.684
Class 0	Multiclass 	0.523	0.116	0.667	 		
	 	0.717	0.955	0.667	 		
Class 0	Logitboost	0.52	0.125	0.665	 		
	 	0.718	0.951	0.665	 		
Class 0	Random Tree	0.527	0.148	0.671	 		
		0.722	0.943	0.671	 		
Class 0	Random Forest				0.476	0.269	0.651
	 				0.737	0.873	0.651
Class 0	IBK				0.451	0.299	0.645
					0.738	0.845	0.645
Table 2. Testing classifiers against raw datasets after attribute selection in Dataset 1 and all attributes in Dataset 2 


Dataset 2 
	Top 10 attributes	Resampled at 50%
	Classifier	Precision	Recall	ROC	Precision	Recall	ROC
Class 0 	Naïve Bayes	0.489	0.35	0.662	0.471	0.4	0.661
Class 1	 	0.752	0.844	0.662	0.759	0.808	0.661
Class 0	Logistic 	0.545	0.15	0.675	0.552	0.151	0.674
	 	0.723	0.946	0.675	0.723	0.948	0.674
Class 0	Random Forest	0.552	0.146	0.680	0.512	0.239	0.672
	 	0.722	0.949	0.680	0.735	0.903	0.672
Class 0	IBk	0.547	0.143	0.679	0.547	0.153	0.679
	 	0.723	0.946	0.680	0.723	0.946	0.679
Table 2.1 Testing using various classifiers for Datasets 2 using top 10 attributes and 50% resampled data with attribute selection narrowing down to top 15 attributes (cutoff .025).

Further analysis of attributes consisted of conducting chi-square analysis of the top five ranking attributes in both datasets (See Table 3). The variable for Sex was one which stood out, holding a correlation value ranging from .9 to .1 based on dataset type (see Table 3). A tabulation and chi-square analysis in STATA, shown in Table 3 where Male = 0 and Female = 1, shows that while there is a higher percentage of females in the dataset, 74.5% are overweight or obese. Including, 80.3% of those High Blood Pressure, 85.3% of those with Diabetes, 80.3% of those who had difficulty walking, were also Overweight/Obese. Interestingly, those who rated themselves as having Excellent/Very Good health status (77.4%) and those who Answered Yes to engaging in Physical Activity (70%), were also Overweight/Obese. 

Table 3. Chi Square Analysis of top-ranking attributes using Dataset 2 data

**Analysis and Discussion**
Based on our results, if we were to solely compare ROC values, then Dataset 2 produced the highest at .684 using Logistic. Narrowing down attributes to the top 10 without resampling provided precision and recall numbers closest to 1, using Random Forest and IBk.  However, when assessing the overall values of each classifier per dataset, Naïve Bayes consistently showed values closest to 1 with the least difference between Class 0 and Class 1 (normal and Overweight/Obese) while using either dataset. Among the datasets, Dataset 2 provided higher numbers for all measures.  This may have occurred for a variety of reasons: 
1) Mean imputation methods may have addressed missings in a way that skewed the variables with the highest number of missings to rank higher or lower during attribute selection; this is more clearly seen with the Fruit and Vegetable intake rankings, See Table 1. In Dataset 2, Fruit Intake ranked lower, and Vegetable Intake ranked higher. 
2) Testing the top 10 attributes in Dataset 2 may have created a better model due to dropping low correlation ranking attributes; meaning using a higher cutoff value of .04 as opposed to .025 yielded better results, See Table 1.  
Our testing and analysis conclude that Naïve Bayes would be the ideal prediction model to predict weight status in adults aged 18 or older. 
For further discussion, a few interesting points found were in the attribute types and their rankings. The top five to ten attributes always consisted of chronic conditions, energy output attributes, and sex; high blood pressure, diabetes, difficulty walking, health status, sex, and physical activity. Chi-square analysis showed significant p-values (.000) in relation to the outcome variable, supplementing the rankings in attribute selection shown in Weka. However, it’s important to note that these very attributes have a dual relation with weight status. These attributes can not only potentially cause increased or decreased weight status but can also be caused by having a specific weight status. Given this dual relation between many of the top-ranking variables, it is difficult to say whether our prediction model adequately or accurately predicts weight status. This dual relation provides another justification towards the low numbers seen in recall and precision, leading to low ROC values overall in our testing. 
Instead of the way data is preprocessed, the variables themselves may be the core issue. Dataset 2 strived to use extra variables such as difficulty in walking, whether someone lived in a metropolitan area, perceived general health status, and whether someone exercised or not, to increase chances of creating a more well-rounded model. Though Dataset 2 performed slightly better, the results do not appear to be significantly different as ROC values stayed in the high .6 range. While Naïve Bayes is shown to have performed the best overall, the limitations of our methods and the attributes may not accurately predict weight status.  
In a broader sense, the vvariables High Blood Pressure, Diabetes, Sex, Physical Activity, Health Status and Fruit Intake showed to have the most impact (high correlation values) and are generally considered important factors associated with weight outcomes. Regarding missing data, from sociodemographic categories, Income had the most missing data in Dataset 1, and from the Energy intake/outtake category, fruit and vegetable consumption has more than 10% of missing data (taken from Dataset 1). So, this is not uncommon as prior studies have also shown similar missing data patterns; underreporting of daily energy intake happens to be more common in overweight or obese individuals than those of normal weight. The lack of physical activity is one of the major causes of obesity and related diseases. In type 2 diabetes, the inactivity of insulin leads to weight gain as the sugar accumulates in muscles and form saturated fats. In addition to this, research highlights that sedentary lifestyle also leads to high blood pressure and weight gain. Excess weight gain is the leading cause of hypertension even in young adults. Hypertension can also cause diabetes in case of obesity due to lack of physical activity. From this we can additionally conclude that many of the attributes are interrelated. 


**Limitations **
This prediction model has the following limitations:
•	BRFSS 2021 dataset was relatively large, although not significant, the mean imputation method to deal with missing data may have had an impact on how attributes were ranked.
•	Utilization of BRFSS21 dataset may not have been the optimal choice to predict weight status given the lack of variable available related to weight status. Instead using NHANES data could have potentially yielded the creation of better models.
•	BRFSS uses telephone and self-reported data, leading to bias in the responses; data/responses given may not accurately reflect the overall health of an individual thereby impacting accuracy of model. 
•	Method of analysis could have been further refined to test other classifiers; here the most common classifiers were used; datasets were not necessarily split between testing and training, merely the 66% percentage split in Weka. 
•	Method of preprocessing led to an imbalance in number of observations of those in the normal weight category (Class 0) and those in the Overweight and Obese Category (Class 1). This could have been a reason for results shown. 
•	Variables chosen in BRFSS21 were often attributes that could work both ways; ex. High blood pressure or diabetes can lead to overweight/obesity and overweight/obesity can cause high-blood pressure or diabetes. 
•	Time constraints of study and analysis, and limited understanding of STATA and WEKA may have led to novice preprocessing and modeling techniques. 

Provided these limitations, future analysis could look towards more intricate and thorough modeling and preprocessing design (imputation method, testing and training, classifiers used), and utilizing datasets which include a greater variety of attributes which may not necessarily work both ways as mentioned above. Future analysis can also include understanding whether demographic variables such as race and income hold higher correlations and predictive value to weight status than seen in this study. We believe that tailored interventions, policies and programs should target the differences rooted in different health risk factors and unhealthy behaviors to curb the increase in the prevalence of obesity and reduce disparities among these populations. 





**
REFERENCES **

Associations of Youth and Parent Weight Status with Reported versus Predicted Daily Energy 	Intake and Hemoglobin A1c in Youth with Type 1 Diabetes Mellitus—Amanda L. P. 	Sands, Laurie A. Higgins, Sanjeev N. Mehta, Tonja R. Nansel, Leah M. Lipsky, Lori M. 	B. Laffel, 2013. (n.d.). Retrieved November 29, 2022, from 	https://journals.sagepub.com/doi/10.1177/193229681300700131
CDC. (2022, September 27). New Adult Obesity Maps. Centers for Disease Control and   	Prevention. https://www.cdc.gov/obesity/data/prevalence-maps.html
CDC - 2021 BRFSS Survey Data and Documentation. (2022, October 27). 	https://www.cdc.gov/brfss/annual_data/annual_2021.html
Kohler, U. and Kreuter, F., 2005. Data analysis using Stata. Stata press. 

Leung, K.M., 2007. Naive bayesian classifier. Polytechnic University Department of Computer 	Science/Finance and Risk Engineering, 2007, pp.123-156. 

Mozaffari, H. and Nabaei, B., 2007. Obesity and related risk factors. The Indian Journal of 	Pediatrics, 74(3), pp.265-267. 

Otero, J. and Sánchez, L., 2006. Induction of descriptive fuzzy classifiers with the Logitboost 	algorithm. Soft Computing, 10(9), pp.825-835. 

Pal, M., 2005. Random forest classifier for remote sensing classification. International journal of 	remote sensing, 26(1), pp.217-222. 

Rosenthal, R.J., Morton, J., Brethauer, S., Mattar, S., De Maria, E., Benz, J.K., Titus, J. and 	Sterrett, D., 2017. Obesity in America. Surgery for Obesity and Related Diseases, 13(10), 	pp.1643-1650. 

Wright, R.E., 1995. Logistic regression. Garner, S.R., 1995, April. Weka: The Waikato 	environment for knowledge analysis. In Proceedings of the New Zealand computer 	science research students conference (Vol. 1995, pp. 57-64). 

