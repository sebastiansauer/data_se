---
author: Sebastian Sauer
date: '2016-12-08'
title: Some thoughts on 'Dear stats curriculum developers'
tags:
  - stats
  - teaching
slug: stats_curriculum
---




Recently, Andrew Gelman (@StatModeling at Twitter) published a post with [this title](http://andrewgelman.com/2016/12/07/dear-major-academic-publisher/) - "“Dear Major Textbook Publisher”: A Rant".

In essence, he discussed how a good stats intro text book should be like. And complained about the low quality of ~~some~~ many textbooks out there.

As I am also ~~in the business~~ guilty of coming up with stats curriculum for my students (applied courses for business type students mostly), I discuss some thoughts for "stats curriculum developers" (like myself).


Of course, the [GAISE report](http://www.amstat.org/asa/education/Guidelines-for-Assessment-and-Instruction-in-Statistics-Education-Reports.aspx) provides an authoritative overview on what is considered helpful (by the ASA and by many others). My compilation builds on that but adds/drops some points.


# Principles in stats curriculum

- *statistical thinking above anything else*.  What is statistics all about? Get a bunch of data, see the essence (some summary, often). But wait, there is variability, stuff  comes in different shades of grey. How certain (or rather *un*certain) are we about some hypothesis? Ah, that's why probability comes into play. My grand grandpa did smoke, loved his beer, and see, turned 94 recently, and you keep telling me that would not be enough to "demonstrate".... Ah, OK... What does statistics say about causality? (not much, to my mind.) This commitment implies that procedural know-how need be downgraded (we cannot have the cake and eat it).
  
- *Problem solving*.  Give students some dataset, some question, and let them investigate. Discuss, refine, correct their actions. Explain *afterwards* better ways (I heard this was called inductive learning).
  
- *Real data, real problems*.  Don't stay with urns and coin tosses, fine as a starter, but then go on to real data, and real problems. For example, I used extraversion and number of Facebook friends as a running example; based on the data students gave to this survey. So they analyzed their own data. If you want to make use of the data: you are welcome, [here](https://osf.io/4kgzh/) it is (free as in free).
  
- *A lot of 'guide at your side' (activation)*.  Rather then 'sage on stage'. However, I found that surprisingly many students appear overwhelmed if the "activation dose" gets too strong. So I try to balance the time when I speak, students work on their own or when they work in groups. Honestly, what's the advantage of listening to me in person compared to watching a Youtube video? OK, at times, I may respond (Youtube not so much), but the real benefit would be joint problem solving. So let's do that.
  
- *Technology (R)*.  Computers are already ubiquitous, and penetrating even more in everyday life. So we as teachers should not dream of the "good old days" where we solved triple integrals with formulas as wide as my arm span (I never did). Future is likely to dominated by computers when it comes to our working style or working tools. So let's use them and show them how to code. A bit, at least (many are frightened though initially). R is a great environment for that purpose.
  
- *Ongoing selfassessment*.  Cognitive and educational psychology points out that frequent assessment helps a lot to learn some stuff [citation missing]. So let's give the students ongoing feedback. For example, what I do is I use a Google form with quiz feature for that purpose. Minimal preparation from my side for tomorrow's class, because that's all pre-prepared.
  
  
- *Focus on/start with intuition*.  Don't start by throwing some strange (\LaTeX typeset, of course) equation in the students' faces (unless you are teaching in some math heavy fields, but not in business). Start by explaining the essence in simple words, and giving an intuition. For example, variance can be depicted as (something like) "average deviation sticks"; correlation as "average deviation rectangles" (see [this post](https://sebastiansauer.github.io/correlation-intuition/)). When the essence is understood, refine. Now come your long equations. [This post](https://betterexplained.com/articles/proofs-vs-explanations/) speaks of a refinement process from "sorta-true" to very true. Quite true.
  
- *Be nice*.  I think there is no point in being overly austere; surely you must be joking, Mr. Feynman. Even stats classes can be fun... Personally, I find [Andy Field's](http://www.statisticshell.com) tone in his [textbook](https://uk.sagepub.com/en-gb/eur/discovering-statistics-using-r/book236067%20) quite refreshing. 
  
  
# Aims of a stats curriculum
If your class belongs to a business type of field, don't expect they all will turn to science as a career now. More realistically, they will have to face some stats questions in their working live. Two things may happen then. 

First, they hire someone who really knows what to do (at least, someone who thinks so). Then your students of today need be prepared to speak to that expert. They need enough understanding to get the gist of the experts strategy. They need be able to ask some good questions. But the clearly do not need to understand many details, if any. 

Second scenario. The future ego of your today-student will by her or himself do some stats problem solving. I think even our applied business students should have some working knowledge, maybe on regression plus some Random Forests, based on some general ideas plus visualization and data wrangling.

In sum, critical understanding is the first and some partial, locally constrained actionable know-how is second.
  
  
  
# Content

Some thought blobs.

- *Descriptive stats*  can be paired with some cool visualization. I like `qplot` from `ggplot2` because it is easy start, but allows to combine different steps, which fosters creative problem solving (I hope). 

- *Data wrangling*.  `dplyr` is great because with ~5 functions you can rule them all see [here](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html) for an intro. This is, a couple of easy functions, such as `filter`, `summarise`, or `count` do the bulk of typical data preparation tasks (yes, these functions pretty much do what their name suggests).

- *wee p*,  I tend(ed) to focus on this point in class, not because I love it, but because it is still the way papers are built. So students need to understand it. And it is not easy to comprehend. If they do not understand, how can the new generation overcome the problems of the past. I try to lay bare the problems of the p-value (mainly that it is not the answer we need).

- *Bayes*.  It is (probably) too strong to state that without understanding Bayes, one cannot understand the p-value. But understanding posterior probabilities is a relief, as the p-value can now be accepted as what it is: some conditional probability (of some data given some hypothesis). Bayes puts p into context. But Bayes, I fear -- not being deeply based in Bayes -- can necessitate a lot of ground work, time consuming fundamentals, if you really want some working knowledge. That's why I, for the moment at least, take some shortcut, and present only the basic concept, alongside, maybe, some off-the-shelf software such as [JASP](https://jasp-stats.org).

- *Basic statistical learning ideas*.  Overfitting is an essential concept; it should be grasped. There are a number of similarly important points (particularly resampling, cross-validation, and bias-variance trade-off, for example); the book [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) is of great help here.

- *Algorithmic methods*, in the sense of [Breiman's two cultures](http://www.stat.uchicago.edu/~lekheng/courses/191f09/breiman.pdf). One particular nice candidate here are tree-based methods, including notorious Random Forests. Conceptually easy yet high predictive performance in some situations.

- *Text mining*. 90% of all is something, I mean, 90% of all information is unstructured, mostly image and text, some say. So let's look at that. That's fun, not yet so much looked at, and for business students of some relevance. [Julia Silge's and David Robinsons's book](http://tidytextmining.com) on Textmining appears great (and vast, for that matter).

- *Repro crisis*. Let's not be silent about the problems we face in Science. True, there are great challenges, but hey, what we need is not less, but more science. A good dose of open science can and should be plugged in here.


# Byebye Powerpoint
In my experience, it can be difficult by bypass PowerPoint, even when you are preparing a curriculum. In my university, several teachers may/are encouraged to make use of your stuff, and they may/will utterly complain if you do not use PowerPoint (Keynote as a surrogate is not a solution).

But for the next curriculum, my plan is to use [RMarkdown](http://rmarkdown.rstudio.com) to write a real scriptum, not only slides. That will be lots of work. But then it will be easy to come up with lean slides, without much text, because there will be the script for the details. Then, slides, can be used what they are intended for: convey one idea per slide, no or little text, primarily consisting of graphics or schema. The slides can be prepared using RMarkdown, too. RMarkdown is not particularly fit for that purpose, though. I mean, you will not have the full features of PPT, and not the ease. But you will not need it. Simple slides can very well be made using RMarkdown. Once there is a real "mini-book", aka script, no detailed slides are needed any more. 

Git and friends can then be used for version control, collaboration, and so on... 

However, a lot of colleagues will complain, I fear. Let's see. I hope to convince them that this is a far better way. Bye bye PowerPoint.


# Conclusions

All that here are some quick thoughts in progress. They are more to make up my mind, and to stimulate your thinking. I believe all that written here, but I am sure, I missed a lot and made a number of mistakes. Let me know your thoughts!


# Acknowledgements

I learnt a lot, both statistically as well as didactically, from my colleague Karsten Luebke, whose thoughts also went into this post.
