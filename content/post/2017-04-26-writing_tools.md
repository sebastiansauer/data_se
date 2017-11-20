---
author: Sebastian Sauer
date: '2017-04-26'
title: Tools for Academic Writing - Comparison
tags:
  - writing
  - reproducibility
slug: writing_tools
---




Many tools exist for academic writing including the notorious W.O.R.D.; but many more are out there. Let's have a look at those tools, and discuss what's important (what we expect the tool to deliver, eg., beautiful typesetting).


# Typical tools for academic writing

- *MS Word*: A "classical" choice, relied upon by myriads of white collar workers... I myself have used it extensively for academic writing; the main advantage being its simplicity, that is, well, everybody knows it, and knows more or less how to handle it. It's widespread use is of course an advantage.

- TeX: The purist's choice. The learning curve can be steep, but its beauty and elegance of typesetting if unreached.

- *Overleaf*, *Authorea*: Web-based apps that make it easy to enjoy modern functionality by making the entry hurdle as low as possible. These riches do not come for free; commercial organizations would like to see some return of investment.

- *Full*: With the "full" approach I refer to a blended version of several tools, mainly:
    - R
    - RStudio
    - RMarkdown (ie., knitr + markdown + pandoc)
    - Git + Github
    - stylesheets such as [papaja](https://github.com/crsh/papaja) (APA6 stylesheet)
  
- *Markdown*: Markdown is a simple variant of markup languages such as HTLM or LaTeX. Its marked feature is its simplicity. In fact, it can be learned in 5 minutes (whereas TeX may need 5-50 years, some say...).

- *Google Docs*: Easy, no (direct) costs, comfortable, but some features are lacking - There's no easy for citations. In addition, some say intellectual rights are transferred to Google by using G Docs (I have no clue whether that's true).


# Tool comparison table


```r
libs <- c("readr", "tidyverse", "pander", "emo", "htmlTable")
pacman::p_load(char = libs)
```



```r
tools <- read_csv("academic_writing_tools_competition.csv")
```






```r
htmlTable(df)
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Criterion</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Word</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Tex</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Overleaf_Authorea</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Full</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Markdown</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>G_Docs</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>Beautiful typesetting</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>Different output formats</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>Citations</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>Integrate R</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>Version control</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>Reproducibility of writing</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>Collaboration</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>Simplicity</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>Style sheets (eg., APA)</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>10</td>
<td style='text-align: center;'>Stability</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>11</td>
<td style='text-align: center;'>Open code</td>
<td style='text-align: center;'>1</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>2</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>3</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>12</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>Option for private writing</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>3</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>3</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>1</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>3</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>3</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>3</td>
</tr>
</tbody>
</table><!--/html_preserve-->


# Criterion weight

Let's assume we have some weights that we assign to the critera:

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Criterion</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Weight</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>Beautiful typesetting</td>
<td style='text-align: center;'>1</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>Different output formats</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>Citations</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>Integrate R</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>Version control</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>Reproducibility of writing</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>Collaboration</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>Simplicity</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>Style sheets (eg., APA)</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='text-align: left;'>10</td>
<td style='text-align: center;'>Stability</td>
<td style='text-align: center;'>3</td>
</tr>
<tr>
<td style='text-align: left;'>11</td>
<td style='text-align: center;'>Open code</td>
<td style='text-align: center;'>2</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>12</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>Option for private writing</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>2</td>
</tr>
</tbody>
</table><!--/html_preserve-->


# Scores by tool

So we are able to devise a score or a ranking.

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>tool_name</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>score</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>Full</td>
<td style='text-align: center;'>69</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>Overleaf_Authorea</td>
<td style='text-align: center;'>61</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>Tex</td>
<td style='text-align: center;'>58</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>Markdown</td>
<td style='text-align: center;'>54</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>G_Docs</td>
<td style='text-align: center;'>47</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>6</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>Word</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>41</td>
</tr>
</tbody>
</table><!--/html_preserve-->



```r
score %>% ggplot + aes(x = reorder(tool_name, score), y = score) + 
    geom_point() + coord_flip() + xlab("tool")
```

<img src="https://sebastiansauer.github.io/images/2017-04-26/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="70%" style="display: block; margin: auto;" />


# And the winner is...

**The full approach**. The full approach gets most points (disclaimer: well, I designed this competition, and I like this approach 😄.


# Getting started


There are numerous tutorial on "the full approach" out there, .eg.

- [RMarkdown materials from RStudio](http://rmarkdown.rstudio.com)
- Christopher Gandrud's book [Reproducible Research with R and RStudio Second Edition](https://englianhu.files.wordpress.com/2016/01/reproducible-research-with-r-and-studio-2nd-edition.pdf) - free pdf full text
- Also by the same author [Reproducible Research with R and R Studio](https://books.google.de/books/about/Reproducible_Research_with_R_and_R_Studi.html?id=u-nuzKGvoZwC&source=kp_cover&redir_esc=y) 
- Find [here](https://www.practicereproducibleresearch.org/case-studies/barbera.html) some case studies on reproducible research.

