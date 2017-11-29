---
author: Sebastian Sauer
date: '2016-10-05'
title: 'Simple (R-)Markdown template for ''Onepager-reports'' etc. '
tags:
  - markdown
slug: template-onepager
---



In my role as a teacher, I (have to) write a lot of marking feedback reports. My university provides a website to facilitate the process, that's great. I have also been writing my reports with Pages, Word, or friends. But somewhat cooler, more attractive, and more reproducible would be using (a markup language such as) Markdown. Basically, that's easy, but it would be of help to have a template that makes up a nice and nicely formatted report, like this:

![](/images/2016-10-05/Gutachten_Boilerplate.jpg)

Download this pdf file [here](/download/Gutachten_Boilerplate.pdf). Here is the [source file](/download/Gutachten_Boilerplate.Rmd). Credit goes to the [Pandoc](http://pandoc.org) team; I based my template on their's.

So how to do it?

First and foremorst, write your report using [Markdown](https://daringfireball.net/projects/markdown/), and convert it to HTML oder Latex-PDF using [Pandoc](http://pandoc.org). [Rstudio](https://www.rstudio.com) provides nice introduction, eg., [here](http://rmarkdown.rstudio.com/lesson-1.html) or [here](https://blog.rstudio.org/2014/06/18/r-markdown-v2/).

Next, tell your Markdown document to use your individual stylesheet, i.e, template. Note that I focus here on PDF output.


```
---
subtitle: "A general theory ..."
title: "Feedback report to the assignment"
output:
  pdf_document:
    template: template_feedback.latex   
---

```




You have to put that bit above in the [YAML header](http://rmarkdown.rstudio.com/html_document_format.html) of your markdown document (right at the top of your document), see the [source file](/download/Gutachten_Boilerplate.Rmd) for details. And then, you just write your Markdown report in plain English (or whatever language...).

However, where the music actually plays is the [latex template](/download/template_feedback.latex), which is being used in the Markdown document (via the YAML header). The idea is that in the Latex file, we define some variables (such as "author" or "title") which then can be used in the markdown file. Markdown, that is YAML, is able to address those variables defined in the Latex template. In this example, the variables defined include:

- author
- title
- subtitle
- "thanks to" (I use this field as some "freeride" variable)
- date



The body (main part) of the onepage example above basically looks like this:


```

# Obedience to the teacher
- Lorem ipsum dolor sit amet, consetetur sadipscing elitr, 
- sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, 
- sed diam voluptua. 
...


# Statistical abuses
- Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
...


# Contribution to meaning of live
- Lorem ipsum dolor sit amet, consetetur sadipscing elitr, 
(...)

```


En plus, the style sheet - being based on Pandoc's stylesheet - allows for quite a number of more format-based adjustments such as language, geometry of the paper, section-numbering etc. See the excellent Pandoc help for details.

Enjoy!






