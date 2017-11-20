---
author: Sebastian Sauer
date: '2017-02-21'
title: AfD Mining - basales Textmining zum AfD-Parteiprogramm
tags:
  - textmining
  - populism
  - right-wing
  - German
slug: textmining_AfD_01
---






Für diesen Post benötigte R-Pakete:

```r
library(stringr)  # Textverarbeitung
library(tidytext)  # Textmining
library(pdftools)  # PDF einlesen
library(downloader)  # Daten herunterladen
# library(knitr)  # HTML-Tabellen
library(htmlTable)  # HTML-Tabellen
library(lsa)  # Stopwörter 
library(SnowballC)  # Wörter trunkieren
library(wordcloud)  # Wordcloud anzeigen
library(gridExtra)  # Kombinierte Plots
library(dplyr)  # Datenjudo
library(ggplot2)  # Visualisierung 
```

Ein einführendes Tutorial zu Textmining; analysiert wird das Parteiprogramm der Partei "Alternative für Deutschland" (AfD). Vor dem Hintergrund des gestiegenen Zuspruchs von Rechtspopulisten und der großen Gefahr, die von diesem Gedankengut ausdünstet, erscheint mir eine facettenreiche Analyse des Phänomens "Rechtspopulismus" nötig.



Ein großer Teil der zur Verfügung stehenden Daten liegt nicht als braves Zahlenmaterial vor, sondern in "unstrukturierter" Form, z.B. in Form von Texten. Im Gegensatz zur Analyse von numerischen Daten ist die Analyse von Texten[^99] weniger verbreitet bisher. In Anbetracht der Menge und der Informationsreichhaltigkeit von Text erscheint die Analyse von Text als vielversprechend.


In gewisser Weise ist das Textmining ein alternative zu klassischen qualitativen Verfahren der Sozialforschung. Geht es in der qualitativen Sozialforschung primär um das Verstehen eines Textes, so kann man für das Textmining ähnliche Ziele formulieren. Allerdings: Das Textmining ist wesentlich schwächer und beschränkter in der Tiefe des Verstehens. Der Computer ist einfach noch wesentlich *dümmer* als ein Mensch, in dieser Hinsicht. Allerdings ist er auch wesentlich *schneller* als ein Mensch, was das Lesen betrifft. Daher bietet sich das Textmining für das Lesen großer Textmengen an, in denen eine geringe Informationsdichte vermutet wird. Sozusagen maschinelles Sieben im großen Stil. Da fällt viel durch die Maschen, aber es werden Tonnen von Sand bewegt.



## Grundlegende Analyse


### Text-Daten einlesen

Nun lesen wir Text-Daten ein; das können beliebige Daten sein. Eine gewisse Reichhaltigkeit ist von Vorteil. Nehmen wir das Parteiprogramm der Partei AfD[^2][^120]. Die AfD schätzt die liberal-freiheitliche Demokratie gering, befürchte ich. Damit stellt die AfD die Grundlage von Frieden und Menschenwürde in Frage. Grund genug, sich ihre Themen näher anzuschauen; hier mittels einiger grundlegender Textmining-Analysen.



```r
afd_url <- "https://www.alternativefuer.de/wp-content/uploads/sites/7/2016/05/2016-06-27_afd-grundsatzprogramm_web-version.pdf"

afd_pfad <- "afd_programm.pdf"

download(afd_url, afd_pfad)

afd_raw <- pdf_text(afd_pfad)

str_sub(afd_raw[3], start = 1, end = 200)  # ersten 200 Zeichen der Seite 3 des Parteiprogramms
#> [1] "3\t Programm für Deutschland | Inhalt\n   7 | Kultur, Sprache und Identität\t\t\t\t                                   45 9 | Einwanderung, Integration und Asyl\t\t\t                       57\n     7.1 \t\t Deutsc"
```


Mit `download` haben wir die Datei mit der URL `afd_url` heruntergeladen und als `afd_pfad` gespeichert. Für uns ist `pdf_text` sehr praktisch, da diese Funktion Text aus einer beliebige PDF-Datei in einen Text-Vektor einliest.


Der Vektor `afd_raw` hat 96 Elemente (entsprechend der Seitenzahl des Dokuments); zählen wir die Gesamtzahl an Wörtern. Dazu wandeln wir den Vektor in einen tidy text Dataframe um. Auch die Stopwörter entfernen wir wieder wie gehabt.


```r

afd_df <- data_frame(Zeile = 1:96, 
                     afd_raw = afd_raw)

afd_df %>% 
  unnest_tokens(token, afd_raw) %>% 
  filter(str_detect(token, "[a-z]")) -> afd_df

dplyr::count(afd_df) 
#> # A tibble: 1 × 1
#>       n
#>   <int>
#> 1 26396
```

Eine substanzielle Menge von Text. Was wohl die häufigsten Wörter sind?


### Worthäufigkeiten auszählen


```r
afd_df %>% 
  na.omit() %>%  # fehlende Werte löschen
  dplyr::count(token, sort = TRUE)
#> # A tibble: 7,087 × 2
#>   token     n
#>   <chr> <int>
#> 1   die  1151
#> 2   und  1147
#> 3   der   870
#> # ... with 7,084 more rows
```

Die häufigsten Wörter sind inhaltsleere Partikel, Präpositionen, Artikel... Solche sogenannten "Stopwörter" sollten wir besser herausfischen, um zu den inhaltlich tragenden Wörtern zu kommen. Praktischerweise gibt es frei verfügbare Listen von Stopwörtern, z.B. im Paket `lsa`.


```r
data(stopwords_de)

stopwords_de <- data_frame(word = stopwords_de)

stopwords_de <- stopwords_de %>% 
  dplyr::rename(token = word)  # neu = alt

afd_df %>% 
  anti_join(stopwords_de) -> afd_df
```


Unser Datensatz hat jetzt viel weniger Zeilen; wir haben also durch `anti_join` Zeilen gelöscht (herausgefiltert). Das ist die Funktion von `anti_join`: Die Zeilen, die in beiden Dataframes vorkommen, werden herausgefiltert. Es verbleiben also nicht "Nicht-Stopwörter" in unserem Dataframe. Damit wird es schon interessanter, welche Wörter häufig sind.


```r
afd_df %>% 
  dplyr::count(token, sort = TRUE) -> afd_count

afd_count %>% 
  top_n(10) %>% 
  htmlTable()
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>token</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>n</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>deutschland</td>
<td style='text-align: center;'>190</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>afd</td>
<td style='text-align: center;'>171</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>programm</td>
<td style='text-align: center;'>80</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>wollen</td>
<td style='text-align: center;'>67</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>bürger</td>
<td style='text-align: center;'>57</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>euro</td>
<td style='text-align: center;'>55</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>dafür</td>
<td style='text-align: center;'>53</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>eu</td>
<td style='text-align: center;'>53</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>deutsche</td>
<td style='text-align: center;'>47</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>10</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>deutschen</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>47</td>
</tr>
</tbody>
</table><!--/html_preserve-->

Ganz interessant; aber es gibt mehrere Varianten des Themas "deutsch". Es ist wohl sinnvoller, diese auf den gemeinsamen Wortstamm zurückzuführen und diesen nur einmal zu zählen. Dieses Verfahren nennt man "stemming" oder trunkieren.


```r
afd_df %>% 
  mutate(token_stem = wordStem(.$token, language = "german")) %>% 
  dplyr::count(token_stem, sort = TRUE) -> afd_count

afd_count %>% 
  top_n(10) %>% 
  htmlTable()
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>token_stem</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>n</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>deutschland</td>
<td style='text-align: center;'>219</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>afd</td>
<td style='text-align: center;'>171</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>deutsch</td>
<td style='text-align: center;'>119</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>polit</td>
<td style='text-align: center;'>88</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>staat</td>
<td style='text-align: center;'>85</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>programm</td>
<td style='text-align: center;'>81</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>europa</td>
<td style='text-align: center;'>80</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>woll</td>
<td style='text-align: center;'>67</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>burg</td>
<td style='text-align: center;'>66</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>10</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>soll</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>63</td>
</tr>
</tbody>
</table><!--/html_preserve-->

Das ist schon informativer. Dem Befehl `wordStem` füttert man einen Vektor an Wörtern ein und gibt die Sprache an (Default ist Englisch[^3]). Das ist schon alles.


### Visualisierung der Worthäufigkeiten


Zum Abschluss noch eine Visualisierung mit einer "Wordcloud" dazu.



```r
wordcloud(words = afd_count$token_stem, freq = afd_count$n, max.words = 100, scale = c(2,.5), colors=brewer.pal(6, "Dark2"))
```

<img src="https://sebastiansauer.github.io/images/2017-02-21/wordcloud_tokens_afd-1.png" title="plot of chunk wordcloud_tokens_afd" alt="plot of chunk wordcloud_tokens_afd" width="70%" style="display: block; margin: auto;" />

Man kann die Anzahl der Wörter, Farben und einige weitere Formatierungen der Wortwolke beeinflussen[^4].

 
 
Weniger verspielt ist eine schlichte visualisierte Häufigkeitsauszählung dieser Art, z.B. mit Balkendiagrammen (gedreht).


```r

afd_count %>% 
  top_n(30) %>% 
  ggplot() +
  aes(x = reorder(token_stem, n), y = n) +
  geom_col() + 
  labs(title = "mit Trunkierung") +
  coord_flip() -> p1

afd_df %>% 
  dplyr::count(token, sort = TRUE) %>% 
  top_n(30) %>% 
  ggplot() +
  aes(x = reorder(token, n), y = n) +
  geom_col() +
  labs(title = "ohne Trunkierung") +
  coord_flip() -> p2

grid.arrange(p1, p2, ncol = 2)
```

<img src="https://sebastiansauer.github.io/images/2017-02-21/vis_freq_most_freq_tokens_bars-1.png" title="plot of chunk vis_freq_most_freq_tokens_bars" alt="plot of chunk vis_freq_most_freq_tokens_bars" width="70%" style="display: block; margin: auto;" />

Die beiden Diagramme vergleichen die trunkierten Wörter mit den nicht trunkierten Wörtern. Mit `reorder` ordnen wir die Spalte `token` nach der Spalte `n`. `coord_flip` dreht die Abbildung um 90°, d.h. die Achsen sind vertauscht. `grid.arrange` packt beide Plots in eine Abbildung, welche 2 Spalten (`ncol`) hat.


## Sentiment-Analyse
Eine weitere interessante Analyse ist, die "Stimmung" oder "Emotionen" (Sentiments) eines Textes auszulesen. Die Anführungszeichen deuten an, dass hier ein Maß an Verständnis suggeriert wird, welches nicht (unbedingt) von der Analyse eingehalten wird. Jedenfalls ist das Prinzip der Sentiment-Analyse im einfachsten Fall so: 

>   Schau dir jeden Token aus dem Text an.  
Prüfe, ob sich das Wort im Lexikon der Sentiments wiederfindet.  
Wenn ja, dann addiere den Sentimentswert dieses Tokens zum bestehenden Sentiments-Wert.  
Wenn nein, dann gehe weiter zum nächsten Wort.  
Liefere zum Schluss die Summenwerte pro Sentiment zurück.  



     
Es gibt Sentiment-Lexika, die lediglich einen Punkt für "positive Konnotation" bzw. "negative Konnotation" geben; andere Lexika weisen differenzierte Gefühlskonnotationen auf. Wir nutzen hier [dieses](http://asv.informatik.uni-leipzig.de/download/sentiws.html) Lexikon. Der Einfachheit halber gehen wir im Folgenden davon aus, dass das Lexikon schon aufbereitet vorliegt. Die Aufbereitung kann [hier](https://sebastiansauer.github.io/sentiment_dictionary/) zur Vertiefung nachgelesen werden.


```r

neg_df <- read_tsv("~/Downloads/SentiWS_v1.8c_Negative.txt", col_names = FALSE)
names(neg_df) <- c("Wort_POS", "Wert", "Inflektionen")

neg_df %>% 
  mutate(Wort = str_sub(Wort_POS, 1, regexpr("\\|", .$Wort_POS)-1),
         POS = str_sub(Wort_POS, start = regexpr("\\|", .$Wort_POS)+1)) -> neg_df


pos_df <- read_tsv("~/Downloads/SentiWS_v1.8c_Positive.txt", col_names = FALSE)
names(pos_df) <- c("Wort_POS", "Wert", "Inflektionen")

pos_df %>% 
  mutate(Wort = str_sub(Wort_POS, 1, regexpr("\\|", .$Wort_POS)-1),
         POS = str_sub(Wort_POS, start = regexpr("\\|", .$Wort_POS)+1)) -> pos_df

bind_rows("neg" = neg_df, "pos" = pos_df, .id = "neg_pos") -> sentiment_df
sentiment_df %>% select(neg_pos, Wort, Wert, Inflektionen, -Wort_POS) -> sentiment_df
```

Unser Sentiment-Lexikon sieht so aus:


```r
htmlTable(head(sentiment_df))
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>neg_pos</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Wort</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Wert</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Inflektionen</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>neg</td>
<td style='text-align: center;'>Abbau</td>
<td style='text-align: center;'>-0.058</td>
<td style='text-align: center;'>Abbaus,Abbaues,Abbauen,Abbaue</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>neg</td>
<td style='text-align: center;'>Abbruch</td>
<td style='text-align: center;'>-0.0048</td>
<td style='text-align: center;'>Abbruches,Abbrüche,Abbruchs,Abbrüchen</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>neg</td>
<td style='text-align: center;'>Abdankung</td>
<td style='text-align: center;'>-0.0048</td>
<td style='text-align: center;'>Abdankungen</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>neg</td>
<td style='text-align: center;'>Abdämpfung</td>
<td style='text-align: center;'>-0.0048</td>
<td style='text-align: center;'>Abdämpfungen</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>neg</td>
<td style='text-align: center;'>Abfall</td>
<td style='text-align: center;'>-0.0048</td>
<td style='text-align: center;'>Abfalles,Abfälle,Abfalls,Abfällen</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>6</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>neg</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>Abfuhr</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>-0.3367</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>Abfuhren</td>
</tr>
</tbody>
</table><!--/html_preserve-->

### Ungewichtete Sentiment-Analyse
Nun können wir jedes Token des Textes mit dem Sentiment-Lexikon abgleichen; dabei zählen wir die Treffer für positive bzw. negative Terme. Besser wäre noch: Wir könnten die Sentiment-Werte pro Treffer addieren (und nicht für jeden Term 1 addieren). Aber das heben wir uns für später auf.


```r
sentiment_neg <- match(afd_df$token, filter(sentiment_df, neg_pos == "neg")$Wort)
neg_score <- sum(!is.na(sentiment_neg))

sentiment_pos <- match(afd_df$token, filter(sentiment_df, neg_pos == "pos")$Wort)
pos_score <- sum(!is.na(sentiment_pos))

round(pos_score/neg_score, 1)
#> [1] 2.7
```

Hier schauen wir für jedes negative (positive) Token, ob es einen "Match" im Sentiment-Lexikon (`sentiment_df$Wort`) gibt; das geht mit `match`. `match` liefert `NA` zurück, wenn es keinen Match gibt (ansonsten die Nummer des Sentiment-Worts). Wir brauchen also nur die Anzahl der Nicht-NAs (`!is.na`) auszuzählen, um die Anzahl der Matches zu bekommen.


Entgegen dem, was man vielleicht erwarten würde, ist der Text offenbar *positiv* geprägt. Der "Positiv-Wert" ist ca. 2.6 mal so groß wie der "Negativ-Wert". Fragt sich, wie sich dieser Wert mit anderen vergleichbaren Texten (z.B. andere Parteien) misst. Hier sei noch einmal betont, dass die Sentiment-Analyse bestenfalls grobe Abschätzungen liefern kann und keinesfalls sich zu einem hermeneutischen Verständnis aufschwingt.


Welche negativen Wörter und welche positiven Wörter wurden wohl verwendet? Schauen wir uns ein paar an.





```r
afd_df %>% 
  mutate(sentiment_neg = sentiment_neg,
         sentiment_pos = sentiment_pos) -> afd_df

afd_df %>% 
  filter(!is.na(sentiment_neg)) %>% 
  dplyr::select(token) -> negative_sentiments
  
head(negative_sentiments$token,50)
#>  [1] "mindern"       "verbieten"     "unmöglich"     "töten"        
#>  [5] "träge"         "schädlich"     "unangemessen"  "unterlassen"  
#>  [9] "kalt"          "schwächen"     "ausfallen"     "verringern"   
#> [13] "verringern"    "verringern"    "verringern"    "belasten"     
#> [17] "belasten"      "fremd"         "schädigenden"  "klein"        
#> [21] "klein"         "klein"         "klein"         "eingeschränkt"
#> [25] "eingeschränkt" "entziehen"     "schwer"        "schwer"       
#> [29] "schwer"        "schwer"        "verharmlosen"  "unerwünscht"  
#> [33] "abgleiten"     "wirkungslos"   "schwach"       "verschleppen" 
#> [37] "vermindern"    "vermindern"    "ungleich"      "widersprechen"
#> [41] "zerstört"      "zerstört"      "erschweren"    "auffallen"    
#> [45] "unvereinbar"   "unvereinbar"   "unvereinbar"   "abhängig"     
#> [49] "abhängig"      "abhängig"


afd_df %>% 
  filter(!is.na(sentiment_pos)) %>% 
  select(token) -> positive_sentiments

head(positive_sentiments$token, 50)
#>  [1] "optimal"         "aufstocken"      "locker"         
#>  [4] "zulässig"        "gleichwertig"    "wiederbeleben"  
#>  [7] "beauftragen"     "wertvoll"        "nah"            
#> [10] "nah"             "nah"             "überzeugt"      
#> [13] "genehmigen"      "genehmigen"      "überleben"      
#> [16] "überleben"       "genau"           "verständlich"   
#> [19] "erlauben"        "aufbereiten"     "zugänglich"     
#> [22] "messbar"         "erzeugen"        "erzeugen"       
#> [25] "ausgleichen"     "ausreichen"      "mögen"          
#> [28] "kostengünstig"   "gestiegen"       "gestiegen"      
#> [31] "bedeuten"        "massiv"          "massiv"         
#> [34] "massiv"          "massiv"          "einfach"        
#> [37] "finanzieren"     "vertraulich"     "steigen"        
#> [40] "erweitern"       "verstehen"       "schnell"        
#> [43] "zugreifen"       "tätig"           "unternehmerisch"
#> [46] "entlasten"       "entlasten"       "entlasten"      
#> [49] "entlasten"       "helfen"
```

### Anzahl der unterschiedlichen negativen bzw. positiven Wörter

Allerdings müssen wir unterscheiden zwischen der *Anzahl* der negativen bzw. positiven Wörtern und der Anzahl der *unterschiedlichen* Wörter.

Zählen wir noch die Anzahl der unterschiedlichen Wörter im negativen und positiven Fall.


```r
afd_df %>% 
  filter(!is.na(sentiment_neg)) %>% 
  summarise(n_distinct_neg = n_distinct(token))
#> # A tibble: 1 × 1
#>   n_distinct_neg
#>            <int>
#> 1             96


afd_df %>% 
  filter(!is.na(sentiment_pos)) %>% 
  summarise(n_distinct_pos = n_distinct(token))
#> # A tibble: 1 × 1
#>   n_distinct_pos
#>            <int>
#> 1            187
```

Dieses Ergebnis passt zum vorherigen: Die Anzahl der positiven Wörter (187) ist ca. doppelt so groß wie die Anzahl der negativen Wörter (96).


### Gewichtete Sentiment-Analyse

Oben haben wir nur ausgezählt, *ob* ein Term der Sentiment-Liste im Corpus vorkam. Genauer ist es, diesen Term mit seinem Sentiment-Wert zu gewichten, also eine gewichtete Summe zu erstellen.


```r
sentiment_df %>% 
  rename(token = Wort) -> sentiment_df

afd_df %>% 
  left_join(sentiment_df, by = "token") -> afd_df 

afd_df %>% 
  filter(!is.na(Wert)) %>% 
  summarise(Sentimentwert = sum(Wert, na.rm = TRUE)) -> afd_sentiment_summe

afd_sentiment_summe$Sentimentwert
#> [1] -23.9
```



```r
afd_df %>% 
  group_by(neg_pos) %>% 
  filter(!is.na(Wert)) %>% 
  summarise(Sentimentwert = sum(Wert)) %>% 
  htmlTable()
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>neg_pos</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Sentimentwert</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>neg</td>
<td style='text-align: center;'>-51.9793</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>2</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>pos</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>28.1159</td>
</tr>
</tbody>
</table><!--/html_preserve-->


Zuerst benennen wir `Wort` in `token` um, damit es beiden Dataframes (`sentiment_df` und `afd_df`) eine Spalte mit gleichen Namen gibt. Diese Spalte können wir dann zum "Verheiraten" (`left_join`) der beiden Spalten nutzen. Dann summieren wir den Sentiment-Wert jeder nicht-leeren Zeile auf. 

Siehe da: Nun ist der Duktus deutlich negativer als positiver. Offenbar werden mehr positive Wörter als negative verwendet, *aber* die negativen sind viel intensiver.


### Tokens mit den extremsten Sentimentwerten

Schauen wir uns die intensivsten Wörter mal an.


```r
afd_df %>% 
  filter(neg_pos == "pos") %>% 
  distinct(token, .keep_all = TRUE) %>% 
  arrange(-Wert) %>% 
  filter(row_number() < 11) %>% 
  dplyr::select(token, Wert) %>% 
  htmlTable()
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>token</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Wert</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>besonders</td>
<td style='text-align: center;'>0.5391</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>genießen</td>
<td style='text-align: center;'>0.4983</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>wichtig</td>
<td style='text-align: center;'>0.3822</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>sicher</td>
<td style='text-align: center;'>0.3733</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>helfen</td>
<td style='text-align: center;'>0.373</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>miteinander</td>
<td style='text-align: center;'>0.3697</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>groß</td>
<td style='text-align: center;'>0.3694</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>wertvoll</td>
<td style='text-align: center;'>0.357</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>motiviert</td>
<td style='text-align: center;'>0.3541</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>10</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>gepflegt</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.3499</td>
</tr>
</tbody>
</table><!--/html_preserve-->

```r

afd_df %>% 
  filter(neg_pos == "neg") %>% 
  distinct(token, .keep_all = TRUE) %>% 
  arrange(Wert) %>% 
  filter(row_number() < 11) %>% 
  dplyr::select(token, Wert) %>% 
  htmlTable()
```

<!--html_preserve--><table class='gmisc_table' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey;'> </th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>token</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Wert</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: left;'>1</td>
<td style='text-align: center;'>schädlich</td>
<td style='text-align: center;'>-0.9269</td>
</tr>
<tr>
<td style='text-align: left;'>2</td>
<td style='text-align: center;'>schwach</td>
<td style='text-align: center;'>-0.9206</td>
</tr>
<tr>
<td style='text-align: left;'>3</td>
<td style='text-align: center;'>brechen</td>
<td style='text-align: center;'>-0.7991</td>
</tr>
<tr>
<td style='text-align: left;'>4</td>
<td style='text-align: center;'>ungerecht</td>
<td style='text-align: center;'>-0.7844</td>
</tr>
<tr>
<td style='text-align: left;'>5</td>
<td style='text-align: center;'>behindern</td>
<td style='text-align: center;'>-0.7748</td>
</tr>
<tr>
<td style='text-align: left;'>6</td>
<td style='text-align: center;'>falsch</td>
<td style='text-align: center;'>-0.7618</td>
</tr>
<tr>
<td style='text-align: left;'>7</td>
<td style='text-align: center;'>gemein</td>
<td style='text-align: center;'>-0.7203</td>
</tr>
<tr>
<td style='text-align: left;'>8</td>
<td style='text-align: center;'>gefährlich</td>
<td style='text-align: center;'>-0.6366</td>
</tr>
<tr>
<td style='text-align: left;'>9</td>
<td style='text-align: center;'>verbieten</td>
<td style='text-align: center;'>-0.629</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: left;'>10</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>vermeiden</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>-0.5265</td>
</tr>
</tbody>
</table><!--/html_preserve-->

Tatsächlich erscheinen die negativen Wörter "dampfender" und "fauchender" als die positiven.

Die Syntax kann hier so übersetzt werden:

>    Nehmen den Dataframe adf_df UND DANN   
     filtere die Token mit negativen Sentiment UND DANN    
     lösche doppelte Zeilen UND DANN    
     sortiere (absteigend) UND DANN    
     filtere nur die Top 10 UND DANN    
     zeige nur die Saplten token und Wert UND DANN   
     zeige eine schöne Tabelle.
     
     
### Relativer Sentiments-Wert
Nun könnte man noch den erzielten "Netto-Sentiments wert" des Corpus ins Verhältnis setzen Sentiments wert des Lexikons: Wenn es insgesamt im Sentiment-Lexikon sehr negativ zuginge, wäre ein negativer Sentimentwert in einem beliebigen Corpus nicht überraschend.  
     


```r

sentiment_df %>% 
  filter(!is.na(Wert)) %>% 
  ggplot() +
  aes(x = Wert) +
  geom_histogram()
```

<img src="https://sebastiansauer.github.io/images/2017-02-21/sent_hist-1.png" title="plot of chunk sent_hist" alt="plot of chunk sent_hist" width="70%" style="display: block; margin: auto;" />

Es scheint einen (leichten) Überhang an negativen Wörtern zu geben. Schauen wir auf die genauen Zahlen.


```r
sentiment_df %>% 
  filter(!is.na(Wert)) %>% 
  dplyr::count(neg_pos)
#> # A tibble: 2 × 2
#>   neg_pos     n
#>     <chr> <int>
#> 1     neg  1818
#> 2     pos  1650
```

Tatsächlich ist die Zahl negativ konnotierter Terme etwas größer als die Zahl der positiv konnotierten. Jetzt gewichten wir die Zahl mit dem Sentimentswert der Terme, in dem wir die Sentimentswerte (die ein negatives bzw. ein positives Vorzeichen aufweisen) aufaddieren.


```r
sentiment_df %>% 
  filter(!is.na(Wert)) %>% 
  summarise(sentiment_summe = sum(Wert)) -> sentiment_lexikon_sum

sentiment_lexikon_sum$sentiment_summe
#> [1] -187
```

Im Vergleich zum Sentiment der Lexikons ist unser Corpus deutlich negativer. Um genau zu sein, um diesen Faktor:


```r
sentiment_lexikon_sum$sentiment_summe / afd_sentiment_summe$Sentimentwert
#> [1] 7.83
```

Der *relative Sentimentswert* (relativ zum Sentiment-Lexikon) beträgt also *~7.8*.


## Verknüpfung mit anderen Variablen
Kann man die Textdaten mit anderen Daten verknüpfen, so wird die Analyse reichhaltiger. So könnte man überprüfen, ob sich zwischen Sentiment-Gehalt und Zeit oder Autor ein Muster findet/bestätigt. Uns liegen in diesem Beispiel keine andere Daten vor, so dass wir dieses Beispiel nicht weiter verfolgen.




## Verweise

- Das Buch [Tidy Text Minig](http://tidytextmining.com) ist eine hervorragende Quelle vertieftem Wissens zum Textmining mit R.


[^2]: https://www.alternativefuer.de/wp-content/uploads/sites/7/2016/05/2016-06-27_afd-grundsatzprogramm_web-version.pdf

[^3]: http://www.omegahat.net/Rstem/stemming.pdf 

[^4]: https://cran.r-project.org/web/packages/wordcloud/index.html

[^5]: "parst" ist denglisch für "einlesen" von engl. "to parse"



[^99]: Dank an meinen Kollegen Karsten Lübke, dessen Fachkompetenz mir mindestens so geholfen hat wie seine Begeisterung an der Statistik ansteckend ist. 


[^120]: Ggf. benötigen Sie Administrator-Rechte, um Dateien auf Ihre Festplatte zu speichern.
