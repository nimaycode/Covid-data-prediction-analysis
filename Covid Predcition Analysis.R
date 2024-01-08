---
title: "CS 422"
---

<!-- More information in R Markdown can be found at:
1. https://www.ssc.wisc.edu/sscc/pubs/RFR/RFR_RMarkdown.html  This is 
   the place to start since it is a short tutorial.
2. https://rmarkdown.rstudio.com/index.html This contains a longer 
   tutorial.  Take a look at the cheatsheet in 
   https://rmarkdown.rstudio.com/lesson-15.html, it is a concise 
   reference of R Markdown on two pages.
<-->

## Use this as a template for your homeworks.
#### Rename it to firstname-lastname.Rmd.
#### Run all the chunks by clicking on "Run" at the top right of the edit 
#### window and choose "Run All".  Assuming there were no errors in the
#### chunk, you should see a "Preview" button become visible on the top
#### left of the edit window.  Click this button and a html document should
#### pop up with the output from this R markdown script.

### Part 2.1-A
```{r}
test = read.csv("/Users/nimaysrinivasan/CS-422/Cs-422 Homework 2/us-covid-deaths.csv", header = TRUE)
test1 <- test[complete.cases(test),]
head(test1, 6)
```
### Part 2.1-B.
```{r}
# Correlation plot of the predictors to the response variable.
library(psych)
corelation <- subset(test1, select=c(total_deaths, icu_patients, hosp_patients, stringency_index, reproduction_rate, total_tests, positive_rate))
pairs.panels(corelation)

# Correlation plot of the predictor variables.
corelation1 <- subset(test1, select=c(icu_patients, hosp_patients, stringency_index, reproduction_rate, total_tests, positive_rate))
pairs.panels(corelation1)

### Part 2.1-B.-i

# The response variable total_deaths has the highest positive correlation with total_tests, and the correlation coefficient between these two variables is 0.99.

### Part 2.1-B.-ii

# The response variable total_deaths has the highest negative correlation with stringency_index, and the correlation coefficient between these two variables is -0.66.

### Part 2.1-B.-iii

# In 2.1-B.-i - We find that the total_deaths is highly positively correlated to the total_tests variable (Correlation value=0.99). The total_tests variable is the total tests for covid-19. This correlation can be interpreted as any person who was infected and died due to covid-19 would have taken the covid-19 test. And without confirming whether the person was infected or not a death cannot be attributed to covid-19. Thus we see a highly positive correlation between total tests and total_deaths.

# In 2.1-B.-ii- We find that the total_deaths is highly negatively correlated to the stringency_index variable (Correlation value=-0.66). The stringency_index variable is the restrictions and additional efforts taken by the government in response to the covid-19 outbreak. This can be interpreted as more stringent/strict the government(like school closures, workplace closures, and travel bans) is, the less the number of deaths attributed to covid-19 as this reduces the peoples exposure to the covid-19 strain. Thus we see a highly negative correlation between total tests and stringency_index.   
```

### Part 2.1-C
```{r}
test2 = subset(test1, select = -c(date) )
lmDeaths = lm(total_deaths~ . , data = test2) #Create the linear regression
print(summary(lmDeaths),digits=3)
```

### Part 2.1-D
```{r}
#The above linear regression model in Part 2.1-C is a good fit/good linear regression model. As when we take into consideration the R-squared and th Adjusted R-squared value (R-squared:0.99,Adjusted R-squared:0.99). This value is close to 100% and this represents that the model explains all the variation in the the response variable around its mean thus its a good fit and is a good linear regression model.    
```


### Part 2.1-E
```{r}
# Any variable with the p-value less that 0.05 is statistically significant.The following predictors are statistically significant in the summary of the model as their p-value is less that 0.05.

# . icu_patients       (P-value = 0.00)
# . stringency_index   (P-value = 0.00)
# . reproduction_rate  (P-value < 0.00)
# . total_tests        (P-value < 0.00)
# . positive_rate      (P-value = 0.00)
```

### Part 2.1-F
```{r}
# The variable hosp_patients is the only predictor that is not statistically significant(P-value=0.38). This value is greater that 0.05 and thus it is statistically insignificant.
```

### Part 2.1-G
```{r}
test3 = subset(test2, select = -c(total_tests))
lmDeaths1 = lm(total_deaths~ . , data = test3) #Create the linear regression
print(summary(lmDeaths1),digits=3)

# The predictor that we remove in this model from (b)(i) is total_tests.

# When we compare the model this model to the the model created in (c) we find a few difference, the differences are stated below:
   
#    * We first find that in the new model the estimate for the variable "reproduction_rate" is positive and insignificant(6.24(e+04)) compared to the model in (c) where the estimate was negative and highly significant (-9.91(e+04)***).

#    * We find that in the new model the esitmate for the variable "hosp_patients" is positive and highly significant (1.51(e+01)***) compared to the model in (c) where the estimate was positive but insignificant(1.91(e-01)).

#    * We find that in the new model the esitmate for the variable "stringency_index" is negative and highly significant (-2.05(e+04)***) compared to the model in (c) where the estimate was positive and highly significant (1.55(e+03)***).

#    * We find that in the new model the esitmate for the variable "positive_rate" is negative and highly significant (-6.55(e+06)***) compared to the model in (c) where the estimate was positive and highly significant(9.22(e+05)***).

#    * We find that the estimate for the variable "icu_patients" is negative and highly significant in both the models.          - Estimate value from new model is  (-3.13(e+01)***)
#          - Estimate value from model(c) is   (-6.83(e+00)***)


#    * We then compare the R-squared and th Adjusted R-squared value between the two models 

#       New model : (R-squared:0.672,Adjusted R-squared:0.67)
#       Model from (c) : (R-squared:0.99,Adjusted R-squared:0.99)

#       Based on the above data we find the model in (c) is a better fit compared to the new model. 
#       The difference in the outcomes of the variables in the new model is due to the removal of total_tests.
```


