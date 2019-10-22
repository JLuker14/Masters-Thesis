** MSc Dissertation Do-File 1406884 JRML Cardiff University ** 


*
**
****
******
*********
************
**************
****************
*******************
*************************
******************************************************************************************************************
** EVS 2017-19 ** 

* CHECKLIST: 

* DV 

v153 = homosexuality being justified 

* IV's 

v6 = religious importance *
v51 = belong to a religious denomination (yes/no) *
v52 = religious denomination *
v54 = attend religious services*
v102 = political view * 
v225 = sex *
age_r3 = age recoded * 
v234 = current legal marital status *
country = country 
v63 = God importance *
v243_r = educational level * 
v145 = strong leader *

* RECODING VARIABLES *

** DV ** 

recode v153 (-9/-1=.) (10=1 "always justified") (9=2 "2") (8=3 "3") (7=4 "4") (6=5 "5") (5=6 "6") (4=7 "7") (3=8 "8") (2=9 "9") (1=10 "never justified") (.=.), gen(homosexuality) 

recode homosexuality (10=1 "never justified") (2/9=.) (1=0 "always justified") (.=.), gen(homosexuality1) 

DEPENDENT VARIABLE: homosexuality 

** IV's (individual level L1) ** 

recode v225 (-6/-1=.) (1=1 "male") (2=0 "female") (.=.), gen(sex) 

recode v6 (-10/-1=.) (1=4 "very important") (2=3 "quite important") (3=2 "not important") (4=1 "not at all important"), gen(religionimportance) 

recode v51 (-2/-1=.) (1=1 "yes") (2=0 "no") (.=.), gen(religionbelonging) 

recode v52 (-10=.) (-3=1 "not applicable/do not belong to religious denomination") (-2/-1=.) (1=2 "Roman Catholic") (2=3 "Protestant") (3=4 "Free church/Non-conformist/Evangelical") (4=7 "Other") (5=5 "Muslim") (6=7) (7=7) (8=6 "Orthodox") (9=.) (.=.), gen(religiousdenomination)

recode v54 (-10/-1=.) (1=7 "more than once a week") (2=6 "once a week") (3=5 "once a month") (4=4 "only on specific holy days") (5=3 "once a year") (6=2 "less often") (7=1 "never, practically never") (.=.), gen(religiousservice) 

recode v102 (-10/-1=.) (1=1 "the left") (10=10 "the right") (.=.), gen(politicalview)

recode age_r3 (-6/-1=.) (1=1 "18-24 years") (2=2 "25-34 years") (3=3 "35-44 years") (4=4 "45-54 years") (5=5 "55-64 years") (6=6 "65-74 years") (7=7 "75 and more years") (.=.), gen(agecat)

recode v234 (-10/-1=.) (1=6 "married") (2=5 "registered partnership") (3=4 "widowed") (4=3 "divorced") (5=2 "separated") (6=1 "never married and never registered partnership") (.=.), gen(maritalstatus)

recode v63 (-10/-1=.) (1=1 "not at all important") (10=10 "very important") (.=.), gen(Godimportance)

recode v243_r (-6/-1=.) (1=1 "lower") (2=2 "medium") (3=3 "higher") (66=.) (.=.), gen(education)

recode v145 (-9/-1=.) (4=1 "very bad") (3=2 "fairly bad") (2=3 "fairly good") (1=4 "very good") (.=.), gen(strongleader)

INDEPENDENT VARIABLES: sex religionimportance religionbelonging religiousdenomination religiousservice politicalview agecat maritalstatus Godimportance strongleader education

** CREATING COUNTRY VARIABLE in 2017 ** 

* Protection 

recode country (8=3) (31=0) (40=3) (51=0) (100=2) (112=0) (191=3) (203=1) (208=3) (233=2) (246=3) (250=3) (268=2) (276=1) (348=3) (352=2) (380=2) (440=3) (528=3) (578=3) (616=1) (642=2) (643=0) (688=3) (703=2) (705=2) (724=3) (752=3) (756=2) (826=3), generate (protection)
label define protectionlabel 0 "No discrimination protection" 1 "Limited discrimination protection" 2 "Partial discrimination protection" 3 "Extensive discrimination protection" 
label values protection protectionlabel
tab protection 

recode protection (0=0 "No discrimination protection") (1/3=1 "Discrimination protection"), gen(protection1)

* Relationship Recognition 

recode country (8=0) (31=0) (40=1) (51=0) (100=0) (112=0) (191=1) (203=1) (208=1) (233=1) (246=1) (250=1) (268=0) (276=1) (348=1) (352=1) (380=1) (440=0) (528=1) (578=1) (616=0) (642=0) (643=0) (688=0) (703=0) (705=1) (724=1) (752=1) (756=1) (826=1), generate (relationshiprecognition)
label define relationshiprecognitionlabel 0 "No legal same-sex relationship recognition" 1 "Same-sex civil union and/or marriage relationship recognition"
label values relationshiprecognition relationshiprecognitionlabel
tab relationshiprecognition

* As per Doebler (2015) country level religiosity is measured by the aggregate mean rate of attendance at religious services per country 

bysort country: egen countryreligiosity = mean(religiousservice) if !missing(religiousservice)

INDEPENDENT COUNTRY VARIABLES: protection relationshiprecognition countryreligiosity 

** BIVARIATE ANALYSIS for inclusion in MLM 

Sex --> 

SUMMARY STATISTICS: 

sum homosexuality sex 
tab homosexuality 
tab sex 

GRAPHS: 

graph bar (percent), over(sex)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality 
ssc install ciplot 
ciplot homosexuality, by(sex)

ASSUMPTION OF EQUAL VARIANCE

tab sex, sum(homosexuality) 
graph box homosexuality, over(sex) 

F-value and associated p-value 

oneway homosexuality sex, tab

* There is a statistically significant difference between male and female attitudes towards justifying homosexuality (F (1, 51618)= 121.51, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(sex) mcompare(bonferroni)

* Can reject the Null hypothesis 95% CI: 0.30 --> 0.44 

Therefore, include sex in the MLM. 

*******
Political View --> 

hist homosexuality, frequency normal 
hist politicalview, frequency normal

twoway (scatter homosexuality politicalview) (lfit homosexuality politicalview)
* ^ slight positive relationship between DV and IV 

Pearson's r 

pwcorr homosexuality politicalview, star(0.05)

Spearman's rho 

spearman homosexuality politicalview, star(0.05)

Regression model

reg homosexuality politicalview 

** all tests suggest the IV affects the DV, p<0.05 in all tests. Regression --> r-squared = 22% 

Therefore, include political view in MLM. 

*******
Age (categorical) --> 

SUMMARY STATISTICS: 

sum homosexuality agecat 
tab homosexuality 
tab agecat

GRAPHS: 

graph bar (percent), over(agecat)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality 
ciplot homosexuality, by(agecat)

ASSUMPTION OF EQUAL VARIANCE

tab agecat, sum(homosexuality) 
graph box homosexuality, over(agecat) 

F-value and associated p-value 

oneway homosexuality agecat, tab

* ^ There is a statistically significant difference between age categories attitudes towards justifying homosexuality (F (6, 51404)= 97.13, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(agecat) mcompare(bonferroni)

* Can reject SOME of the Null hypothes as 95% CI do not include 0. Others, for example, 35-44 years vs 25-34 years CI suggest that we can't reject the Null hypothesis as it includes 0: -0.142428 --> 0.2193888 

Despite this, include agecat in the MLM. 

*******
God Importance --> 

hist homosexuality, frequency normal
hist Godimportance, frequency normal 

twoway (scatter homosexuality Godimportance) (lfit homosexuality Godimportance)
* ^ from graph can see a moderate positive relationship between DV and IV 

Pearson's r 

pwcorr homosexuality Godimportance, star(0.05)

Spearman's rho 

spearman homosexuality Godimportance, star(0.05)

Regression model

reg homosexuality Godimportance 

** all tests suggest the IV affects the DV, p<0.05 in all tests. Regression --> r-squared = 19%

Therefore, include Godimportance in MLM. 

*******
Marital Status --> 

SUMMARY STATISTICS: 

sum homosexuality maritalstatus
tab homosexuality 
tab maritalstatus

GRAPHS: 

graph bar (percent), over(maritalstatus)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(maritalstatus)

ASSUMPTION OF EQUAL VARIANCE

tab maritalstatus, sum(homosexuality) 
graph box homosexuality, over(maritalstatus) 

F-value and associated p-value 

oneway homosexuality maritalstatus, tab

* There is a statistically significant difference between different marital status attitudes towards justifying homosexuality (F (5, 51296)= 464.96, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(maritalstatus) mcompare(bonferroni)

* Can reject all the Null hypotheses as 95% CI do not include 0, except one: seperated vs never married and never registered partnership: -0.3 --> 0.5

Therefore, include marital status in the MLM. 

*******
Education --> 

SUMMARY STATISTICS: 

sum homosexuality education
tab homosexuality 
tab education

GRAPHS: 

graph bar (percent), over(education)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(education)

ASSUMPTION OF EQUAL VARIANCE

tab education, sum(homosexuality) 
graph box homosexuality, over(education) 

F-value and associated p-value 

oneway homosexuality education, tab

* There is a statistically significant difference between educational attainment attitudes towards justifying homosexuality (F (2, 51251)= 829.87, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(education) mcompare(bonferroni)

* Can reject all the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include education in the MLM. 

*******
Strong Leader --> 

SUMMARY STATISTICS: 

sum homosexuality strongleader
tab homosexuality 
tab strongleader

GRAPHS: 

graph bar (percent), over(strongleader)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(strongleader)

ASSUMPTION OF EQUAL VARIANCE

tab strongleader, sum(homosexuality) 
graph box homosexuality, over(strongleader) 

F-value and associated p-value 

oneway homosexuality strongleader, tab

* There is a statistically significant difference between strong leader attitudes towards justifying homosexuality (F (3, 47279)= 2569.90, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(strongleader) mcompare(bonferroni)

* Can reject all the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include strong leader variable in the MLM. 

*******
Religion Importance --> 

SUMMARY STATISTICS: 

sum homosexuality religionimportance
tab homosexuality 
tab religionimportance

GRAPHS: 

graph bar (percent), over(religionimportance)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(religionimportance)

ASSUMPTION OF EQUAL VARIANCE

tab religionimportance, sum(homosexuality) 
graph box homosexuality, over(religionimportance) 

F-value and associated p-value 

oneway homosexuality religionimportance, tab

* There is a statistically significant difference between religion importance attitudes towards justifying homosexuality (F (3, 50980)= 2774.91, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(religionimportance) mcompare(bonferroni)

* Can reject all the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include religion importance variable in the MLM. 

*******
Religious belonging --> 

SUMMARY STATISTICS: 

sum homosexuality religionbelonging
tab homosexuality 
tab religionbelonging

GRAPHS: 

graph bar (percent), over(religionbelonging)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(religionbelonging)

ASSUMPTION OF EQUAL VARIANCE

tab religionbelonging, sum(homosexuality) 
graph box homosexuality, over(religionbelonging) 

F-value and associated p-value 

oneway homosexuality religionbelonging, tab

* There is a statistically significant difference between belonging to a religion attitudes towards justifying homosexuality (F (1, 51303)= 2012.72, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(religionbelonging) mcompare(bonferroni)

* Can reject all the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include religion belonging variable in the MLM. ** THIS LATER EXCLUDED FOR ISSUES OF COLLINEARITY 

*******
Religious Denomination --> 

SUMMARY STATISTICS: 

sum homosexuality religiousdenomination
tab homosexuality 
tab religiousdenomination

GRAPHS: 

graph bar (percent), over(religiousdenomination)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(religiousdenomination)

ASSUMPTION OF EQUAL VARIANCE

tab religiousdenomination, sum(homosexuality) 
graph box homosexuality, over(religiousdenomination) 

F-value and associated p-value 

oneway homosexuality religiousdenomination, tab

* There is a statistically significant difference between belonging to a religion attitudes towards justifying homosexuality (F (6, 50765)= 3620.93, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(religiousdenomination) mcompare(bonferroni)

* Can reject most of the Null hypotheses as 95% CI do not include 0. There is a difference. However, some, for example, denote no difference (cannot reject null): orthodox vs muslim: -0.14 --> 0.24.

Therefore, include religious denomination variable in the MLM. 

*******
Religious Service --> 

SUMMARY STATISTICS: 

sum homosexuality religiousservice
tab homosexuality 
tab religiousservice

GRAPHS: 

graph bar (percent), over(religiousservice)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(religiousservice)

ASSUMPTION OF EQUAL VARIANCE

tab religiousservice, sum(homosexuality) 
graph box homosexuality, over(religiousservice) 

F-value and associated p-value 

oneway homosexuality religiousservice, tab

* There is a statistically significant difference between religious service attendance attitudes towards justifying homosexuality (F (6, 51239)= 771.57, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(religiousservice) mcompare(bonferroni)

* Can reject all of the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include religious service variable in the MLM. 

*******
Legislation Protection --> 

SUMMARY STATISTICS: 

sum homosexuality protection1
tab homosexuality 
tab protection1

GRAPHS: 

graph bar (percent), over(protection1)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(protection1)

ASSUMPTION OF EQUAL VARIANCE

tab protection1, sum(homosexuality) 
graph box homosexuality, over(protection1) 

F-value and associated p-value 

oneway homosexuality protection1, tab

* There is a statistically significant difference between legislation protection attitudes towards justifying homosexuality (F (1, 51651)= 7459.41, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(protection1) mcompare(bonferroni)

* Can reject all of the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include legislation protection variable in the MLM. 

*******
Legislation Recognition --> 

SUMMARY STATISTICS: 

sum homosexuality relationshiprecognition
tab homosexuality 
tab relationshiprecognition

GRAPHS: 

graph bar (percent), over(relationshiprecognition)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(relationshiprecognition)

ASSUMPTION OF EQUAL VARIANCE

tab relationshiprecognition, sum(homosexuality) 
graph box homosexuality, over(relationshiprecognition) 

F-value and associated p-value 

oneway homosexuality relationshiprecognition, tab

* There is a statistically significant difference between legislation recognition attitudes towards justifying homosexuality (F (1, 51651)= 28652.41, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(relationshiprecognition) mcompare(bonferroni)

* Can reject all of the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include legislation protection variable in the MLM. 

*******
Country --> 

SUMMARY STATISTICS: 

sum homosexuality country
tab homosexuality 
tab country

GRAPHS: 

graph bar (percent), over(country)
hist homosexuality 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexuality  
ciplot homosexuality, by(country)

ASSUMPTION OF EQUAL VARIANCE

tab country, sum(homosexuality) 
graph box homosexuality, over(country) 

F-value and associated p-value 

oneway homosexuality country, tab

* There is a statistically significant difference between countries attitudes towards justifying homosexuality (F (29, 51623)= 1702.55, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexuality, over(country) mcompare(bonferroni)

* Can reject some of the Null hypotheses as 95% CI do not include 0. There is a difference. However, not in all. 

Therefore, include country variable in the MLM. 

*******
Country-level religiosity --> 

hist homosexuality, frequency normal
hist countryreligiosity, frequency normal 

twoway (scatter homosexuality countryreligiosity) (lfit homosexuality countryreligiosity)
* ^ from graph can see a moderate positive relationship between DV and IV 

Pearson's r 

pwcorr homosexuality countryreligiosity, star(0.05)

Spearman's rho 

spearman homosexuality countryreligiosity, star(0.05)

Regression model

reg homosexuality countryreligiosity 

** all tests suggest the IV affects the DV, p<0.05 in all tests. Regression --> r-squared = 17%

Therefore, include country religiosity in MLM. 

******************************************************************************************************************************
******************************************************************************************************************************

** EVS Random Intercept Model EVS ** * fixing the slope but allowing the intercepts to vary * 

* Null model with no covariates ** LATER REDONE TO ACCOUNT FOR DIFFERING SAMPLE SIZE

mixed homosexuality || country:, mle variance nostderr 

estat icc 

* ^ intraclass correlation statistic 

estimates store nullmodel 

* stores the null model results (_cons = 5.864944)

* to test for country effects, carry out a likelihood ratio test comparing the null MLM with a null single-level model -->

mixed homosexuality, mle variance nostderr

* The likelihood ratio test statistics is calculated as two times the difference in the log likelihood values for the two model --> 

LR = 2(MLM LL - SL LL) 

LR = 2(-125074.89--142283.25) = 34416.72 on 1 d.f. 

* ^^ own calculation 

However, the null model automatically compares the specified model with the equivalent single-level model --> calculates chibar2(01) = 34416.72, which supports own calculation. 

From the above, as the 5% point of a chi-squared distribution on 1 d.f. is 3.84, there is overwhelming evidence of country effects on justifying homosexuality. 
Therefore, revert to the MLM. 

* restore the estimates from the earlier model 

estimates restore nullmodel 

** VPC or ICC indicates that 47% of the variance in homosexuality attitudes can be attributed to the differences between countries. 

use estat icc or own calculation as follows to check (to 2d.p.): 

6.68+7.39=14.07 --> 6.68/14.07 = 0.474.. 

* Examining country effects (residuals) 

To estimate the country-level residuals and their associated standard errors, use predict command with reffects option and second with the reses option 

predict u0, reffects 
predict u0se, reses 

* u0 = predicted random intercepts, u0se = standard erros of the random intercepts 

* The country-level residuals and their standard errors have been calculated and stored for every record in the dataset. 
* However, summary statistics and graphs for country-level variables must be based on a dataset with one record per country. 
* Therefore, create a dummy variable to pick one observation per country. 

egen pickone=tag(country)

* Then sort country effects in ascending order based on the values of U0 

sort u0 

* Then rank the country effects. (generate u0rank equal to the cumulative sum of pickone --> the nth observation on uorank contains the sum of the first n observations on pickone) 

generate u0rank = sum(pickone) 

* To see the country residual, standard error and ranking for a particular country, list the data. 

sort country 

* OR to rank country residuals 

sort u0rank 

list country u0 u0se u0rank if pickone==1 

* From these values it can be seen, for example, Iceland has an estimated residual of -3.856016 which was ranked 1. 
* For this country, the estimated mean score is: 5.864944 - 3.856016 = 2.008928
* By contrast, Azerbaijan is ranked 30 with an estimated mean score of: 5.864944 + 3.803376 = 9.66832

****** 

* Next, produce a caterpillar plot to visualise the country effects in rank order together with 95% CI. 
* 1.96 denotes the option to obtain 95% confidence limits and the yline(0) option to plot a horizontal line at 0 which represents the average 

serrbar u0 u0se u0rank if pickone==1, scale(1.96) yline(0) scheme(s1mono) mlabel(country)

** Adding individual-level explanatory variables: RANDOM INTERCEPT MODEL

** adding FIXED individual (L1) covariates (where political view and god importance treated as continuous) ** religion belonging ommitted due to collinearity

**** FULL MODELS **** 

* MODEL 2

mixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance || country:, mle variance nostderr

estimates store model2 

** adding FIXED country (l2) explanatory variables: relationshiprecognition protection1 countryreligiosity  

* MODEL 3 

mixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition i.protection1 countryreligiosity || country:, mle variance nostderr

mixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition || country:, mle variance nostderr

*^ removed the non statistically significant country (L2) variables and marginal, if not zero difference in values (to check) but reported in table due to theoretical discussion 

estimates store model3 

** adding interactions 

* MODEL 4 

mixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition i.protection1 countryreligiosity i.sex#i.relationshiprecognition i.sex#i.protection1 i.religiousdenomination#i.relationshiprecognition i.sex#c.countryreligiosity || country:, mle variance nostderr 

mixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition i.protection1 countryreligiosity i.sex#i.protection1 i.religiousdenomination#i.relationshiprecognition || country:, mle variance nostderr 

** Comparing to null model with same sample size

generate sample= e(sample)

mixed homosexuality || country:, mle variance nostderr, if _est_model2==1

**********************************************

** Graphing interactions 

margins sex#protection1
marginsplot, xdimensions(protection1) scheme(s1mono)

margins religiousdenomination#relationshiprecognition 
marginsplot, xdimensions(relationshiprecognition) scheme(s1mono)

** MODEL FIT STATISTICS and R-squared (used xtmixed command)

MODEL 2: 

ssc install xtmrho 

quietly xtmixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance || country:, mle variance nostderr
estat ic 
xtmrho 
estimates store model2

generate sample=e(sample)
quietly xtmixed homosexuality || country:, mle variance nostderr, if _est_model2==1
estat ic 
xtmrho
estimates store nullmodel 

MODEL 3: 

quietly xtmixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition i.protection1 countryreligiosity || country:, mle variance nostderr
estat ic 
xtmrho
estimates store model3 

lrtest model2 nullmodel 
lrtest model3 model2 

** p<0.01 in LL tests 

For r-squared: 

where scalar(a) = level 2 variance (null), scalar(b) = level 1 variance (null), scalar(c) = 
*for Model 2
estimates restore nullmodel
scalar a=e(var_u1)
scalar b=e(var_e)

estimates restore model2
scalar c=e(var_u1)
scalar d=e(var_e)

scalar x=[[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 2 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 2 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

*for Model 3
estimates restore model3
scalar c=e(var_u1)
scalar d= e(var_e)

scalar y = [[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 3 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 3 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

OVERALL: 

di "Model 2 Overall R2 is: " [scalar(x)]
di "Model 3 Overall R2 is: " [scalar(y)]

**
MODEL 2 R2 other values
quietly xtmixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance || country:, mle variance nostderr
mltrsq

MODEl 3 R2 other values
quietly xtmixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition i.protection1 countryreligiosity || country:, mle variance nostderr
mltrsq

** DIAGNOSTICS 

model 3: 

mixed homosexuality i.sex i.agecat i.maritalstatus politicalview i.strongleader i. education i.religiousdenomination i.religiousservice i.religionimportance Godimportance i.relationshiprecognition i.protection1 countryreligiosity || country:, mle variance nostderr
*Level 1 residuals
predict L1_resid, residuals 
*Level 2 residuals
predict L2_resid, reffects 

*for graphs
histogram L1_resid, normal title("Histogram of Level 1 Residuals") scheme(s1mono)
graph save h1, replace 
histogram L2_resid, normal title("Histogram of Level 2 residuals") scheme(s1mono)
graph save h2, replace 
qnorm L1_resid, title("Qnorm Plot of Level 1 Residuals") scheme(s1mono)
graph save q1, replace 
qnorm L2_resid, title("Qnorm Plot Level 2 Residuals") scheme(s1mono)
graph save q2, replace 

*combine all graphs into one output
graph combine h1.gph h2.gph q1.gph q2.gph, scheme(s1mono)
graph save diagnosticgraphs, asis replace

** GRAPHS 

summarize homosexuality 

graph bar, over(homosexuality) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on Homosexuality Acceptance) scheme(s1mono)





*****************************************************************************************************************************************************************************************************************************************************


*****************************************************************************************************************************************************************************************************************************************************


*****************************************************************************************************************************************************************************************************************************************************

*****************************************************************************************************************************************************************************************************************************************************

*****************************************************************************************************************************************************************************************************************************************************
***********************************
***********************************
***********************************
** EuroBarometer 2015 DATA SET ** 


* DV's 
 
qc16_1 = statement on homosexual rights 
qc16_2 = statement on homosexual sex  
qc16_3 = statement on homosexual marriage 

* IV's 

sd3 = religious denomination 
d7r2 = marital status 
d10 = gender 
d11r1 = age categories
d11r2 = age categories
d11r3 = age categories
d8r1 = education years 
d8r2 = education years 
d25 = type of community 
d63 = social class (self-assessment) 
country = country code 

* RECODING VARIABLES *

** DV's ** 

fre qc16_2 
** note: missing and dont know combined; treated as continuous 
recode qc16_2 (1=1 "totally agree") (2=2 "tend to agree") (3=3 "tend to disagree") (4=4 "totally disagree") (.=.), gen(homosexualsex) 
graph bar, over(homosexualsex) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on "nothing wrong with same-sex sexual relationships") scheme(s1mono)

fre qc16_3 
** note: missing and dont know combined; treated as continuous 
recode qc16_3 (1=1 "totally agree") (2=2 "tend to agree") (3=3 "tend to disagree") (4=4 "totally disagree") (.=.), gen(homosexualmarriage) 
graph bar, over(homosexualmarriage) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on "Same-sex marriage should be allowed throughout Europe") scheme(s1mono)

fre qc16_1
** note: missing and dont know combined; treated as continuous 
recode qc16_1 (1=1 "totally agree") (2=2 "tend to agree") (3=3 "tend to disagree") (4=4 "totally disagree") (.=.), gen(homosexualrights) 
graph bar, over(homosexualrights) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on "LGB people should have the same rights as heterosexual people") scheme(s1mono)

** IV's (individual level L1) ** 

d10 = gender 
fre d10
** no missing data
recode d10 (-6/-1=.) (1=1 "man") (2=0 "woman") (.=.), gen(gender)

d7r2 = marital status 
fre d7r2
** missing and refusal coded together, other includes spontaneous 
recode d7r2 (1=1 "Single/Unmarried") (2=2 "(Re-)Married/Single with partner") (3=3 "Divorced or separated") (4=4 "Widowed") (5=5 "Other") (.=.), gen(maritalstatus)

d11r3 = age categories
fre d11r3 
** 17 data cases defined as "not clearly documented" therefore, treated as missing 
recode d11r3 (1=1 "15-24 years") (2=2 "25-34 years") (3=3 "35-44 years") (4=4 "45-54 years") (5=5 "55-64 years") (6=6 "65-74 years") (7=7 "75 years and older") (9=.), gen(agecat)

d8r2 = education years 
fre d8r2 
** noted missing data distinction
recode d8r2 (11=1 "No full-time education") (1=2 "Up to 15 years") (2=3 "16-19 years") (3=4 "20 years and older") (10=5 "Still studying") (.=.), gen(education)

d25 = type of community 
fre d25 
** 26 dont know missing cases 
recode d25 (1=1 "Rural area or village") (2=2 "Small or middle sized town") (3=3 "Large town") (.=.), gen(community) 

d63 = social class (self-assessment)
fre d63
** 604 DK, 145 RF missing cases
recode d63 (1=1 "The working class of society") (2=2 "The lower middle class of society") (3=3 "The middle class of society") (4=4 "The upper middle class of society") (5=5 "The higher class of society") (6/7=6 "Other/None") (.=.), gen(socialclass)

sd3 = religious denomination 
fre sd3 
** 254 DK, 936 RF, 1,190 missing cases 
recode sd3 (10=1 "Atheist") (11=2 "Non-believer/Agnostic") (1=3 "Catholic") (2=4 "Othodox Christian") (3=5 "Protestant") (4=6 "Other Christian") (5=7 "Jewish") (6=8 "Muslim") (7/9=9 "Sikh, Buddihist and Hindu") (12=10 "Other") (.=.), gen(religiousdenomination)

IV's = gender maritalstatus agecat education community socialclass religiousdenomination 

** IV (L2) 

country = country code 

** CREATING COUNTRY VARIABLE in 2015 for 2015 ** derived from https://ilga.org/downloads/ILGA_State_Sponsored_Homophobia_2015.pdf ** 

* Protection 

recode country (1/32=1), generate (protection)
label define protectionlabel 1 "Discrimination protection" 
label values protection protectionlabel
tab protection 

** THEREFORE, CANNOT USE IN ANALYSIS AND THERE IS NO ALTERNATIVE GROUP! COMPARISON NOT POSSIBLE!


* Relationship Recognition 

recode country (1/3=1) (4/5=0) (6/9=1) (10/11=0) (12/13=1) (14=0) (16/18=1) (19/20=0) (21/22=1) (23/24=0) (25=1) (26/30=0) (32=1), generate (relationshiprecognition)
label define relationshiprecognitionlabel 0 "No legal same-sex relationship recognition" 1 "Same-sex civil union and/or marriage relationship recognition"
label values relationshiprecognition relationshiprecognitionlabel
tab relationshiprecognition

** BIVARIATE ANALYSIS for inclusion in MLM HOMOSEXUAL SEX nothing wrong  

Gender (categorical) --> 

SUMMARY STATISTICS: 

sum homosexualsex gender 
tab homosexualsex 
tab gender

GRAPHS: 

graph bar (percent), over(gender)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(gender)

ASSUMPTION OF EQUAL VARIANCE

tab gender, sum(homosexualsex) 
graph box homosexualsex, over(gender) 

F-value and associated p-value 

oneway homosexualsex gender, tab

* ^ There is a statistically significant gender difference in attitudes towards homosexual sexual relationships (F (1, 26083)= 26.40, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(gender) mcompare(bonferroni)

* Can reject null hypothis as 95% CI do not include 0.

Therefore, include gender in the MLM. 

***************************************
Marital Status (categorical) --> 

SUMMARY STATISTICS: 

sum homosexualsex maritalstatus 
tab homosexualsex 
tab maritalstatus

GRAPHS: 

graph bar (percent), over(maritalstatus)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(maritalstatus)

ASSUMPTION OF EQUAL VARIANCE

tab maritalstatus, sum(homosexualsex) 
graph box homosexualsex, over(maritalstatus) 

F-value and associated p-value 

oneway homosexualsex maritalstatus, tab

* ^ There is a statistically significant marital status difference in attitudes towards homosexual sexual relationships (F (4, 26014)= 163.12, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(maritalstatus) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except: Other vs Single/Unmarried as CI suggest that we can't reject the Null hypothesis as it includes 0: -0.3427212 --> 0.095995

Therefore, include marital status in the MLM. 

***************************************
Age --> 

SUMMARY STATISTICS: 

sum homosexualsex agecat
tab homosexualsex 
tab agecat

GRAPHS: 

graph bar (percent), over(agecat)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(agecat)

ASSUMPTION OF EQUAL VARIANCE

tab agecat, sum(homosexualsex) 
graph box homosexualsex, over(agecat) 

F-value and associated p-value 

oneway homosexualsex agecat, tab

* ^ There is a statistically significant age difference in attitudes towards homosexual sexual relationships (F (6, 26063)= 120.11, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(agecat) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except: 25-34 years vs 15-24 years and 45-54 years vs 35-44 years, as CI;s suggest that we can't reject the Null hypothesis as it includes 0.

Despite this, include age in the MLM.

***************************************
Education --> 

SUMMARY STATISTICS: 

sum homosexualsex education
tab homosexualsex 
tab education

GRAPHS: 

graph bar (percent), over(education)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(education)

ASSUMPTION OF EQUAL VARIANCE

tab education, sum(homosexualsex) 
graph box homosexualsex, over(education) 

F-value and associated p-value 

oneway homosexualsex education, tab

* ^ There is a statistically significant educational difference in attitudes towards homosexual sexual relationships (F (4, 25619)= 320.42, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(education) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except:  Up to 15 years vs No full-time education and 16-19 years vs No full-time education, as CI;s suggest that we can't reject the Null hypothesis as it includes 0.

Despite this, include education in the MLM.

*************************************** 
Community type --> 

SUMMARY STATISTICS: 

sum homosexualsex community
tab homosexualsex 
tab community

GRAPHS: 

graph bar (percent), over(community)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(community)

ASSUMPTION OF EQUAL VARIANCE

tab community, sum(homosexualsex) 
graph box homosexualsex, over(community) 

F-value and associated p-value 

oneway homosexualsex community, tab

* ^ There is a statistically significant community type difference in attitudes towards homosexual sexual relationships (F (2, 26061)= 31.71, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(community) mcompare(bonferroni)

* Can reject the Null hypothes as 95% CI do not include 0.

Therefore, include community type in the MLM.

*************************************** 
Social class --> 

SUMMARY STATISTICS: 

sum homosexualsex socialclass
tab homosexualsex 
tab socialclass

GRAPHS: 

graph bar (percent), over(socialclass)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(socialclass)

ASSUMPTION OF EQUAL VARIANCE

tab socialclass, sum(homosexualsex) 
graph box homosexualsex, over(socialclass) 

F-value and associated p-value 

oneway homosexualsex socialclass, tab

* ^ There is a statistically significant social class difference in attitudes towards homosexual sexual relationships (F (5, 25450)= 165.76, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(socialclass) mcompare(bonferroni)

* Can reject some of the Null hypothes as 95% CI do not include 0, but some did; for example, Other/None vs The lower middle class of society.

Despite this, include social class in the MLM.

***************************************
Religious denomination --> 

SUMMARY STATISTICS: 

sum homosexualsex religiousdenomination
tab homosexualsex 
tab religiousdenomination

GRAPHS: 

graph bar (percent), over(religiousdenomination)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex 
ciplot homosexualsex, by(religiousdenomination)

ASSUMPTION OF EQUAL VARIANCE

tab religiousdenomination, sum(homosexualsex) 
graph box homosexualsex, over(religiousdenomination) 

F-value and associated p-value 

oneway homosexualsex religiousdenomination, tab

* ^ There is a statistically significant religious difference in attitudes towards homosexual sexual relationships (F (9, 24995)= 368.48, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(religiousdenomination) mcompare(bonferroni)

* Can reject some of the Null hypothes as 95% CI do not include 0, but some did; for example, Non-believer/Agnostic vs Atheist.

Despite this, include religious denomination in the MLM.

*******
Legislation Recognition --> 

SUMMARY STATISTICS: 

sum homosexualsex relationshiprecognition
tab homosexualsex 
tab relationshiprecognition

GRAPHS: 

graph bar (percent), over(relationshiprecognition)
hist homosexualsex 
OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex  
ciplot homosexualsex, by(relationshiprecognition)

ASSUMPTION OF EQUAL VARIANCE

tab relationshiprecognition, sum(homosexualsex) 
graph box homosexualsex, over(relationshiprecognition) 

F-value and associated p-value 

oneway homosexualsex relationshiprecognition, tab

* There is a statistically significant difference between legislation recognition attitudes towards homosexual sexual relationships (F (1, 26083)= 2914.14, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(relationshiprecognition) mcompare(bonferroni)

* Can reject all of the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include legislation protection variable in the MLM. 

*******
Country --> 

SUMMARY STATISTICS: 

sum homosexualsex country
tab homosexualsex 
tab country

GRAPHS: 

graph bar (percent), over(country)
hist homosexualsex 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualsex  
ciplot homosexualsex, by(country)

ASSUMPTION OF EQUAL VARIANCE

tab country, sum(homosexualsex) 
graph box homosexualsex, over(country) 

F-value and associated p-value 

oneway homosexualsex country, tab

* There is a statistically significant difference between countries attitudes towards homosexual sexual relationships (F (29, 26055)= 336.82, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualsex, over(country) mcompare(bonferroni)

* Can reject some of the Null hypotheses as 95% CI do not include 0. There is a difference. However, not in all. 

Therefore, include country variable in the MLM. 



*
*
*
*


** EVS Random Intercept Model EVS ** * fixing the slope but allowing the intercepts to vary * 

* MODEL 2 indvidual covariates: 

mixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr

estat icc 

estimates store model2 

generate sample= e(sample)

* MODEL 1 (NULL) with sample size same as above ^^ 

mixed homosexualsex || country:, mle variance nostderr, if _est_model2==1

estat icc 

estimates store nullmodel 

The null model automatically compares the specified model with the equivalent single-level model --> calculates chibar2(01) = 7465.95. 

From the above, as the 5% point of a chi-squared distribution on 1 d.f. is 3.84, there is overwhelming evidence of country effects on nothing wrong with samesex sexial relationships. 
Therefore, revert to the MLM. 

* restore the estimates from the earlier model 

estimates restore nullmodel 

** VPC or ICC indicates that 26.4%% of the variance in homosexuality attitudes can be attributed to the differences between countries. 

* Examining country effects (residuals) 

To estimate the country-level residuals and their associated standard errors, use predict command with reffects option and second with the reses option 

predict u0, reffects 
predict u0se, reses 

* u0 = predicted random intercepts, u0se = standard erros of the random intercepts 

* The country-level residuals and their standard errors have been calculated and stored for every record in the dataset. 
* However, summary statistics and graphs for country-level variables must be based on a dataset with one record per country. 
* Therefore, create a dummy variable to pick one observation per country. 

egen pickone=tag(country)

* Then sort country effects in ascending order based on the values of U0 

sort u0 

* Then rank the country effects. (generate u0rank equal to the cumulative sum of pickone --> the nth observation on uorank contains the sum of the first n observations on pickone) 

generate u0rank = sum(pickone) 

* To see the country residual, standard error and ranking for a particular country, list the data. 

sort country 

* OR to rank country residuals 

sort u0rank 

list country u0 u0se u0rank if pickone==1 

* From these values it can be seen, for example, Sweden has an estimated residual of -.9747305 which was ranked 1. 
* For this country, the estimated mean score is: 2.237281 -0.9747305 = 1.2625505
* By contrast, Latvia is ranked 30 with an estimated mean score of: 2.237281 + 1.029537 = 3.266818

****** 

* Next, produce a caterpillar plot to visualise the country effects in rank order together with 95% CI. 
* 1.96 denotes the option to obtain 95% confidence limits and the yline(0) option to plot a horizontal line at 0 which represents the average 

serrbar u0 u0se u0rank if pickone==1, scale(1.96) yline(0) scheme(s1mono)

** Adding individual-level explanatory variables: RANDOM INTERCEPT MODEL

* MODEL 3 individual and country level covariates - continuing from above ^^ 

** adding FIXED country (l2) explanatory variable: relationshiprecognition

mixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
estat icc 
estimates store model3

** adding interactions 

* MODEL 4 

CROSS LEVEL INTERACTIONS: 

mixed homosexualsex i.gender##i.relationshiprecognition i.maritalstatus##i.relationshiprecognition i.agecat##i.relationshiprecognition i.education##i.relationshiprecognition i.community##i.relationshiprecognition i.socialclass##i.relationshiprecognition i.religiousdenomination##i.relationshiprecognition || country:, mle variance nostderr


STAT SIG = community#relationshiprecognition

indivdiual interactions + cross level interaction above: 


mixed homosexualsex i.gender##i.agecat i.education##i.socialclass i.community##i.relationshiprecognition || country:, mle variance nostderr


final model 4 which include other covariates for holding factors constant: 

mixed homosexualsex i.gender i.agecat i.maritalstatus i.education i.socialclass i.religiousdenomination i.community##i.relationshiprecognition || country:, mle variance nostderr

estat icc
estimates store model4 

**********************************************

** Graphing interactions 

margins community#relationshiprecognition
marginsplot, xdimensions(relationshiprecognition) 


** MODEL FIT STATISTICS and R-squared (used xtmixed command)

MODEL 2: 

quietly xtmixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
estat ic 
xtmrho 
estimates store model2

quietly xtmixed homosexualsex || country:, mle variance nostderr, if _est_model2==1
estat ic 
xtmrho
estimates store nullmodel 

MODEL 3: 

quietly xtmixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
estat ic 
xtmrho
estimates store model3 

lrtest model2 nullmodel 
lrtest model3 model2 

** p<0.01 in LL tests 

For r-squared: 

where scalar(a) = level 2 variance (null), scalar(b) = level 1 variance (null), scalar(c) = level 2 variance (model of interest), scalar(d) level 1 variance (model of interest)
*for Model 2
estimates restore nullmodel
scalar a=e(var_u1)
scalar b=e(var_e)

estimates restore model2
scalar c=e(var_u1)
scalar d=e(var_e)

scalar x=[[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 2 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 2 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

*for Model 3
estimates restore model3
scalar c=e(var_u1)
scalar d= e(var_e)

scalar y = [[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 3 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 3 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

OVERALL: 

di "Model 2 Overall R2 is: " [scalar(x)]
di "Model 3 Overall R2 is: " [scalar(y)]

**
MODEL 2 R2 other values
quietly xtmixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
mltrsq

MODEl 3 R2 other values
quietly xtmixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
mltrsq

** DIAGNOSTICS 

model 3: 

mixed homosexualsex i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
*Level 1 residuals
predict L1_resid, residuals 
*Level 2 residuals
predict L2_resid, reffects 

*for graphs
histogram L1_resid, normal title("Histogram of Level 1 Residuals") scheme(s1mono)
graph save h1, replace 
histogram L2_resid, normal title("Histogram of Level 2 residuals") scheme(s1mono)
graph save h2, replace 
qnorm L1_resid, title("Qnorm Plot of Level 1 Residuals") scheme(s1mono)
graph save q1, replace 
qnorm L2_resid, title("Qnorm Plot Level 2 Residuals") scheme(s1mono)
graph save q2, replace 

*combine all graphs into one output
graph combine h1.gph h2.gph q1.gph q2.gph, scheme(s1mono)
graph save diagnosticgraphs homosexualsex, asis replace

** GRAPHS 

summarize homosexualsex

graph bar, over(homosexualsex) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on same-sex sexual relationships "nothing wrong") scheme(s1mono)

hist homosexualsex, frequency normal scheme(s1mono)




****************************************************************************************************************************************************************
****************************************************************************************************************************************************************
****************************************************************************************************************************************************************

** BIVARIATE ANALYSIS for inclusion in MLM same-sex marriage should be allowed throughout Europe

Gender (categorical) --> 

SUMMARY STATISTICS: 

sum homosexualmarriage gender 
tab homosexualmarriage 
tab gender

GRAPHS: 

graph bar (percent), over(gender)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(gender)

ASSUMPTION OF EQUAL VARIANCE

tab gender, sum(homosexualmarriage) 
graph box homosexualmarriage, over(gender) 

F-value and associated p-value 

oneway homosexualmarriage gender, tab

* ^ There is a statistically significant gender difference in attitudes towards same-sex marriage (F (1, 25909)= 28.59, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(gender) mcompare(bonferroni)

* Can reject null hypothis as 95% CI do not include 0. There is a difference.

Therefore, include gender in the MLM. 

***************************************
Marital Status (categorical) --> 

SUMMARY STATISTICS: 

sum homosexualmarriage maritalstatus 
tab homosexualmarriage 
tab maritalstatus

GRAPHS: 

graph bar (percent), over(maritalstatus)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(maritalstatus)

ASSUMPTION OF EQUAL VARIANCE

tab maritalstatus, sum(homosexualmarriage) 
graph box homosexualmarriage, over(maritalstatus) 

F-value and associated p-value 

oneway homosexualmarriage maritalstatus, tab

* ^ There is a statistically significant marital status difference in attitudes towards same-sex marriage (F (4, 25845)= 173.71, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(maritalstatus) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except: Other vs Single/Unmarried as CI suggest that we can't reject the Null hypothesis as it includes 0: -0.4051828 --> 0.0485207

Therefore, include marital status in the MLM. 

***************************************
Age --> 

SUMMARY STATISTICS: 

sum homosexualmarriage agecat
tab homosexualmarriage 
tab agecat

GRAPHS: 

graph bar (percent), over(agecat)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(agecat)

ASSUMPTION OF EQUAL VARIANCE

tab agecat, sum(homosexualmarriage) 
graph box homosexualmarriage, over(agecat) 

F-value and associated p-value 

oneway homosexualmarriage agecat, tab

* ^ There is a statistically significant age difference in attitudes towards same-sex marriage (F (6, 25889)= 127.05, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(agecat) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except: 25-34 years vs 15-24 years and 45-54 years vs 35-44 years, as CI;s suggest that we can't reject the Null hypothesis as it includes 0.

Despite this, include age in the MLM.

***************************************
Education --> 

SUMMARY STATISTICS: 

sum homosexualmarriage education
tab homosexualmarriage 
tab education

GRAPHS: 

graph bar (percent), over(education)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(education)

ASSUMPTION OF EQUAL VARIANCE

tab education, sum(homosexualmarriage) 
graph box homosexualmarriage, over(education) 

F-value and associated p-value 

oneway homosexualmarriage education, tab

* ^ There is a statistically significant educational difference in attitudes towards same-sex marriage (F (4, 25447)= 272.03, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(education) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except:  Up to 15 years vs No full-time education and 16-19 years vs No full-time education, as CI;s suggest that we can't reject the Null hypothesis as it includes 0.

Despite this, include education in the MLM.

*************************************** 
Community type --> 

SUMMARY STATISTICS: 

sum homosexualmarriage community
tab homosexualmarriage 
tab community

GRAPHS: 

graph bar (percent), over(community)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(community)

ASSUMPTION OF EQUAL VARIANCE

tab community, sum(homosexualmarriage) 
graph box homosexualmarriage, over(community) 

F-value and associated p-value 

oneway homosexualmarriage community, tab

* ^ There is a statistically significant community type difference in attitudes towards same-sex marriage (F (2, 25887)= 21.28, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(community) mcompare(bonferroni)

* Can reject the Null hypothes as 95% CI do not include 0.

Therefore, include community type in the MLM.

*************************************** 
Social class --> 

SUMMARY STATISTICS: 

sum homosexualmarriage socialclass
tab homosexualmarriage 
tab socialclass

GRAPHS: 

graph bar (percent), over(socialclass)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(socialclass)

ASSUMPTION OF EQUAL VARIANCE

tab socialclass, sum(homosexualmarriage) 
graph box homosexualmarriage, over(socialclass) 

F-value and associated p-value 

oneway homosexualmarriage socialclass, tab

* ^ There is a statistically significant social class difference in attitudes towards same-sex marriage (F (5, 25279)= 131.25, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(socialclass) mcompare(bonferroni)

* Can reject some of the Null hypothes as 95% CI do not include 0, but some did; for example, Other/None vs The lower middle class of society.

Despite this, include social class in the MLM.

***************************************
Religious denomination --> 

SUMMARY STATISTICS: 

sum homosexualmarriage religiousdenomination
tab homosexualmarriage 
tab religiousdenomination

GRAPHS: 

graph bar (percent), over(religiousdenomination)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage 
ciplot homosexualmarriage, by(religiousdenomination)

ASSUMPTION OF EQUAL VARIANCE

tab religiousdenomination, sum(homosexualmarriage) 
graph box homosexualmarriage, over(religiousdenomination) 

F-value and associated p-value 

oneway homosexualmarriage religiousdenomination, tab

* ^ There is a statistically significant religious difference in attitudes towards same-sex marriage (F (9, 24821)= 381.16, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(religiousdenomination) mcompare(bonferroni)

* Can reject some of the Null hypothes as 95% CI do not include 0, but some did; for example, Non-believer/Agnostic vs Atheist.

Despite this, include religious denomination in the MLM.

*******
Legislation Recognition --> 

SUMMARY STATISTICS: 

sum homosexualmarriage relationshiprecognition
tab homosexualmarriage 
tab relationshiprecognition

GRAPHS: 

graph bar (percent), over(relationshiprecognition)
hist homosexualmarriage 
OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage  
ciplot homosexualmarriage, by(relationshiprecognition)

ASSUMPTION OF EQUAL VARIANCE

tab relationshiprecognition, sum(homosexualmarriage) 
graph box homosexualmarriage, over(relationshiprecognition) 

F-value and associated p-value 

oneway homosexualmarriage relationshiprecognition, tab

* There is a statistically significant difference between legislation recognition attitudes towards justifying homosexuality (F (1, 25909)= 3121.98, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(relationshiprecognition) mcompare(bonferroni)

* Can reject all of the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include legislation protection variable in the MLM. 

*******
Country --> 

SUMMARY STATISTICS: 

sum homosexualmarriage country
tab homosexualmarriage 
tab country

GRAPHS: 

graph bar (percent), over(country)
hist homosexualmarriage 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualmarriage  
ciplot homosexualmarriage, by(country)

ASSUMPTION OF EQUAL VARIANCE

tab country, sum(homosexualmarriage) 
graph box homosexualmarriage, over(country) 

F-value and associated p-value 

oneway homosexualmarriage country, tab

* There is a statistically significant difference between countries attitudes towards justifying homosexuality (F (29, 25881)= 351.62, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualmarriage, over(country) mcompare(bonferroni)

* Can reject some of the Null hypotheses as 95% CI do not include 0. There is a difference. However, not in all. 

Therefore, include country variable in the MLM. * This test is arbitrary, given the nature of the analysis, this variable is always relevant. 



*
*
*
*

drop L1_resid L2_resid u0 u0se pickone u0rank userest _est_model4 _est_nullmodel _est_model2 _est_model3 mltsample

** EVS Random Intercept Model EVS ** * fixing the slope but allowing the intercepts to vary * 

* MODEL 2 indvidual covariates: 

mixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr

estat icc 

estimates store model2 

generate sample= e(sample)

* MODEL 1 (NULL) with sample size same as above ^^ 

mixed homosexualmarriage || country:, mle variance nostderr, if _est_model2==1

estat icc 

estimates store nullmodel 

The null model automatically compares the specified model with the equivalent single-level model --> calculates chibar2(01) = 7687.62. 

From the above, as the 5% point of a chi-squared distribution on 1 d.f. is 3.84, there is overwhelming evidence of country effects on attitudinal differences in same-sex marriage should be allowed througout Europe. 
Therefore, revert to the MLM. 

* restore the estimates from the earlier model 

estimates restore nullmodel 

** VPC or ICC indicates that 27.2%% of the variance in homosexuality attitudes can be attributed to the differences between countries. 

* Examining country effects (residuals) 

To estimate the country-level residuals and their associated standard errors, use predict command with reffects option and second with the reses option 

predict u0, reffects 
predict u0se, reses 

* u0 = predicted random intercepts, u0se = standard erros of the random intercepts 

* The country-level residuals and their standard errors have been calculated and stored for every record in the dataset. 
* However, summary statistics and graphs for country-level variables must be based on a dataset with one record per country. 
* Therefore, create a dummy variable to pick one observation per country. 

egen pickone=tag(country)

* Then sort country effects in ascending order based on the values of U0 

sort u0 

* Then rank the country effects. (generate u0rank equal to the cumulative sum of pickone --> the nth observation on uorank contains the sum of the first n observations on pickone) 

generate u0rank = sum(pickone) 

* To see the country residual, standard error and ranking for a particular country, list the data. 

sort country 

* OR to rank country residuals 

sort u0rank 

list country u0 u0se u0rank if pickone==1 

* From these values it can be seen, for example, Sweden has an estimated residual of -1.069807 which was ranked 1. 
* For this country, the estimated mean score is: 2.352842 -1.069807 = 1.283035
* By contrast, Latvia is ranked 30 with an estimated mean score of: 2.352842 + 1.036993 = 3.389835

****** 

* Next, produce a caterpillar plot to visualise the country effects in rank order together with 95% CI. 
* 1.96 denotes the option to obtain 95% confidence limits and the yline(0) option to plot a horizontal line at 0 which represents the average 

serrbar u0 u0se u0rank if pickone==1, scale(1.96) yline(0) scheme(s1mono)

** Adding individual-level explanatory variables: RANDOM INTERCEPT MODEL

* MODEL 3 individual and country level covariates - continuing from above ^^ 

** adding FIXED country (l2) explanatory variable: relationshiprecognition

mixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
estat icc 
estimates store model3

** adding interactions 

* MODEL 4 

CROSS LEVEL INTERACTIONS: 

mixed homosexualmarriage i.gender##i.relationshiprecognition i.maritalstatus##i.relationshiprecognition i.agecat##i.relationshiprecognition i.education##i.relationshiprecognition i.community##i.relationshiprecognition i.socialclass##i.relationshiprecognition i.religiousdenomination##i.relationshiprecognition || country:, mle variance nostderr


STAT SIG = community#relationshiprecognition

indivdiual interactions + cross level interaction above: 


mixed homosexualmarriage i.gender##i.agecat i.education##i.socialclass i.community##i.relationshiprecognition || country:, mle variance nostderr


final model 4 which include other covariates for holding factors constant: 

mixed homosexualmarriage i.gender i.agecat i.maritalstatus i.education i.socialclass i.religiousdenomination i.community##i.relationshiprecognition || country:, mle variance nostderr

estat icc
estimates store model4 

**********************************************

** Graphing interactions 

margins community#relationshiprecognition
marginsplot, xdimensions(relationshiprecognition) scheme(s1mono)


** MODEL FIT STATISTICS and R-squared (used xtmixed command)

MODEL 2: 

quietly xtmixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
estat ic 
xtmrho 
estimates store model2

quietly xtmixed homosexualmarriage || country:, mle variance nostderr, if _est_model2==1
estat ic 
xtmrho
estimates store nullmodel 

MODEL 3: 

quietly xtmixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
estat ic 
xtmrho
estimates store model3 

lrtest model2 nullmodel 
lrtest model3 model2 

** p<0.01 in LL tests 

For r-squared: 

where scalar(a) = level 2 variance (null), scalar(b) = level 1 variance (null), scalar(c) = level 2 variance (model of interest), scalar(d) level 1 variance (model of interest)
*for Model 2
estimates restore nullmodel
scalar a=e(var_u1)
scalar b=e(var_e)

estimates restore model2
scalar c=e(var_u1)
scalar d=e(var_e)

scalar x=[[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 2 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 2 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

*for Model 3
estimates restore model3
scalar c=e(var_u1)
scalar d= e(var_e)

scalar y = [[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 3 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 3 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

OVERALL: 

di "Model 2 Overall R2 is: " [scalar(x)]
di "Model 3 Overall R2 is: " [scalar(y)]

**
MODEL 2 R2 other values
quietly xtmixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
mltrsq

MODEl 3 R2 other values
quietly xtmixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
mltrsq

** DIAGNOSTICS 

model 3: 

mixed homosexualmarriage i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
*Level 1 residuals
predict L1_resid, residuals 
*Level 2 residuals
predict L2_resid, reffects 

*for graphs
histogram L1_resid, normal title("Histogram of Level 1 Residuals") scheme(s1mono)
graph save h1, replace 
histogram L2_resid, normal title("Histogram of Level 2 residuals") scheme(s1mono)
graph save h2, replace 
qnorm L1_resid, title("Qnorm Plot of Level 1 Residuals") scheme(s1mono)
graph save q1, replace 
qnorm L2_resid, title("Qnorm Plot Level 2 Residuals") scheme(s1mono)
graph save q2, replace 

*combine all graphs into one output
graph combine h1.gph h2.gph q1.gph q2.gph, scheme(s1mono)
graph save diagnosticgraphs homosexualsex, asis replace

** GRAPHS 

summarize homosexualsex

graph bar, over(homosexualsex) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on same-sex sexual relationships "nothing wrong") scheme(s1mono)

hist homosexualmarriage, frequency normal scheme(s1mono)


****************************************************************************************************************************************************************
****************************************************************************************************************************************************************
****************************************************************************************************************************************************************

** BIVARIATE ANALYSIS for inclusion in MLM LGB people should have the same rights as heterosexual people
Gender (categorical) --> 

SUMMARY STATISTICS: 

sum homosexualrights gender 
tab homosexualrights 
tab gender

GRAPHS: 

graph bar (percent), over(gender)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(gender)

ASSUMPTION OF EQUAL VARIANCE

tab gender, sum(homosexualrights) 
graph box homosexualrights, over(gender) 

F-value and associated p-value 

oneway homosexualrights gender, tab

* ^ There is a statistically significant gender difference in attitudes towards LGB rights (F (1, 26054)= 14.80, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(gender) mcompare(bonferroni)

* Can reject null hypothis as 95% CI do not include 0. There is a difference.

Therefore, include gender in the MLM. 

***************************************
Marital Status (categorical) --> 

SUMMARY STATISTICS: 

sum homosexualrights maritalstatus 
tab homosexualrights 
tab maritalstatus

GRAPHS: 

graph bar (percent), over(maritalstatus)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(maritalstatus)

ASSUMPTION OF EQUAL VARIANCE

tab maritalstatus, sum(homosexualrights) 
graph box homosexualrights, over(maritalstatus) 

F-value and associated p-value 

oneway homosexualrights maritalstatus, tab

* ^ There is a statistically significant marital status difference in attitudes towards LGB rights (F (4, 25985)= 139.06, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(maritalstatus) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0. There is a difference. 

Therefore, include marital status in the MLM. 

***************************************
Age --> 

SUMMARY STATISTICS: 

sum homosexualrights agecat
tab homosexualrights 
tab agecat

GRAPHS: 

graph bar (percent), over(agecat)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(agecat)

ASSUMPTION OF EQUAL VARIANCE

tab agecat, sum(homosexualrights) 
graph box homosexualrights, over(agecat) 

F-value and associated p-value 

oneway homosexualrights agecat, tab

* ^ There is a statistically significant age difference in attitudes towards LGB rights (F (6, 26035)= 75.70, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(agecat) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except: 25-34 years vs 15-24 years and 45-54 years vs 35-44 years, as CI;s suggest that we can't reject the Null hypothesis as it includes 0.

Despite this, include age in the MLM.

***************************************
Education --> 

SUMMARY STATISTICS: 

sum homosexualrights education
tab homosexualrights 
tab education

GRAPHS: 

graph bar (percent), over(education)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(education)

ASSUMPTION OF EQUAL VARIANCE

tab education, sum(homosexualrights) 
graph box homosexualrights, over(education) 

F-value and associated p-value 

oneway homosexualrights education, tab

* ^ There is a statistically significant educational difference in attitudes towards LGB rights (F (4, 25596)= 283.66, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(education) mcompare(bonferroni)

* Can reject all of the Null hypothes as 95% CI do not include 0, except:  Up to 15 years vs No full-time education and 16-19 years vs No full-time education, as CI;s suggest that we can't reject the Null hypothesis as it includes 0.

Despite this, include education in the MLM.

*************************************** 
Community type --> 

SUMMARY STATISTICS: 

sum homosexualrights community
tab homosexualrights 
tab community

GRAPHS: 

graph bar (percent), over(community)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(community)

ASSUMPTION OF EQUAL VARIANCE

tab community, sum(homosexualrights) 
graph box homosexualrights, over(community) 

F-value and associated p-value 

oneway homosexualrights community, tab

* ^ There is a statistically significant community type difference in attitudes towards LGB rights (F (2, 26031)= 60.26, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(community) mcompare(bonferroni)

* Can reject the Null hypothes as 95% CI do not include 0.

Therefore, include community type in the MLM.

*************************************** 
Social class --> 

SUMMARY STATISTICS: 

sum homosexualrights socialclass
tab homosexualrights 
tab socialclass

GRAPHS: 

graph bar (percent), over(socialclass)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(socialclass)

ASSUMPTION OF EQUAL VARIANCE

tab socialclass, sum(homosexualrights) 
graph box homosexualrights, over(socialclass) 

F-value and associated p-value 

oneway homosexualrights socialclass, tab

* ^ There is a statistically significant social class difference in attitudes toward LGB rights (F (5, 25425)= 102.40, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(socialclass) mcompare(bonferroni)

* Can reject some of the Null hypothes as 95% CI do not include 0, but some did; for example, Other/None vs The lower middle class of society.

Despite this, include social class in the MLM.

***************************************
Religious denomination --> 

SUMMARY STATISTICS: 

sum homosexualrights religiousdenomination
tab homosexualrights 
tab religiousdenomination

GRAPHS: 

graph bar (percent), over(religiousdenomination)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights 
ciplot homosexualrights, by(religiousdenomination)

ASSUMPTION OF EQUAL VARIANCE

tab religiousdenomination, sum(homosexualrights) 
graph box homosexualrights, over(religiousdenomination) 

F-value and associated p-value 

oneway homosexualrights religiousdenomination, tab

* ^ There is a statistically significant religious difference in attitudes towards same-sex marriage (F (9, 24958)= 203.74, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(religiousdenomination) mcompare(bonferroni)

* Can reject some of the Null hypothes as 95% CI do not include 0, but some did; for example, Non-believer/Agnostic vs Atheist.

Despite this, include religious denomination in the MLM.

*******
Legislation Recognition --> 

SUMMARY STATISTICS: 

sum homosexualrights relationshiprecognition
tab homosexualrights 
tab relationshiprecognition

GRAPHS: 

graph bar (percent), over(relationshiprecognition)
hist homosexualrights 
OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights  
ciplot homosexualrights, by(relationshiprecognition)

ASSUMPTION OF EQUAL VARIANCE

tab relationshiprecognition, sum(homosexualrights) 
graph box homosexualrights, over(relationshiprecognition) 

F-value and associated p-value 

oneway homosexualrights relationshiprecognition, tab

* There is a statistically significant difference between legislation recognition attitudes towards justifying homosexuality (F (1, 26054)= 2001.00, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(relationshiprecognition) mcompare(bonferroni)

* Can reject all of the Null hypotheses as 95% CI do not include 0. There is a difference. 

Therefore, include legislation protection variable in the MLM. 

*******
Country --> 

SUMMARY STATISTICS: 

sum homosexualrights country
tab homosexualrights 
tab country

GRAPHS: 

graph bar (percent), over(country)
hist homosexualrights 

OVERALL AND GROUP MEANS WITH CI: 

ci mean homosexualrights  
ciplot homosexualrights, by(country)

ASSUMPTION OF EQUAL VARIANCE

tab country, sum(homosexualrights) 
graph box homosexualrights, over(country) 

F-value and associated p-value 

oneway homosexualrights country, tab

* There is a statistically significant difference between countries attitudes towards justifying homosexuality (F (29, 26026)= 250.63, p<0.05)

Reporting magnitude of difference between group averages 

pwmean homosexualrights, over(country) mcompare(bonferroni)

* Can reject some of the Null hypotheses as 95% CI do not include 0. There is a difference. However, not in all. 

Therefore, include country variable in the MLM. * This test is arbitrary, given the nature of the analysis, this variable is always relevant. 



*
*
*
*

drop L1_resid L2_resid u0 u0se pickone u0rank userest _est_model4 _est_nullmodel _est_model2 _est_model3 mltsample sample

** EVS Random Intercept Model EVS ** * fixing the slope but allowing the intercepts to vary * 

* MODEL 2 indvidual covariates: 

mixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr

estat icc 

estimates store model2 

generate sample= e(sample)

* MODEL 1 (NULL) with sample size same as above ^^ 

mixed homosexualrights || country:, mle variance nostderr, if _est_model2==1

estat icc 

estimates store nullmodel 

The null model automatically compares the specified model with the equivalent single-level model --> calculates chibar2(01) = 5729.66. 

From the above, as the 5% point of a chi-squared distribution on 1 d.f. is 3.84, there is overwhelming evidence of country effects on attitudinal differences in same-sex marriage should be allowed througout Europe. 
Therefore, revert to the MLM. 

* restore the estimates from the earlier model 

estimates restore nullmodel 

** VPC or ICC indicates that 21.05%% of the variance in homosexuality attitudes can be attributed to the differences between countries. 

* Examining country effects (residuals) 

To estimate the country-level residuals and their associated standard errors, use predict command with reffects option and second with the reses option 

predict u0, reffects 
predict u0se, reses 

* u0 = predicted random intercepts, u0se = standard erros of the random intercepts 

* The country-level residuals and their standard errors have been calculated and stored for every record in the dataset. 
* However, summary statistics and graphs for country-level variables must be based on a dataset with one record per country. 
* Therefore, create a dummy variable to pick one observation per country. 

egen pickone=tag(country)

* Then sort country effects in ascending order based on the values of U0 

sort u0 

* Then rank the country effects. (generate u0rank equal to the cumulative sum of pickone --> the nth observation on uorank contains the sum of the first n observations on pickone) 

generate u0rank = sum(pickone) 

* To see the country residual, standard error and ranking for a particular country, list the data. 

sort country 

* OR to rank country residuals 

sort u0rank 

list country u0 u0se u0rank if pickone==1 

* From these values it can be seen, for example, Sweden has an estimated residual of -0.9161891 which was ranked 1. 
* For this country, the estimated mean score is: 2.062578 -0.9161891 = 1.1463889
* By contrast, Latvia is ranked 30 with an estimated mean score of: 2.062578 + 0.7967741 = 2.8593521

****** 

* Next, produce a caterpillar plot to visualise the country effects in rank order together with 95% CI. 
* 1.96 denotes the option to obtain 95% confidence limits and the yline(0) option to plot a horizontal line at 0 which represents the average 

serrbar u0 u0se u0rank if pickone==1, scale(1.96) yline(0) scheme(s1mono)

** Adding individual-level explanatory variables: RANDOM INTERCEPT MODEL

* MODEL 3 individual and country level covariates - continuing from above ^^ 

** adding FIXED country (l2) explanatory variable: relationshiprecognition

mixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
estat icc 
estimates store model3

** adding interactions 

* MODEL 4 

CROSS LEVEL INTERACTIONS: 

mixed homosexualrights i.gender##i.relationshiprecognition i.maritalstatus##i.relationshiprecognition i.agecat##i.relationshiprecognition i.education##i.relationshiprecognition i.community##i.relationshiprecognition i.socialclass##i.relationshiprecognition i.religiousdenomination##i.relationshiprecognition || country:, mle variance nostderr


STAT SIG = community#relationshiprecognition

indivdiual interactions + cross level interaction above: 


mixed homosexualmarriage i.gender##i.agecat i.education##i.socialclass i.community##i.relationshiprecognition || country:, mle variance nostderr


final model 4 which include other covariates for holding factors constant: 

mixed homosexualrights i.gender i.agecat i.maritalstatus i.education i.socialclass i.religiousdenomination i.community##i.relationshiprecognition || country:, mle variance nostderr

estat icc
estimates store model4 

**********************************************

** Graphing interaction

margins community#relationshiprecognition
marginsplot, xdimensions(relationshiprecognition) scheme(s1mono)

** MODEL FIT STATISTICS and R-squared (used xtmixed command)

MODEL 2: 

quietly xtmixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
estat ic 
xtmrho 
estimates store model2

quietly xtmixed homosexualrights || country:, mle variance nostderr, if _est_model2==1
estat ic 
xtmrho
estimates store nullmodel 

MODEL 3: 

quietly xtmixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
estat ic 
xtmrho
estimates store model3 

lrtest model2 nullmodel 
lrtest model3 model2 

** p<0.01 in LL tests 

For r-squared: 

where scalar(a) = level 2 variance (null), scalar(b) = level 1 variance (null), scalar(c) = level 2 variance (model of interest), scalar(d) level 1 variance (model of interest)
*for Model 2
estimates restore nullmodel
scalar a=e(var_u1)
scalar b=e(var_e)

estimates restore model2
scalar c=e(var_u1)
scalar d=e(var_e)

scalar x=[[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 2 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 2 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

*for Model 3
estimates restore model3
scalar c=e(var_u1)
scalar d= e(var_e)

scalar y = [[scalar(a)+scalar(b)] - [scalar(d)+scalar(c)]]/[scalar(a)+scalar(b)]

di "Model 3 Level 1 R2 is: " [scalar(b)-scalar(d)]/scalar(d)
di "Model 3 Level 2 R2 is: " [scalar(a)-scalar(c)] /scalar(c)

OVERALL: 

di "Model 2 Overall R2 is: " [scalar(x)]
di "Model 3 Overall R2 is: " [scalar(y)]

**
MODEL 2 R2 other values
quietly xtmixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
mltrsq

MODEl 3 R2 other values
quietly xtmixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
mltrsq

** DIAGNOSTICS 

model 3: 

mixed homosexualrights i.gender i.maritalstatus i.agecat i.education i.community i.socialclass i.religiousdenomination i.relationshiprecognition || country:, mle variance nostderr
*Level 1 residuals
predict L1_resid, residuals 
*Level 2 residuals
predict L2_resid, reffects 


*for graphs
histogram L1_resid, normal title("Histogram of Level 1 Residuals") scheme(s1mono)
graph save h1, replace 
histogram L2_resid, normal title("Histogram of Level 2 residuals") scheme(s1mono)
graph save h2, replace 
qnorm L1_resid, title("Qnorm Plot of Level 1 Residuals") scheme(s1mono)
graph save q1, replace 
qnorm L2_resid, title("Qnorm Plot Level 2 Residuals") scheme(s1mono)
graph save q2, replace 

*combine all graphs into one output
graph combine h1.gph h2.gph q1.gph q2.gph, scheme(s1mono)
graph save diagnosticgraphs homosexualrights, asis replace

** GRAPHS 

summarize homosexualsex

graph bar, over(homosexualsex) exclude0 blabel(bar, format(%6.0g)) ytitle(Percent (%)) title(Descriptive Statistics on same-sex sexual relationships "nothing wrong")  scheme(s1mono)

hist homosexualmarriage, frequency normal addlabel addlabopts(yvarformat(%4.0f)) ylabel(0(1000)11000) xlabel(1 "totally agree" 2 "tend to agree" 3 "tend to disagree" 4 "totally disagree", labs(tiny)) xtitle(Attitude) ytitle(Frequency) title("Histogram of Homosexual Marriage attitudes") yla(, format("%1.0f") ang(h)) scheme(s1mono)
graph save homosexualmarriageh1, replace
hist homosexualrights, frequency normal addlabel addlabopts(yvarformat(%4.0f)) ylabel(0(1000)11000) xlabel(1 "totally agree" 2 "tend to agree" 3 "tend to disagree" 4 "totally disagree", labs(tiny)) xtitle(Attitude) ytitle(Frequency) title("Histogram of LGB Rights attitudes") yla(, format("%1.0f") ang(h)) scheme(s1mono)
graph save homosexualrightsh1, replace
hist homosexualsex, frequency normal addlabel addlabopts(yvarformat(%4.0f)) ylabel(0(1000)11000) xlabel(1 "totally agree" 2 "tend to agree" 3 "tend to disagree" 4 "totally disagree",labs(tiny)) xtitle(Attitude) ytitle(Frequency) title("Histogram of Same-sex sexual relationships attitudes") yla(, format("%1.0f") ang(h)) scheme(s1mono)
graph save homosexualsexh1, replace

graph combine homosexualmarriageh1.gph homosexualrightsh1.gph homosexualsexh1.gph,


histogram homosexuality, percent ytitle(Percent (%)) xtitle(Justifying Homosexuality) by(, title(Individual country histograms: attitudes toward justifying homosexuality)) by(country) scheme(s1mono)


histogram homosexualsex, percent ytitle(Percent (%)) xtitle(Nothing wrong with same-sex sexual relationships) by(, title("Individual country histograms: attitudes toward Nothing wrong with same-sex sexual relationships")) by(country) scheme(s1mono)
histogram homosexualmarriage, percent ytitle(Percent (%)) xtitle(Same-sex marriage should be allowed through Europe) by(, title(Individual country histograms: attitudes toward same-sex marriage should be allowed through Europe)) by(country) scheme(s1mono)
histogram homosexualrights, percent ytitle(Percent (%)) xtitle(LGB people should have the same rights as heterosexual people) by(, title(Individual country histograms: attitudes toward LGB people should have the same rights as heterosexual people)) by(country) scheme(s1mono)




ERROR FOUND = married not in isolation 

recode d7r1 (3=1 "Single") (1=2 "(Re-)Married") (2=3 "Single with partner") (4=4 "Divorced or separated") (5=5 "Widowed") (6=6 "Other") (.=.), gen(maritalstatus1)

mixed homosexualsex i.gender i.maritalstatus1 i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
mixed homosexualmarriage i.gender i.maritalstatus1 i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr
mixed homosexualrights i.gender i.maritalstatus1 i.agecat i.education i.community i.socialclass i.religiousdenomination || country:, mle variance nostderr

*** becomes siginificant for marriage and rights at 5% level, however, coefficients are very small (0.045 and 0.043). 


















































