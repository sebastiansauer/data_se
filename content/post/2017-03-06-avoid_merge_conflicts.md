---
author: Sebastian Sauer
date: '2017-03-06'
title: How to avoid Github/merge conflicts with Rmd-files
tags:
  - rstats
  - git
slug: avoid_merge_conflicts
---


One nice features of `.rmd` files is that version control systems, such as git and github, can (quite) easily be combined. However, in my experience, merge conflicts are not so uncommon. That raises the question how to avoid merge conflicts when syncing with Github?

Here's a quick overview on what to do to that hassle:


1. Sync often.
2. Hard wrap the lines to approx. 80 characters.
3. Pull before you start to change the source files.


Watch out not to hard wrap YAML. Some Latex code also does not like being hard wrapped (some functions need their own, new line to be executed properly).
