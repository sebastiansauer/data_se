---
author: Sebastian Sauer
date: '2016-08-17'
title: Introduction to the measurement theory, and conjoint measurement theory
tags:
  - stats
  - measurement
slug: intro_measurement
---



What is measurement? Why should I care? 

Measurement is a basis of an empirical science. Image a geometer (a person measuring distances on the earth) with a metering rul made of rubber! Poor guy! Without proper measurement, even the smartest theory cannot be expected to be found, precisely because it cannot be measured.

So, what exactly is measurement? Measurement can be seen as tying numbers to empirical objects. But not in some arbritrary style. Measurement is achieved, if and only if the relations found in the empirical objects do also hold in the numbers. What does that mean? Suppose you have three rods: A, B and C. You hold them next to each other and find that A is longer than B and B longer than C. So you are entitled to give whatever numbers to the rods as long as the number of rod A is *greater* than the number of rod B, which in turn must be greater than the number assigned to rod C; in short: l(A) > l(B) > l(C), where `l` is the length of the rod. It goes without saying that if l(A) > l(B), and l(B) > l(C), then it must hold that l(A) > l(C) (transitivity). Given these relations hold for all objects, we have achieved something like an *ordinal scale*.

To establish a quantitative variable, we need to find additive relations. For example, suppose the length of A equals the length of B and C, concatenated next to each other; more formally l(A) = l(B) #+# l(C), where #+# means "concatenated next to each other". So, if the rods add up, the numbers should, too. You are free to assign any numbers to the lengths of the rods, as long as the numbers add up (and satisfy order). Now we have established a quantitative measurement. 

This is very straight forward, an easy process. This idea or method for checking whether a variable can be deemed quantitative has been dubbed *extensive measurement*. Note that even length is the typical example, there are things in physics which cannot be measured this way (e.g., temperature).

For psychology and related fields, the situation is even worse. How can I say, hey, intelligence of person A concatenated to intelligence of B equals intelligence of person C? Hardly possible. We need to find some other way.

Note that it is no automatism that a variable is quantitative, not even ordinal structures can be taken for granted. Take beauty as an example. Can beauty be measured at ordinal level? Is it even quantitative? What happens if I prefer Anna over Berta, and Berta over Carla, but then insist that Carla is prettier than Anna!? (Thereby violating transitivity)

A maybe more familiar example for psychologists are Likert scales ("I fully agree ... I do not agree at all"). Normally, they are bona fide taken as quantitative. For simplicity, let's focus on dichotomous items (two answer options). If I answer in the affirmative to item A, but not B, and you do it the other way round (say no to B, but yes to A) -- should our latent score be considered equal? If I "solve" two items, you "solve" one, is my latent score than higher than yours ("solving" means here agreeing to)? Not necessarily. It need be tested before we can confidently assert so. Such questions deal with the ordinal structure of the variable. 

The quantitative level is even more intricate. For interval level we need to be able to say that the differences sum up, as we have seen above for length measurement. Is the difference (in extraversion, say) between individuals A and B plus the difference between C and D equal the difference between E and F? This is not easy to investigate. However, in the 1960, two researchers come up with a theory to deal with this problem: the [theory of conjoint measurement](https://en.wikipedia.org/wiki/Theory_of_conjoint_measurement).

