---
author: Sebastian Sauer
date: '2017-01-11'
title: R startet nicht
tags:
  - rstats
  - German
slug: R_startet_nicht
---


Hilfe! Mein R startet nicht! Mein R startet zwar, tut aber nicht so, wie ich will. Sicherlich hat es sich (wieder einmal) gegen mich verschworen. Wahrscheinlich hilft nur noch Verschrotten... Bevor Sie zum äußersten schreiten, hier einige Tipps, die sich bewährt haben.


# Lösungen, wenn R nicht (richtig) läuft

- AEG: Aus. Ein. Gut. Starten Sie den Rechner neu. Gerade nach Installation neuer Software zu empfehlen.

- Sehen Sie eine Fehlermeldung, die von einem fehlenden Paket spricht (z.B. "Package 'Rcpp' not available") oder davon spricht, dass ein Paket nicht installiert werden konnte (z.B. "Package 'Rcpp' could not be installed" oder "es gibt kein Paket namens ‘Rcpp’" oder "unable to move temporary installation XXX to YYY"), dann tun Sie folgendes:

  - Schließen Sie R und starten Sie es neu.
  - Installieren Sie das oder die angesprochenen Pakete mit `install.packages("name_des_pakets", dependencies = TRUE)` oder mit dem entsprechenden Klick in RStudio.
  - Starten Sie das entsprechende Paket mit `library(paket_name)`.

- Gerade bei Windows 10 scheinen die Schreibrechte für R (und damit RStudio oder RComannder) eingeschränkt zu sein. Ohne Schreibrechte kann R aber nicht die Pakete ("packages") installieren, die Sie für bestimmte R-Funktionen benötigen. Daher schließen Sie R bzw. RStudio und suchen Sie das Icon von R oder wenn Sie RStudio verwenden von RStudio. Rechtsklicken Sie das Icon und wählen Sie "als Administrator ausführen". Damit geben Sie dem Programm Schreibrechte. Jetzt können Sie etwaige fehlende Pakete installieren.

- Ein weiterer Grund, warum R bzw. RStudio die Schreibrechte verwehrt werden könnnten (und damit die Installation von Paketen), ist ein Virenscanner. Der Virenscanner sagt, nicht ganz zu Unrecht, "Moment, einfach hier Software zu installieren, das geht nicht, zu gefährlich". Grundsätzlich gut, in diesem Fall unnötig. Schließen Sie R/RStudio und schalten Sie dann den Virenscanner komplett (!) aus. Öffnen Sie dann R/RStudio wieder und versuchen Sie fehlende Pakete zu installieren.

- Läuft der RCommander unter Mac nicht, dann prüfen Sie, ob Sie X11 installiert haben. X11 muss installiert sein, damit der RCommander unter Mac läuft.

- Die "app nap" Funktion beim Mac kann den RCommander empfindlich ausbremsen. Schalten Sie diese Funktion aus z.B. im RCommander über `Tools - Manage Mac OS X app nap for R.app`.



# Allgemeine Hinweise zur Denk- und Gefühlswelt von R

- Wenn Sie RStudio starten, startet R automatisch auch. Starten Sie daher, wenn Sie RStudio gestartet haben, *nicht* noch extra R. Damit hätten Sie sonst zwei Instanzen von R laufen, was zu Verwirrungen (bei R und beim Nutzer) führen kann.

- Ein neues R-Skript im RStudio können Sie z.B. öffnen mit `File-New File-R Script`.

- R-Skripte können Sie speichern (`File-Save`) und öffnen.

- R-Skripte sind einfache Textdateien, die jeder Texteditor verarbeiten kann. Nur statt der Endung `txt`, sind R-Skripte stolzer Träger der Endung `R`. Es bleibt aber eine schnöde Textdatei.

- Bei der Installation von Paketen mit `install.packages("name_des_pakets")` sollte stets der Parameter `dependencies = TRUE` angefügt werden. Also  `install.packages("name_des_pakets", dependencies = TRUE)`. Hintergrund ist: Falls das zu installierende Paket seinerseits Pakete benötigt, die noch nicht installiert sind (gut möglich), dann werden diese sog. "dependencies" gleich mitinstalliert (wenn Sie  `dependencies = TRUE` setzen).

- Hier finden Sie weitere Hinweise zur Installation des RCommanders: <http://socserv.socsci.mcmaster.ca/jfox/Misc/Rcmdr/installation-notes.html>.

- Sie müssen online sein, um Packages zu installieren.

- Die "app nap" Funktion beim Mac kann den RCommander empfindlich ausbremsen. Schalten Sie diese Funktion aus z.B. im RCommander über `Tools - Manage Mac OS X app nap for R.app`.


# Sei aktuell

- Verwenden Sie möglichst die neueste Version von R, RStudio und Ihres Betriebssystems. Ältere Versionen führen u.U. zu Problemen; je älter, desto Problem...

- Updaten Sie Ihre Packages regelmäßig z.B. mit `update.packages()` oder dem Button "Update" bei RStudio (Reiter `Packages`).

# Sei milde
R zu lernen kann hart sein. Ich weiß, wovon ich spreche. Wahrscheinlich eine spirituelle Prüfung in Geduld und Hartnäckigkeit... Tolle Gelegenheit, sich in diesen Tugenden zu trainieren :-)


