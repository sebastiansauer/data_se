---
author: Sebastian Sauer
date: '2016-07-05'
title: How to add a logo to a slidify presentation
tags:
  - markdown
slug: slidify-logo
---

*reading time: 15-20 min.*

Slidify is a cool tool to render HTML5 slide decks, see [here](http://slidify.org/samples/intro/#1), [here](http://ramnathv.github.io/slidifyExamples/examples/io2012/#1) or [here](http://sebastiansauer.github.io/dplyr_WS/#1) for examples.

Features include:

- reproducibility. You write your slide deck as you would write any other text, similar to Latex/Beamer. But you write using Markdown, which is easier and less clumsy. As you write plain text, you are free to use git.
- modern look. Just a website, nothing more. But with cool, modern features.
- techiwecki. Well, probably techie-minded persons will love that more than non-techies...
Check [this tutorial](http://slidify.github.io/) out as a starter.

Basically, slidify procudes a website:

![]({{ site.url }}/images/slidify.png)

While it is quite straight forward to write up your slidify presentations, some customization is a bit more of a hassle.

Let's assume you would like to include a logo to your presentation. How to do that?

## Logo page

There is an easy solution: In your slidify main file (probably something like index.Rmd) you will find the YAML header right at the start of the file:


```
---
title : "Test with Logo"
author : "Dr. Zack"
widgets : [mathjax, quiz, bootstrap, interactive] # {mathjax, quiz, bootstrap}
ext_widgets : {rCharts: [libraries/nvd3, libraries/leaflet, libraries/dygraphs]}
mode : selfcontained # {standalone, draft}
logo : logo.png
biglogo : logo.png
---
```


 

To get your logo page, do the following two steps:


1. In your project folder, go to assets/img. Drop your logo file there (png and jpg will both work)
2. Then adjust your YAML header by adding two lines:



```
logo : logo.png
biglogo : logo.png
```

Done!

Two changes will now take place. First, you will have a logo page, where nothing but your logo will show up (biglogo.png):

![]({{ site.url }}/images/logo_page.png)

Second, a following page, the title page, will also show you logo (logo.png), but smaller and with a little animation (in the default):

![]({{ site.url }}/images/logo_page2.png)

Note that there are a number of other variables that you can define in the YAML header.

Background image on title page

Now, a little more fancy. What about a cool background image on your first page? OK, let's check it out. This will be the output:

 

![]({{ site.url }}/images/title_bg_pic.png)

So what did I do?

I defined a CSS class as follows:



```css
.title-slide {
 background-image: url(https://goo.gl/gAeQqj);
}
```



The picture is from [WikiMedia Commons](https://commons.wikimedia.org/wiki/Main_Page#/media/File:Pluto-01_Stern_03_Pluto_Color_TXT.jpg), published in the public domain.

Then, I saved this code as a `css` file (name does not matter; in my case title_slide_bg.css) in this folder:

`[project_folder]/assets/css`.

That's it. Wait, don't forget to `slidify("my_deck")`.

You will say, that's ok, but I want a footer or a header line, because that's where I like to put my logo (accustomed to...).

## Footer/header with logo

The solution I used (there are surely a number of different) consisted of rewriting/customizing the template of the standard slide `slide.html`, adding the footer/header with logo.

So, the basic slide template looks like this:



```
<slide class="{{ slide.class }}" id="{{ slide.id }}" style="background:{{{ slide.bg }}};">
{{# slide.header }}
<hgroup>
{{{ slide.header}}}
</hgroup>
{{/ slide.header }}
<article data-timings="{{ slide.dt }}">
{{{ slide.content }}}
</article>
<!-- Presenter Notes -->
{{# slide.pnotes }}
<aside class="note" id="{{ id }}">
<section>
{{{ html }}}
</section>
</aside>
{{/ slide.pnotes }}
</slide>
```



I added some lines  to add an object (logo) at a certain position; so my `slide.html` file looked like this:



```
<slide class="{{ slide.class }}" id="{{ slide.id }}">
<hgroup>
{{{ slide.header }}}
</hgroup>
<article>
{{{ slide.content }}}
<footer class = 'logo'>
<div style="position: absolute; left: 1000px; top: 50px; z-index:100">
<img src = "assets/img/logo.png" height="80" width="80">
</div>
</footer>
</article>
</slide>
```



Now, we have to save this file under [project folder]/assets/layouts.

The name does not matter; any html-file in this folder will be parsed by slidify. Here come the header with logo:

![]({{ site.url }}/images/logo_header.png)

You can adapt size and position of the logo with the img html function.

## That's it! Happy slidifying!

You will find the code on this [github repo](https://github.com/sebastiansauer/Slidify-with-Logo/tree/gh-pages), along with the [slidify-presentation](https://sebastiansauer.github.io/Slidify-with-Logo/#1).
