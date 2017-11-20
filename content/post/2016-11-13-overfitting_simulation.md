---
author: Sebastian Sauer
date: '2016-11-13'
title: Some thoughts (and simulation) on overfitting
tags:
  - stats
  - simulation
  - rstats
slug: overfitting_simulation
---



Overfitting is a common problem in data analysis. Some go as far as saying that "most of" published research is false (John Ionnadis); overfitting being one, maybe central, problem of it. In this post, we explore some aspects on the notion of overfitting.

Assume we have 10 metric variables `v` (personality/health/behavior/gene indicator variables), and, say, 10 variables for splitting up subgroups (aged vs. young, female vs. male, etc.), so 10 dichotomic variables. Further assume there are no association whatsoever between these variables. How likely is it we find something publishable? Apparently quite probably; but let's give it a try.


Load some packages.

```r
library(tidyverse)
library(corrr)
library(broom)
library(htmlTable)
```


# Simulated dataset 10x10
Make sup some uncorrelated data, 10x10 variables each $$N \sim (0,1)$$.

```r
set.seed(123)
matrix(rnorm(100), 10, 10) -> v
```

Let's visualize the correlation matrix.

```r
v %>% correlate %>% rearrange %>% rplot(print_cor = TRUE)
```

![plot of chunk corr_matrix_1](https://sebastiansauer.github.io/images/2016-11-13/corr_matrix_1-1.png)

```r
v %>% correlate -> v_corr_matrix
```

So, quite some music in the bar. Let's look at the distribution of the correlation coefficients.


```r
v_corr_matrix %>% 
  select(-rowname) %>% 
  gather %>% 
  filter(complete.cases(.)) -> v_long
  
v_long %>% 
  mutate(r_binned = cut_width(value, 0.2)) %>% 
  ggplot +
  aes(x = r_binned) + 
  geom_bar()
```

![plot of chunk corr_distrib](https://sebastiansauer.github.io/images/2016-11-13/corr_distrib-1.png)

What about common statistics?


```r
library(psych)
describe(v_long$value)
```

```
##    vars  n  mean   sd median trimmed  mad   min  max range skew kurtosis
## X1    1 90 -0.03 0.36  -0.12   -0.05 0.35 -0.68 0.77  1.44 0.36    -0.68
##      se
## X1 0.04
```

Probably more stringent to just choose one triangle from the matrix, but I think it does not really matter for our purposes.


Quite a bit of substantial correlation going on. Let's look from a different angle.


```r
v_long %>% 
  ggplot +
  aes(x = 1, y = value) +
  geom_violin(alpha = .3) +
  geom_jitter(aes(x = 1, y = value), width = .1) +
  xlab("") +
  geom_hline(yintercept = mean(v_long$value), linetype = "dashed", color = "#880011")
```

![plot of chunk violin_plot](https://sebastiansauer.github.io/images/2016-11-13/violin_plot-1.png)


## 100x100 dataset correlation

Now let's scale up a bit and see whether the pattern stabilize.


```r
set.seed(123)
matrix(rnorm(10^4), 100, 100) -> v2
v2 %>% correlate -> v2_corr_matrix
```


```r
v2_corr_matrix %>% 
  select(-rowname) %>% 
  gather %>% 
  filter(complete.cases(.)) -> v2_long
  
v2_long %>% 
  mutate(r_binned = cut_width(value, 0.2)) %>% 
  ggplot +
  aes(x = r_binned) + 
  geom_bar(aes(y = ..count../sum(..count..))) +
  ylab("proportion")
```

![plot of chunk histo1](https://sebastiansauer.github.io/images/2016-11-13/histo1-1.png)

So, how many r's are in the (0.1,0.3) bin?


```r
library(broom)
v2_long %>% 
  mutate(r_binned = cut_width(value, 0.2)) %>% 
  group_by(r_binned) %>% 
  summarise(n_per_bin = n(),
            prop_per_bin = round(n()/nrow(.), 2))
```

```
## # A tibble: 5 × 3
##      r_binned n_per_bin prop_per_bin
##        <fctr>     <int>        <dbl>
## 1 [-0.5,-0.3]        10         0.00
## 2 (-0.3,-0.1]      1594         0.16
## 3  (-0.1,0.1]      6776         0.68
## 4   (0.1,0.3]      1512         0.15
## 5   (0.3,0.5]         8         0.00
```

That's quite a bit; 15% correlation in the bin (.1.3). Publication ahead!

# Subgroup analyses

Now, let's look at our subgroup. For that purposes, we need actual data, not only the correlation data. Let's come up with 1000 individuals, where he have 100 measurement (metric; N(0,1)), and 100 subgroup variables (dichotomic).


```r
set.seed(123)
matrix(rnorm(1000*100), nrow = 1000, ncol = 100) -> v3
dim(v3)
```

```
## [1] 1000  100
```

```r
matrix(sample(x = c("A", "B"), size = 1000*100, replace = TRUE), ncol = 100, nrow = 1000) -> v4
dim(v4)
```

```
## [1] 1000  100
```

```r
v5 <- cbind(v3, v4)
dim(v5)
```

```
## [1] 1000  200
```

Now, t-test battle. For each variable, compute a t-test; for each subgroup, compute a t-test. Do the whole shabeng (100*100 tests).

But, as a first step, let's look at the first subgroup variable only.

```r
v3 %>% 
  data.frame %>% 
  map(~t.test(.x ~ v4[, 1])) %>% 
  map(broom::tidy) %>% 
  map("p.value") %>% 
  unlist %>%
  tibble -> v3_pvalues

v3_pvalues %>% 
  qplot(x = .) +
  xlab("p value") +
  geom_vline(xintercept = .05, color = "#880011", linetype = "dashed")
```

```
## Don't know how to automatically pick scale for object of type tbl_df/tbl/data.frame. Defaulting to continuous.
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk shabeng_1st](https://sebastiansauer.github.io/images/2016-11-13/shabeng_1st-1.png)

How many significant p values resulted (should be 5%, ie 5 of 100)?


```r
v3_pvalues %>% 
  filter(. < .05)
```

```
## # A tibble: 5 × 1
##            .
##        <dbl>
## 1 0.01350926
## 2 0.04115726
## 3 0.01064116
## 4 0.04251559
## 5 0.02505199
```

Which is exactly what we found.


```r
p_list <- vector(length = 100, mode = "list")
i <- 1

for (i in 1:100){
  
  v3 %>% 
    data.frame %>% 
    map(~t.test(.x ~ v4[, i])) %>% 
    map(broom::tidy) %>% 
    map("p.value") %>% 
    unlist %>%
    tibble -> p_list[[i]]
  
}

# str(p_list)  #tl;dr

p_df <- as.data.frame(p_list)
names(p_df) <- paste("V", formatC(1:100, width = 3, flag = "0"), sep = "")
```

Let's try a giant plot with 100 small multiples.


```r
p_df %>% 
  gather %>% 
  ggplot(aes(x = value)) + 
  geom_histogram() +
  facet_wrap(~key, ncol = 10)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk giant_plot](https://sebastiansauer.github.io/images/2016-11-13/giant_plot-1.png)



Well impressive, but that histogram matrix does not serve much. What about a correlation plot as above, only giantesque...


```r
p_df %>% correlate %>% rplot
```

![plot of chunk corr_plot_giant](https://sebastiansauer.github.io/images/2016-11-13/corr_plot_giant-1.png)


Hm, of artis values (in 10000 years). Maybe better plot a histogram of the number of signifinat p-values ( <. 05).


```r
p_df %>% 
  gather %>% 
  dplyr::filter(value < .05) %>% 
  qplot(x = value, data = .) +
  xlab("p value")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk hist3](https://sebastiansauer.github.io/images/2016-11-13/hist3-1.png)


In exact numbers, what's the percentage of significant p-values per variable?


```r
p_df %>% 
  gather %>% 
  group_by(key) %>% 
  filter(value < .05) %>% 
  summarise(n = n()) -> p_significant
```



```r
htmlTable(p_significant)
```

<table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>key</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>n</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>V001</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>V002</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>V003</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>V004</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>V005</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>V006</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>V007</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>V008</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>V009</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>10</td>
<td style='text-align: center;'>V010</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>11</td>
<td style='text-align: center;'>V011</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>12</td>
<td style='text-align: center;'>V012</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>13</td>
<td style='text-align: center;'>V013</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>14</td>
<td style='text-align: center;'>V014</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>15</td>
<td style='text-align: center;'>V015</td>
<td style='text-align: center;'>13</td>
</tr>
<tr>
<td style='text-align: left;'>16</td>
<td style='text-align: center;'>V016</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>17</td>
<td style='text-align: center;'>V017</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>18</td>
<td style='text-align: center;'>V018</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>19</td>
<td style='text-align: center;'>V019</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>20</td>
<td style='text-align: center;'>V020</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>21</td>
<td style='text-align: center;'>V021</td>
<td style='text-align: center;'>10</td>
</tr>
<tr>
<td style='text-align: left;'>22</td>
<td style='text-align: center;'>V022</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>23</td>
<td style='text-align: center;'>V023</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>24</td>
<td style='text-align: center;'>V024</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>25</td>
<td style='text-align: center;'>V025</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>26</td>
<td style='text-align: center;'>V026</td>
<td style='text-align: center;'>9</td>
</tr>
<tr>
<td style='text-align: left;'>27</td>
<td style='text-align: center;'>V027</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>28</td>
<td style='text-align: center;'>V028</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>29</td>
<td style='text-align: center;'>V029</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>30</td>
<td style='text-align: center;'>V030</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>31</td>
<td style='text-align: center;'>V031</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>32</td>
<td style='text-align: center;'>V032</td>
<td style='text-align: center;'>9</td>
</tr>
<tr>
<td style='text-align: left;'>33</td>
<td style='text-align: center;'>V033</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>34</td>
<td style='text-align: center;'>V034</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>35</td>
<td style='text-align: center;'>V035</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>36</td>
<td style='text-align: center;'>V036</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>37</td>
<td style='text-align: center;'>V037</td>
<td style='text-align: center;'>11</td>
</tr>
<tr>
<td style='text-align: left;'>38</td>
<td style='text-align: center;'>V038</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>39</td>
<td style='text-align: center;'>V039</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>40</td>
<td style='text-align: center;'>V040</td>
<td style='text-align: center;'>10</td>
</tr>
<tr>
<td style='text-align: left;'>41</td>
<td style='text-align: center;'>V041</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>42</td>
<td style='text-align: center;'>V042</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>43</td>
<td style='text-align: center;'>V043</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>44</td>
<td style='text-align: center;'>V044</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>45</td>
<td style='text-align: center;'>V045</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>46</td>
<td style='text-align: center;'>V046</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>47</td>
<td style='text-align: center;'>V047</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>48</td>
<td style='text-align: center;'>V048</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>49</td>
<td style='text-align: center;'>V049</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>50</td>
<td style='text-align: center;'>V050</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>51</td>
<td style='text-align: center;'>V051</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>52</td>
<td style='text-align: center;'>V052</td>
<td style='text-align: center;'>10</td>
</tr>
<tr>
<td style='text-align: left;'>53</td>
<td style='text-align: center;'>V053</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>54</td>
<td style='text-align: center;'>V054</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>55</td>
<td style='text-align: center;'>V055</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>56</td>
<td style='text-align: center;'>V056</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>57</td>
<td style='text-align: center;'>V057</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>58</td>
<td style='text-align: center;'>V058</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>59</td>
<td style='text-align: center;'>V059</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>60</td>
<td style='text-align: center;'>V060</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>61</td>
<td style='text-align: center;'>V062</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>62</td>
<td style='text-align: center;'>V063</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>63</td>
<td style='text-align: center;'>V064</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>64</td>
<td style='text-align: center;'>V065</td>
<td style='text-align: center;'>12</td>
</tr>
<tr>
<td style='text-align: left;'>65</td>
<td style='text-align: center;'>V066</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>66</td>
<td style='text-align: center;'>V067</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>67</td>
<td style='text-align: center;'>V068</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>68</td>
<td style='text-align: center;'>V069</td>
<td style='text-align: center;'>9</td>
</tr>
<tr>
<td style='text-align: left;'>69</td>
<td style='text-align: center;'>V070</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>70</td>
<td style='text-align: center;'>V071</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>71</td>
<td style='text-align: center;'>V072</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>72</td>
<td style='text-align: center;'>V073</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>73</td>
<td style='text-align: center;'>V074</td>
<td style='text-align: center;'>8</td>
</tr>
<tr>
<td style='text-align: left;'>74</td>
<td style='text-align: center;'>V075</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>75</td>
<td style='text-align: center;'>V076</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>76</td>
<td style='text-align: center;'>V077</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>77</td>
<td style='text-align: center;'>V078</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>78</td>
<td style='text-align: center;'>V079</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>79</td>
<td style='text-align: center;'>V080</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>80</td>
<td style='text-align: center;'>V081</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>81</td>
<td style='text-align: center;'>V082</td>
<td style='text-align: center;'>9</td>
</tr>
<tr>
<td style='text-align: left;'>82</td>
<td style='text-align: center;'>V083</td>
<td style='text-align: center;'>12</td>
</tr>
<tr>
<td style='text-align: left;'>83</td>
<td style='text-align: center;'>V084</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>84</td>
<td style='text-align: center;'>V085</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>85</td>
<td style='text-align: center;'>V086</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>86</td>
<td style='text-align: center;'>V087</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>87</td>
<td style='text-align: center;'>V088</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>88</td>
<td style='text-align: center;'>V089</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>89</td>
<td style='text-align: center;'>V090</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>90</td>
<td style='text-align: center;'>V091</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>91</td>
<td style='text-align: center;'>V092</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>92</td>
<td style='text-align: center;'>V093</td>
<td style='text-align: center;'>4</td>
</tr>
<tr>
<td style='text-align: left;'>93</td>
<td style='text-align: center;'>V094</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='text-align: left;'>94</td>
<td style='text-align: center;'>V095</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>95</td>
<td style='text-align: center;'>V096</td>
<td style='text-align: center;'>10</td>
</tr>
<tr>
<td style='text-align: left;'>96</td>
<td style='text-align: center;'>V097</td>
<td style='text-align: center;'>7</td>
</tr>
<tr>
<td style='text-align: left;'>97</td>
<td style='text-align: center;'>V098</td>
<td style='text-align: center;'>6</td>
</tr>
<tr>
<td style='text-align: left;'>98</td>
<td style='text-align: center;'>V099</td>
<td style='text-align: center;'>5</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>99</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>V100</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>2</td>
</tr>
</tbody>
</table>


Distribution of significant p-values.

```r
p_significant %>% 
  qplot(x = n, data = .)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![plot of chunk histo_p_values](https://sebastiansauer.github.io/images/2016-11-13/histo_p_values-1.png)


Summary stats of significant p-values.


```r
p_df %>% 
  gather %>% 
  group_by(key) %>% 
  filter(value < .05) %>% 
  summarise(n_p = n(),
            mean_p = mean(value),
            median_p = median(value),
            sd_p = sd(value, na.rm = TRUE),
            IQP_p = IQR(value),
            min_p = min(value),
            max_p = max(value)) %>% 
  map(mean) %>% as.data.frame -> p_summary_tab
```

```
## Warning in mean.default(.x[[i]], ...): argument is not numeric or logical:
## returning NA
```

Here comes the table of the *mean* over all 100 variables of the typical statistics.


```r
p_summary_tab %>% 
  select_if(is.numeric) %>% 
  round %>% 
  htmlTable
```

<table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>key</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>n_p</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>mean_p</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>median_p</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>sd_p</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>IQP_p</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>min_p</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>max_p</th>
</tr>
</thead>
<tbody>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>1</td>
<td style='border-bottom: 2px solid grey; text-align: center;'></td>
<td style='border-bottom: 2px solid grey; text-align: center;'>6</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0</td>
<td style='border-bottom: 2px solid grey; text-align: center;'></td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0</td>
</tr>
</tbody>
</table>

In sum, overfitting - mistakenly taking noise as signal - happened often. Actually, as often as is expected by theory. But, not knowing or not minding theory, one can easily be surprised by the plethora of "interesting findings" in the data. In John Tukey's words (more or less): "Torture the data for a long enough time and it will tell you anything".
