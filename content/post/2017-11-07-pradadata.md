---
author: Sebastian Sauer
date: '2017-11-07'
title: Package 'pradadata' on Github - feature social science data
tags:
  - data
slug: pradadata
---




Recently, I've put a package on Github featureing some social science data set. Some data came from official sites; my contribution was to clear 'em up, and render comfortably accessable for automatic inquiry (nice header lines, no special enconding, flat csvs....). In other cases it's unpublished data collected by friends, students of mine or myself.


Let's check its contents using a function by [Maiasaura](https://stackoverflow.com/users/313163/maiasaura) from this [SO post](https://stackoverflow.com/questions/12575098/to-see-all-the-content-not-just-objects-in-a-package-in-r).


```r
library(pradadata)
lsp <- function (package, all.names = FALSE, pattern) {
    package <- deparse(substitute(package))
    ls(pos = paste("package", package, sep = ":"), all.names = all.names, 
        pattern = pattern)
}
```


So, as of today, this dataset are included:


```r
data_in_pradadata <- lsp(pradadata)
data_in_pradadata
#>  [1] "cult_values"    "dating"         "elec_results"   "extra"         
#>  [5] "extra_names"    "parties_de"     "socec"          "socec_dict"    
#>  [9] "stats_test"     "wahlkreise_shp" "wellbeing"      "Werte"         
#> [13] "wo_men"
```

Let's check the help documentation for each object; the R code is inspired by [Joshua Ulrich](https://stackoverflow.com/users/271616/joshua-ulrich), see this [SO post](https://stackoverflow.com/questions/7493843/how-to-write-contents-of-help-to-a-file-from-within-r).

```r
library(purrr)

data_in_pradadata %>% 
  map(help) %>% 
 # simplify %>% 
  map(~tools:::Rd2txt(utils:::.getHelpFile(as.character(.))))
#> _S_c_h_w_a_r_t_z _C_u_l_t_u_r_a_l _V_a_l_u_e _O_r_i_e_n_t_a_t_i_o_n _S_c_o_r_e_s _f_o_r _8_0 _c_o_u_n_t_r_i_e_s
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      Data based on Schwartz' theory of cultural values.
#> 
#> _U_s_a_g_e:
#> 
#>      cult_values
#>      
#> _F_o_r_m_a_t:
#> 
#>      a data frame with 83 rows and 10 variables:
#> 
#>      country short country name, short form
#> 
#>      country_long country name, long form
#> 
#>      harmony Unity With Nature World at Peace
#> 
#>      embedded Social Order, Obedience Respect for Tradition
#> 
#>      hierarchy Authority Humble
#> 
#>      mastery Ambition Daring
#> 
#>      aff_auton affective autonomy; Pleasure
#> 
#>      intel_auton intellectual autonomy; Broadmindedness Curiosity
#> 
#>      egalitar egalitarianism; Social Justice Equality
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      The following description is taken from <URL:
#>      http://latest-schwartz.wikidot.com/> (CC-BY-SA 3.0)
#> 
#>      Data were collected between 1988 and 2000
#> 
#>      There are 7 cultural dimensions in Schwartz
#>      theory:harmony,embeddedness,hierarchy,mastery,affective
#>      autonomy,intellectual autonomy,egalitarianism.
#> 
#>      Embeddedness VS Autonomy:Embeddedness appears in situations where
#>      individuals are embedded in a collectivity and find meaning
#>      through social relationships,through identifying with the
#>      group,participating in its shared way of life,and striving toward
#>      its shared goals.In embeddedness societies personal interests are
#>      not seen as different from those of the group and high value is
#>      placed on preserving the status quo and avoiding individual
#>      actions or attitudes that might undermine the traditional order of
#>      things.Important values in such societies are social order,respect
#>      for tradition,security,obedience and wisedom.While autonomy refers
#>      to the situation where individuals are viewed as
#>      autonomous.bounded entities that are expected to cultivate and
#>      express their own preferences,feelings,ideas,and abilities and
#>      find meaning in their own uniqueness.Autonomy is further broken
#>      down into two categories:intellectual autonomy which refers to the
#>      independent prusuit of ideas ,intellectual derections and
#>      rights;affective autonomy,which refers to the independent pursuit
#>      of affectively positive experiences such as varied life,pleasure
#>      and enjoyment of life.
#> 
#>      Hierarchy VS Egalitarianism:In hierarchical societies individuals
#>      and the resources associated with society are organized
#>      hierarchically and individuals within those societies are
#>      socialized to comply with the roles assigned to them in the
#>      hierarchy and subjected to sanctions if they fail to
#>      comply.Modesty and self-control are values associated with
#>      hierarchy.In egalitarian societies individuals are seen as moral
#>      equals and everyone shares the same basic interests as human
#>      beings.In egalitarian societies people are socialized to
#>      internalize a commitment to cooperate and to feel concern for
#>      everyone's welfare.Valued associated with egalitarian societies
#>      include socail justice and caring for the weaker members of the
#>      society,honesty,equality,sympathy and working for the good of
#>      others,social responsibility and voluntary cooperation in the
#>      pursuit of well-being or prosperity for others within the society.
#> 
#>      Mastery VS Harmony:Mastery refers to the situation wher
#>      individuals value succeeding and getting ahead through
#>      self-assertion and proactively seek to master,direct and change
#>      the natural and social world to advance their personal interests
#>      and the interests of the groups to which they belong.Specific
#>      values associated with mastery include independence,fearlessness
#>      and daring,ambition and hard work,drive for success and
#>      competence.Harmony refers to the situation wher individuals are
#>      content to accept and fit into the natural and social world as
#>      they find it and seek to understand,preserve and protect it rather
#>      than change,direct or exploit it.Important values in societies
#>      where harmony is valued include world at peace,unity with
#>      nature,and protecting the environment.
#> 
#>      Here are the conclusions of Schwartz theory:cultural value
#>      orientations can be inferred form mean values of individuals in
#>      societies;world composed of cultural regions,linked by
#>      history,geography,economics,religion;knowing how cultures differ
#>      gives tools for specific analysis of issuses in international
#>      contact;cultural value orientations relate in reciprocal causaltiy
#>      with key social structural,political,demographic features of
#>      society.
#> 
#>      All items were collected on a -1 to +7 response scale.
#> 
#>      Note: Three lines have added (for countries: can, ger, swi), with
#>      their values computed as (unweighted) average of the country
#>      parts.
#> 
#> _S_o_u_r_c_e:
#> 
#>      wikidot
#> 
#> _R_e_f_e_r_e_n_c_e_s:
#> 
#>      Schwartz, S. H. (2006). A theory of cultural value orientations:
#>      Explication and applications. Comparative sociology, 5(2),
#>      137-182.
#> 
#> _R_e_s_u_l_t_s _f_r_o_m _a_n _e_x_p_e_r_i_m_e_n_t _o_n _s_t_a_t_u_s _s_y_m_b_o_l_s _a_n _d_a_t_i_n_g _s_u_c_c_e_s_s
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      Data from an online dating/mating app experiment with IV "car as
#>      status symbol" (yes vs. no) and DV1 "matching" (number) and DV2
#>      "message sent" (number). The principal research question was
#>      whether a luxury sports car (BMW Z4) on the individual profile
#>      portrait photo at an online dating app would have an influence on
#>      the number of contact requests and messages sent to this profile.
#>      Care was taken that the profiles showed no difference besides the
#>      car.
#> 
#> _U_s_a_g_e:
#> 
#>      dating
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 5063 rows and 7 columns
#> 
#>      strawperson Chr. DThere were 6 straw persons. ie., persons with a
#>           profile on the dating portal
#> 
#>      sex Chr. Sex of strawperson
#> 
#>      car Int. Whether a luxury sports car was on the profile picture or
#>           not
#> 
#>      date Chr. Date mm/dd/yyyy
#> 
#>      Age Int. Age
#> 
#>      ID_hash Chr. Username anonymized
#> 
#>      comm_type Type of communication by individuals: either matching or
#>           contact message
#> 
#>      whr Numeric. Waist hip ratio of strawperson
#> 
#>      beauty Subjective beauty rating of strawperson by rating committee
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      This dataset was published here: <URL: https://osf.io/4hkjm/>.
#> 
#> _S_o_u_r_c_e:
#> 
#>      Please cite this dataset as: 'Sauer, S., & Wolff, A. (2016, August
#>      16). The effect of status symbols on success in online dating: an
#>      experimental study. Retrieved from osf.io/4hkjm'
#> 
#> _D_a_t_a_f_r_a_m_e _c_o_n_t_a_i_n_i_n_g _t_h_e _r_e_s_u_l_t_s _o_f _t_h_e _2_0_1_7 _f_e_d_e_r_a_l _e_l_e_c_t_i_o_n_s
#> (_B_u_n_d_e_s_t_a_g_s_w_a_h_l)
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset is published by the Bundeswahlleiter 2017 (c) Der
#>      Bundeswahlleiter, Wiesbaden 2017
#>      https://www.bundeswahlleiter.de/info/impressum.html
#> 
#> _U_s_a_g_e:
#> 
#>      elec_results
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 332 rows and 191 columns
#> 
#>      district_nr Integer. Number of the electoral district
#> 
#>      district_name Chr. Name of the electoral disctrict
#> 
#>      parent_district_nr Int. Number of the parent district
#> 
#>      registered_voters_1 Number of registered voters first vote
#>           \(Erststimme\), present election - 1
#> 
#>      registered_voters_1 Number of registered voters first vote
#>           \(Erststimme\), previous election - 2
#> 
#>      registered_voters_1 Number of registered voters second vote
#>           \(Zweitstimme\), present election - 3
#> 
#>      registered_voters_1 Number of registered voters second vote
#>           \(Zweitstimme\), previous election - 4
#> 
#>      votes_1 Number of eligible votes - 1
#> 
#>      votes_2 Number of eligible votes - 2
#> 
#>      votes_3 Number of eligible votes - 3
#> 
#>      votes_4 Number of eligible votes - 4
#> 
#>      votes_invalid_1 Number of invalid votes - 1
#> 
#>      votes_invalid_2 Number of invalid votes - 2
#> 
#>      votes_invalid_3 Number of invalid votes - 3
#> 
#>      votes_invalid_4 Number of invalid votes - 4
#> 
#>      votes_valid_1 Number of valid votes - 1
#> 
#>      votes_valid_2 Number of valid votes - 2
#> 
#>      votes_valid_3 Number of valid votes - 3
#> 
#>      votes_valid_4 Number of valid votes - 4
#> 
#>      CDU_1 Number of votes for CDU - 1
#> 
#>      CDU_2 Number of votes for CDU - 2
#> 
#>      CDU_3 Number of votes for CDU - 3
#> 
#>      CDU_4 Number of votes for CDU - 4
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Data is made available for unrestricted use provided the source is
#>      credited.
#> 
#>      Data presented here has been altered in the sense that it has been
#>      rendered more machine-friendly (one header row only, no special
#>      characters, no blanks in header line, etc.). Beside that, the data
#>      itself has not been changed in any way.
#> 
#>      The columns are structures as follows. For each column AFTER
#>      'parent_district_nr', ie., from column 4 onward, 4 columns build
#>      one bundle. In each bundle, column 1 refers to the Erststimme in
#>      the present election; column 2 to the Erststimme in the previous
#>      election. Column 3 refers to the Zweitstimme of the present
#>      election, and column 4 to the Zweitstimme of the previous
#>      election. For example, 'CDU_3' refers to the number of
#>      Zweitstimmen in the present (2017) elections.
#> 
#>      The long names of the 43 parties at the 2017 federal German elects
#>      can be accessed via the dataframe parties_de
#> 
#> _R_e_s_u_l_t_s _f_r_o_m _a _s_u_r_v_e_y _o_n _e_x_t_r_a_v_e_r_s_i_o_n
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset provides results from a survey on extraversion.
#>      Subjects were students participating in a statistics class at FOM
#>      University of Applied Sciences. Student with different majors
#>      participated in the study with the majority coming from psychology
#>      majors. The study was intented primarily as an educational
#>      endavor. For example, variables with different scale levels
#>      (nominal, metric) were included. However, different aspect of
#>      extraverion were included to test some psychometric assumptions.
#>      For example, one item approaches to extraversion are included.
#> 
#> _U_s_a_g_e:
#> 
#>      extra
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 826 rows and 33 columns
#> 
#>      timestamp Chr. Date and Time in German format
#> 
#>      code Chr. Pseudonymous code of each participant
#> 
#>      i01 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i02r Int. items 1-10. "r" indicates recoded (reverserd). Answers:
#>           1 (not agree) to 4 (agree)
#> 
#>      i03 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i04 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i05 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i06r Int. items 1-10. "r" indicates recoded (reverserd). Answers:
#>           1 (not agree) to 4 (agree)
#> 
#>      i07 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i08 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i09 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      i10 Int. items 1-10. "r" indicates recoded (reverserd). Answers: 1
#>           (not agree) to 4 (agree)
#> 
#>      n_facebook_friends Int. Count of self-reported Facebook friends
#> 
#>      n_hangover Int. Count of self-reported hangovers in the last 12
#>           months
#> 
#>      age Int. Age
#> 
#>      sex Int. Sex
#> 
#>      extra_single_item Int. extraversion by single ime, Answers: 1 (not
#>           agree) to 4 (agree)
#> 
#>      time_conversation Num. How many minutes do you need to get into a
#>           converation at a party
#> 
#>      presentation Chr. Would you volunteer to give a speech at a
#>           convention?
#> 
#>      n_party Int. Self-reported numbers of party attended in the last
#>           12 months
#> 
#>      clients Chr. Self-reported frequency of being in contact with
#>           clients at work
#> 
#>      extra_vignette Chr. Self-reported fit to extraversion description
#>           (fit vs. non-fit)
#> 
#>      i21 Chr. Empty
#> 
#>      extra_vignette2 Num. extraversiong descriptiong, ranging from 1
#>           (extraverted) to 6 (introverted)
#> 
#>      major Chr. Major field of study
#> 
#>      smoker Chr. Smoker?
#> 
#>      sleep_week Chr. Daily hours of sleep during work days
#> 
#>      sleep_wend Chr. Daily hours of sleep during week ends
#> 
#>      clients_freq Num. Same as 'clients', from 1 (barely) to 5 (very
#>           often)
#> 
#>      extra_mean Num. Mean of 10 items
#> 
#>      extra_md Num. Median of 10 items
#> 
#>      extra_aad Num. Absolute average deviation from the mean of 10
#>           items
#> 
#>      extra_mode Num. Mode of 10 items
#> 
#>      extra_iqr Num. IQR of 10 items
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      This dataset was published here: <URL: https://osf.io/4kgzh>.  See
#>      survey here <URL: https://goo.gl/forms/B5bparAu8uR7T1c03>.  Items
#>      of the survey have changed over time.  Only the most recent
#>      version of the survey is online.  Survey conducted at the Business
#>      Psychology lab at FOM University of Applied Sciences from 2015 to
#>      April 2017
#> 
#> _S_o_u_r_c_e:
#> 
#>      Please cite this dataset as: 'Sauer, S. (2016, November 19).
#>      Extraversion Dataset. http://doi.org/10.17605/OSF.IO/4KGZH'
#> 
#> _I_t_e_m _l_a_b_e_l_s - _f_o_r _d_a_t_a_s_e_t '_e_x_t_r_a' _i_n _p_a_c_k_a_g_e '_p_r_a_d_a'
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      Item labels - for dataset 'extra' in package 'prada'
#> 
#> _U_s_a_g_e:
#> 
#>      extra_names
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 28 rows and 1 column
#> 
#>      value Chr. item labels
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      This dataset was published here: <URL: https://osf.io/4kgzh>.  See
#>      survey here <URL: https://goo.gl/forms/B5bparAu8uR7T1c03>.  Items
#>      of the survey have changed over time. Only the most recent version
#>      of the survey is online.  Survey conducted at the Business
#>      Psychology lab at FOM University of Applied Sciences from 2015 to
#>      April 2017
#> 
#> _S_o_u_r_c_e:
#> 
#>      Please cite this dataset as: 'Sauer, S. (2016, November 19).
#>      Extraversion Dataset. http://doi.org/10.17605/OSF.IO/4KGZH'
#> 
#> _N_a_m_e_s _o_f _t_h_e _p_a_r_t_i_e_s _w_h_o _r_a_n _f_o_r _t_h_e _G_e_r_m_a_n _f_e_d_e_r_a_l _e_l_e_c_t_i_o_n_s _2_0_1_7
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset stems from data published by the Bundeswahlleiter
#>      2017 (c) Der Bundeswahlleiter, Wiesbaden 2017, <URL:
#>      https://www.bundeswahlleiter.de/info/impressum.html>
#> 
#> _U_s_a_g_e:
#> 
#>      parties_de
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 43 rows and 2 columns
#> 
#>      party_short The short name (acronym) of the party
#> 
#>      party_long The long (spelled-out) name of the party
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Data is made available for unrestricted use provided the source is
#>      credited.
#> 
#> _S_o_u_r_c_e:
#> 
#>      This dataset is based on data published by the Bundeswahlleiter
#>      2017, (c) Der Bundeswahlleiter, Wiesbaden 2017, <URL:
#>      https://www.bundeswahlleiter.de/info/impressum.html>
#> 
#> _D_a_t_a_f_r_a_m_e _c_o_n_t_a_i_n_i_n_g _s_o_c_i_o _e_c_o_n_o_m_i_c _d_a_t_a _o_f _t_h_e _G_e_r_m_a_n _e_l_e_c_t_o_r_a_l
#> _d_i_s_t_r_i_c_t_s _a_t _t_h_e _t_i_m_e _o_f _t_h_e _2_0_1_7 _f_e_d_e_r_a_l _e_l_e_c_t_i_o_n_s (_B_u_n_d_e_s_t_a_g_s_w_a_h_l)
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset is published by the Bundeswahlleiter 2017 (c) Der
#>      Bundeswahlleiter, Wiesbaden 2017
#>      https://www.bundeswahlleiter.de/info/impressum.html
#> 
#> _U_s_a_g_e:
#> 
#>      socec
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 316 rows and 51 columns
#> 
#>      V1 state
#> 
#>      V2 Wahlkreis-Nr.
#> 
#>      V3 Wahlkreis-Name
#> 
#>      V4 Gemeinden am 31.12.2015 (Anzahl)
#> 
#>      V5 Flaeche am 31.12.2015 (km^2)
#> 
#>      V6 Bevoelkerung am 31.12.2015 - Insgesamt (in 1000)
#> 
#>      V7 Bevoelkerung am 31.12.2015 - Deutsche (in 1000)
#> 
#>      V8 Bevoelkerung am 31.12.2015 - Auslaender in Prozent
#> 
#>      v9 Bevoelkerungsdichte am 31.12.2015 (Einwohner je km²)
#> 
#>      v10 Zu- (+) bzw. Abnahme (-) der Bevoelkerung 2015 - Geburtensaldo
#>           (je 1000 Einwohner)
#> 
#>      V11 Zu- (+) bzw. Abnahme (-) der Bevoelkerung 2015 -
#>           Wanderungssaldo (je 1000 Einwohner)
#> 
#>      V12 Alter von ... bis ... Jahren am 31.12.2015 - unter 18 in
#>           Prozent
#> 
#>      V13 Alter von ... bis ... Jahren am 31.12.2015 - 18-24 in Prozent
#> 
#>      V14 Alter von ... bis ... Jahren am 31.12.2015 - 25-34 in Prozent
#> 
#>      V15 Alter von ... bis ... Jahren am 31.12.2015 - 35-59 in Prozent
#> 
#>      V16 Alter von ... bis ... Jahren am 31.12.2015 - 60-74 in Prozent
#> 
#>      V17 Alter von ... bis ... Jahren am 31.12.2015 - 75 und mehr in
#>           Prozent
#> 
#>      V18 Zensus 2011, Bevoelkerung nach Migrationshintergrund am
#>           09.05.2011 - ohne Migrationshintergrund in Prozent
#> 
#>      V19 Zensus 2011, Bevoelkerung nach Migrationshintergrund am
#>           09.05.2011 - mit Migrationshintergrund in Prozent
#> 
#>      V20 Zensus 2011, Bevoelkerung nach Religionszugehoerigkeit am
#>           09.05.2011 - Roemisch-katholische Kirche in Prozent
#> 
#>      V21 "Zensus 2011, Bevoelkerung nach Religionszugehoerigkeit am
#>           09.05.2011 - Evangelische Kirche in Prozent
#> 
#>      V22 Zensus 2011, Bevoelkerung nach Religionszugehoerigkeit am
#>           09.05.2011 - Sonstige, keine, ohne Angabe in Prozent
#> 
#>      V23 Zensus 2011, Wohnungen in Wohngebaeuden am 09.05.2011 -
#>           Eigentuemerquote
#> 
#>      V24 Bautaetigkeit und Wohnungswesen - Fertiggestellte Wohnungen
#>           2014 (je 1000 Einwohner)
#> 
#>      V25 Bautaetigkeit und Wohnungswesen - Bestand an Wohnungen am
#>           31.12.2015 (je 1000 Einwohner)
#> 
#>      V26 Verfuegbares Einkommen der privaten Haushalte 2014 (EUR je
#>           Einwohner)
#> 
#>      V27 Bruttoinlandsprodukt 2014 (EUR je Einwohner)
#> 
#>      V28 Kraftfahrzeugbestand am 01.01.2016 (je 1000 Einwohner)
#> 
#>      V29 Absolventen/Abgaenger beruflicher Schulen 2015
#> 
#>      V30 Absolventen/Abgaenger allgemeinbildender Schulen 2015 -
#>           insgesamt ohne Externe (je 1000 Einwohner)
#> 
#>      V31 Absolventen/Abgaenger allgemeinbildender Schulen 2015 - ohne
#>           Hauptschulabschluss in Prozent
#> 
#>      V32 Absolventen/Abgaenger allgemeinbildender Schulen 2015 - mit
#>           Hauptschulabschluss in Prozent
#> 
#>      V33 Absolventen/Abgaenger allgemeinbildender Schulen 2015 - mit
#>           mittlerem Schulabschluss in Prozent
#> 
#>      V34 Absolventen/Abgaenger allgemeinbildender Schulen 2015 - mit
#>           allgemeiner und Fachhochschulreife in Prozent
#> 
#>      V35 Kindertagesbetreuung: Betreute Kinder am 01.03.2016 (je 1000
#>           Einwohner)
#> 
#>      V36 Unternehmensregister 2014 - Unternehmen insgesamt (je 1000
#>           Einwohner)
#> 
#>      V37 Unternehmensregister 2014 - Handwerksunternehmen (je 1000
#>           Einwohner)
#> 
#>      V38 Sozialversicherungspflichtig Beschaeftigte am 30.06.2016 -
#>           insgesamt (je 1000 Einwohner)
#> 
#>      V39 Sozialversicherungspflichtig Beschaeftigte am 30.06.2016 -
#>           Land- und Forstwirtschaft, Fischerei in Prozent
#> 
#>      V40 Sozialversicherungspflichtig Beschaeftigte am 30.06.2016 -
#>           Produzierendes Gewerbe in Prozent
#> 
#>      V41 Sozialversicherungspflichtig Beschaeftigte am 30.06.2016 -
#>           Handel, Gastgewerbe, Verkehr in Prozent
#> 
#>      V42 Sozialversicherungspflichtig Beschaeftigte am 30.06.2016 -
#>           oeffentliche und private Dienstleister in Prozent
#> 
#>      V43 Sozialversicherungspflichtig Beschaeftigte am 30.06.2016 -
#>           uebrige Dienstleister und 'ohne Angabe' in Prozent
#> 
#>      V44 Empfaenger(innen) von Leistungen nach SGB II am 31.12.2016 -
#>           insgesamt (je 1000 Einwohner)
#> 
#>      V45 Empfaenger(innen) von Leistungen nach SGB II am 31.12.2016 -
#>           nicht erwerbsfaehige Hilfebeduerftige in Prozent
#> 
#>      V46 Empfaenger(innen) von Leistungen nach SGB II am 31.12.2016 -
#>           Auslaender in Prozent
#> 
#>      V47 Arbeitslosenquote Maerz 2017 - insgesamt
#> 
#>      V48 Arbeitslosenquote Maerz 2017 - Maenner
#> 
#>      V49 Arbeitslosenquote Maerz 2017 - Frauen
#> 
#>      V50 Arbeitslosenquote Maerz 2017 - 15 bis unter 20 Jahre
#> 
#>      V51 Arbeitslosenquote Maerz 2017 - 55 bis unter 65 Jahre
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Data is made available for unrestricted use provided the source is
#>      credited.
#> 
#>      Data presented here has been altered in the sense that it has been
#>      rendered more machine-friendly (one header row only, no special
#>      characters, no blanks in header line, etc.). Beside that, the data
#>      itself has not been changed in any way.
#> 
#> _S_o_u_r_c_e:
#> 
#>      This dataset is published by the Bundeswahlleiter 2017, (c) Der
#>      Bundeswahlleiter, Wiesbaden 2017,
#>      https://www.bundeswahlleiter.de/info/impressum.html
#> 
#> _D_a_t_a_f_r_a_m_e _c_o_n_t_a_i_n_i_n_g _t_h_e _m_a_p_p_i_n_g _o_f _t_h_e _s_o_c_i_o _e_c_o_n_o_m_i_c _i_n_d_i_c_a_t_o_r _n_a_m_e_s
#> _a_n_d _t_h_e_i_r _I_D_s (_a _d_i_c_t_i_o_n_n_a_r_y)
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset is published by the Bundeswahlleiter 2017 (c) Der
#>      Bundeswahlleiter, Wiesbaden 2017 <URL:
#>      https://www.bundeswahlleiter.de/info/impressum.html>
#> 
#> _U_s_a_g_e:
#> 
#>      socec_dict
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 52 rows and 2 columns
#> 
#>      ID chr. ID of the indicator \(short name\)
#> 
#>      socec_indicator Spelled out name of the indicator
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Data is made available for unrestricted use provided the source is
#>      credited.
#> 
#>      Data presented here has been altered in the sense that it has been
#>      rendered more machine-friendly (one header row only, no special
#>      characters, no blanks in header line, etc.). Beside that, the data
#>      itself has not been changed in any way.
#> 
#> _S_o_u_r_c_e:
#> 
#>      This dataset is published by the Bundeswahlleiter 2017, (c) Der
#>      Bundeswahlleiter, Wiesbaden 2017, <URL:
#>      https://www.bundeswahlleiter.de/info/impressum.html>
#> 
#> _R_e_s_u_l_t_s _f_r_o_m _a_n _e_x_a_m _i_n _i_n_f_e_r_e_n_t_i_a_l _s_t_a_t_i_s_t_i_c_s.
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset provides results from a text exam in inferential
#>      statistics. Subjects were mostly inscribed in a psychology class.
#>      Both BSc and MSc. students participated in this test.
#>      Participation was voluntarily. No real grading was performed. Data
#>      were collected in 2015 to 2017. The exam consisted of 40 binary
#>      items. Each item was formulated as a statement which as either
#>      correct or false. Students were to tick their response in an
#>      online form. In addition some question were asked as to
#>      preparation time, upfront self-evalution and interest
#> 
#> _U_s_a_g_e:
#> 
#>      stats_test
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 306 rows and 7 columns
#> 
#>      row_number Integer. Row number
#> 
#>      date_time Chr. Date and Time in German format
#> 
#>      bestanden (Chr. Whether the student has passed ("ja") or not
#>           passed ("nein") the exam
#> 
#>      study_time Int. Subjective rating of study time, ranging from 1
#>           (low) to 5 (high)
#> 
#>      self_eval Int. Subjective upfront rating of expected success,
#>           ranging fom 1 (low) to 10 (high)
#> 
#>      interest Int. Subjective upfront rating of interest in statistics,
#>           ranging fom 1 (low) to 6 (high)
#> 
#>      score Int. score (number of correct answers out of 40), ranging
#>           fom 0 (all false) to 40 (all correct)
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Survey conducted at the Business Psychology lab at FOM University
#>      of Applied Sciences from 2015 to April 2017
#> 
#> _S_o_u_r_c_e:
#> 
#>      The data were published here: <URL: https://osf.io/sjhuy/>.  The
#>      survey is online here <URL:
#>      https://goo.gl/forms/TCWUFe0ZIrUQEetv1>. Note that items have
#>      changed over time.  However, whether 'true' or 'false' had to be
#>      circled remain constant for each item.  Please cite this dataset
#>      as: 'Sauer, S. (2017, January 27).  Dataset “predictors of
#>      performance in stats test.” http://doi.org/10.17605/OSF.IO/SJHUY'
#> 
#> _D_a_t_a_f_r_a_m_e _c_o_n_t_a_i_n_i_n_g _t_h_e _g_e_o_m_a_p_p_i_n_g _d_a_t_a _o_f _t_h_e _e_l_e_c_t_o_r_a_l _d_i_s_t_r_i_c_t_s
#> (_W_a_h_l_k_r_e_i_s_e) _f_o_r _t_h_e _2_0_1_7 _G_e_r_m_a_n _B_u_n_d_e_s_t_a_g_s _e_l_e_c_t_i_o_n_s.
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset is published by the Bundeswahlleiter 2017 (c) Der
#>      Bundeswahlleiter, Wiesbaden 2017
#>      https://www.bundeswahlleiter.de/info/impressum.html
#> 
#> _U_s_a_g_e:
#> 
#>      wahlkreise_shp
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 299 rows and 5 columns
#> 
#>      WKR_NR Int. Official number of the Wahlkreis
#> 
#>      LAND_NR Factor. Number of the federal state (Bundesland)
#> 
#>      LAND_NAME Factor. Name of the federal state (Bundesland)
#> 
#>      WKR_NAME Factor. Name of the Wahlkreis
#> 
#>      geometry sfc MULTIPOLYGON. List column with geo data
#> 
#>      @source This dataset is published by the Bundeswahlleiter 2017,
#>      (c) Der Bundeswahlleiter, Wiesbaden 2017,
#>      https://www.bundeswahlleiter.de/info/impressum.html
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Data is made available for unrestricted use provided the source is
#>      credited.
#> 
#>      The data have not been changed in any way.
#> 
#> _D_a_t_a _f_r_o_m _t_h_e _O_E_C_D _R_e_g_i_o_n_a_l _W_e_l_l_b_e_i_n_g _s_t_u_d_y (_R_W_B__0_3_1_1_2_0_1_7_1_7_2_4_1_4_4_3_1)
#> _V_e_r_s_i_o_n _o_f _J_u_n_e _2_0_1_6
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      Agregated and detailed indicators for all OECD regions are
#>      reported.
#> 
#> _U_s_a_g_e:
#> 
#>      data(wellbeing)
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame with 429 rows and 28 variables
#> 
#>      Country OECD country
#> 
#>      Region Region
#> 
#>      region_type part of country or whole country
#> 
#>      Education Education
#> 
#>      Jobs Jobs
#> 
#>      Income Income
#> 
#>      Safety Safety
#> 
#>      Civic_engagement Civic engagement
#> 
#>      Accessiblity_to_services Accessibility of services
#> 
#>      Housing Housing
#> 
#>      Community Community
#> 
#>      Life_satisfaction Life_satisfaction
#> 
#>      Labour Labour force with at least secondary education
#> 
#>      Employment Employment rate
#> 
#>      Unemployment Unemploy-ment rate
#> 
#>      Income_capita Household disposable income per capita
#> 
#>      Homicide Homicide rate
#> 
#>      Mortality Mortality rate
#> 
#>      Life_expectancy Life expectancy
#> 
#>      PM25 Air pollution level of PM2.5
#> 
#>      Voter Voter turnout
#> 
#>      Broadband Broadband access
#> 
#>      Rooms Number of rooms per person
#> 
#>      Support Perceived social network support
#> 
#>      Satisfaction Self assessment of life satisfaction
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      Please see the userguide for details on the indicators
#> 
#> _S_o_u_r_c_e:
#> 
#>      <URL: https://www.oecdregionalwellbeing.org/>
#> 
#> _R_e_s_u_l_t_s _f_r_o_m _a _s_u_r_v_e_y _o_n _v_a_l_u_e _o_r_i_e_n_t_a_t_i_o_n
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This is a random selection of 1000 cases with 15 variables of
#>      Human Values from the european social survey. The data were
#>      collected by students of the FOM in Germany in spring 2017 using
#>      face-to-face interviews.
#> 
#> _U_s_a_g_e:
#> 
#>      Werte
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 1000 rows and 15 columns
#> 
#>      Spass Fun
#> 
#>      Freude Joy
#> 
#>      Aufregung Excitement
#> 
#>      Fuehrung Leadership
#> 
#>      Entscheidung Decisiveness
#> 
#>      Religioesitaet Religiosity
#> 
#>      Respekt Respect
#> 
#>      Demut Humility
#> 
#>      Gefahrenvermeidung Avoidance
#> 
#>      Sicherheit Security
#> 
#>      Ordentlichkeit Orderliness
#> 
#>      Unabhaengigkeit Independence
#> 
#>      Zuhoeren Listening
#> 
#>      Umweltbewusstsein Environment awareness
#> 
#>      Interesse Intereset
#> 
#> _D_e_t_a_i_l_s:
#> 
#>      This dataset was published here: <URL: https://osf.io/4982w/>.
#> 
#> _S_o_u_r_c_e:
#> 
#>      Please cite this dataset as: 'Gansser, O. (2017, June 8). Data for
#>      Principal Component Analysis and Common Factor Analysis. Retrieved
#>      from https://osf.io/4982w/'
#> 
#> _H_e_i_g_h_t, _s_e_x, _a_n_d _s_h_o_e _s_i_z_e _o_f _s_o_m_e _s_t_u_d_e_n_t_s.
#> 
#> _D_e_s_c_r_i_p_t_i_o_n:
#> 
#>      This dataset provides data of height, sex, and shoe size from some
#>      students. It was collected for paedagogical purposes.
#> 
#> _U_s_a_g_e:
#> 
#>      wo_men
#>      
#> _F_o_r_m_a_t:
#> 
#>      A data frame containing 101 rows and 5 columns
#> 
#>      row_number Integer. Row number
#> 
#>      time Chr. Date and Time in German format
#> 
#>      sex (Chr. Sex; either 'woman' or 'man'
#> 
#>      height Num. Self-reported height in centimeters
#> 
#>      shoe_size Num. Self-reported shoe size in German format
#> 
#> _S_o_u_r_c_e:
#> 
#>      The data were published here: <URL: https://osf.io/ja9dw>.  Survey
#>      conducted at the Business Psychology lab at FOM University of
#>      Applied Sciences from 2015 to April 2017.  Please cite as: 'Sauer,
#>      S. (2017, February 23).  Dataset “Height and shoe size.”
#>      http://doi.org/10.17605/OSF.IO/JA9DW'
#> [[1]]
#> [1] ""
#> 
#> [[2]]
#> [1] ""
#> 
#> [[3]]
#> [1] ""
#> 
#> [[4]]
#> [1] ""
#> 
#> [[5]]
#> [1] ""
#> 
#> [[6]]
#> [1] ""
#> 
#> [[7]]
#> [1] ""
#> 
#> [[8]]
#> [1] ""
#> 
#> [[9]]
#> [1] ""
#> 
#> [[10]]
#> [1] ""
#> 
#> [[11]]
#> [1] ""
#> 
#> [[12]]
#> [1] ""
#> 
#> [[13]]
#> [1] ""
```


# Installation

Install the package the usual way:



```r
devtools::install_github("sebastiansauer/pradadata")
library(pradadata)
```


# Licence

As far as the data is from myself (ie., published by me), it's all open, feel free to use it (please attribute). Licence are detailed in appropriate places. Note that not all the data is published by me; I have indicated the details in the help of the data set.






