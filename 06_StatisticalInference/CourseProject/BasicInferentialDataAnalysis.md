---
title: "The Effect of Vitamin C on Tooth Growth in Guinea Pigs"
author: "Paolo Saracco"
date: "2024-03-21"
output:
        bookdown::html_document2:
                fig_caption: true
                toc: true
                toc_depth: 2
                toc_float: 
                        collapsed: true
                number_sections: false
                keep_md: true
---

# Synopsis

Based on the `ToothGrowth` data from the R `datasets` package, we analyze
the effect of vitamin C on the length of odontoblasts in guinea pigs. We want 
to study whether the amount of vitamin C or the method it is delivered to 
guinea pigs affect the length of the odontoblasts. We conjecture that they do.

# Data 

The dataset contains the length of odontoblasts (cells responsible for tooth
growth) in 60 guinea pigs that received different doses of vitamin C by 
different methods. Each animal received one of three dose levels of
vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods, orange juice 
or ascorbic acid (a form of vitamin C and coded as VC).


```r
set.seed(0);
data("ToothGrowth");
```

### Packages

The following packages will be used to perform the analysis.


```r
library(dplyr);
library(ggplot2);
```

# Exploratory analysis

We start by having a look at the size of our data set: 
dim = 60 x 3.
Hence we have, as expected, 3 observations for 
60 subjects. Let us have a look at the head, the tail and the structure of our data


```
##    len supp dose
## 1  4.2   VC  0.5
## 2 11.5   VC  0.5
## 3  7.3   VC  0.5
## 4  5.8   VC  0.5
## 5  6.4   VC  0.5
## 6 10.0   VC  0.5
```

```
##     len supp dose
## 55 24.8   OJ    2
## 56 30.9   OJ    2
## 57 26.4   OJ    2
## 58 27.3   OJ    2
## 59 29.4   OJ    2
## 60 23.0   OJ    2
```

```
## 'data.frame':	60 obs. of  3 variables:
##  $ len : num  4.2 11.5 7.3 5.8 6.4 10 11.2 11.2 5.2 7 ...
##  $ supp: Factor w/ 2 levels "OJ","VC": 2 2 2 2 2 2 2 2 2 2 ...
##  $ dose: num  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
```

respectively. The dataset is already clean and we may provide a basic summary of the data:


```
##       len        supp         dose      
##  Min.   : 4.20   OJ:30   Min.   :0.500  
##  1st Qu.:13.07   VC:30   1st Qu.:0.500  
##  Median :19.25           Median :1.000  
##  Mean   :18.81           Mean   :1.167  
##  3rd Qu.:25.27           3rd Qu.:2.000  
##  Max.   :33.90           Max.   :2.000
```

By keeping in mind our working questions, we can also have a quick look at 
potential correlations:

<img src="BasicInferentialDataAnalysis_files/figure-html/pairplot-1.png" style="display: block; margin: auto;" />

Apparently, the dose level has a clear effect, while we cannot draw conclusions
about the delivery method, yet. Two boxplots, one by dose level and one by 
delivery method, confirm the effect of dose level and suggest a possible effect 
of delivery method:

<img src="BasicInferentialDataAnalysis_files/figure-html/boxplot-1.png" style="display: block; margin: auto;" />

# Hypothesis tests

In view of the relative small size of samples and under the reasonable 
hypothesis that the underlying data are iid Gaussian, we are going to perform 
two group T tests for equality of means.

### Compare tooth growth by dose level

Our first hypothesis is that a higher dose level of vitamin C leads to a 
higher length of odontoblasts. To support this hypothesis we compare level 
1 with level 0.5 and level 2 with level 1, the null hypothesis always being 
that there is no significant difference in the means and the alternative
being that a higher level of vitamin C entails a longer length of odontoblasts.

First we split the three groups according to the rule 

- group 1: dose level = 0.5 mg/day,
- group 2: dose level = 1 mg/day,
- group 3: dose level = 2 mg/day

and we compute their sample means:


```
## grp1.len grp2.len grp3.len 
##   10.605   19.735   26.100
```

Then we perform a T test to check whether there is a significant difference 
between the means at level \(\alpha = 0.05\). If we compare group 2 (dose 
level = 1 mg/day) with group 1 (dose level = 0.5 mg/day):


```r
t.test(grp2, grp1, alternative = "greater")$p.value
```

```
## [1] 6.341504e-08
```

We can reject the null hypothesis that the two means coincide, since the 
p-value is much smaller than 0.05. Similarly, if we compare group 3 (dose 
level = 2 mg/day) with group 2 (dose level = 1 mg/day):


```r
t.test(grp3, grp2, alternative = "greater")$p.value
```

```
## [1] 9.532148e-06
```

then we can reject the null hypothesis of equal means, since the p-value is much 
smaller than 0.05. There is no need, in this case, to test group 3 versus 
group 1.

Therefore, we conclude that a higher level of vitamin C is correlated with a 
longer length of the odontoblasts at level 0.05.

For the sake of clarity, we can also compute two-sided 95% T confidence 
intervals for the means using the `conf.int` component of `t.test`:


```
##              min      max
## grp1mn  8.499046 12.71095
## grp2mn 17.668512 21.80149
## grp3mn 24.333643 27.86636
```

Comparing the computed means (ref:splitDose) with the confidence intervals 
we computed, we can confirm that we may safely reject the null hypotheses at 
level 0.05.

### Compare tooth growth by delivery method

Our second hypothesis is that also the delivery method is correlated with 
tooth growth. Namely, that subjects that received vitamin C with orange juice 
has longer odontoblasts.

Let us begin by separating the two groups, OJ versus VC, and by computing 
the respective sample means:


```
##   OJ.len   VC.len 
## 20.66333 16.96333
```

Then we perform a T test to check whether there is a significant difference 
between the means at level \(\alpha = 0.05\). If we compare the OJ group with 
the VC group:


```r
t.test(suppOJ,suppVC,alternative = "greater")$p.value
```

```
## [1] 0.03031725
```

then we can reject the null hypothesis of equal means at level 0.05, because 
the p-value is slightly smaller.

We conclude that there can be a relationship between the delivery method and 
the length of the odontoblasts. Namely, subjects which received vitamin C via 
orange juice have, on average, longer odontoblasts than those who received it 
via ascorbic acid.
