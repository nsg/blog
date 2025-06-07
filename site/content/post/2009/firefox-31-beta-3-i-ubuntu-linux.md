+++
date = "2009-03-20T19:17:52+00:00"
title = "Firefox 3.1 beta 3 i Ubuntu Linux"
[taxonomies]
tags = ["Beta", "Firefox", "Firefox beta", "Linux", "Ubuntu"]
+++

Jag installerade Firefox 3.1 beta 3 i förrgår för att testa weave ([läs mer här][1]), dock hittade jag inget lätt sätt att installera betan med ett paket så det blev manuellt. Jag hittade en formpost här där en användare skrev en bunt kommandon som jag använde som inspiration.

**Installera betan**

1.  Ladda ner betan, och packa upp den, du bör få en katalog som heter **firefox**, om inte så döp om den.
2.  Flytta den till /opt  
    **sudo mv /sökväg/till/firefox /opt**
3.  Ta bort, eller flytta bort plugins-katalogen  
    **sudo mv /opt/firefox/plugins /opt/firefox/plugins.backup**
4.  Länka in installerade plugins i stället  
    **sudo ln -s /usr/lib/xulrunner-addons/plugins /opt/firefox/plugins**
5.  Döp om den installerade binären till firefox.ubuntu  
    **sudo dpkg-divert --divert /usr/bin/firefox.ubuntu --rename /usr/bin/firefox**
6.  Länka in den nya binären  
    **sudo ln -s /opt/firefox/firefox /usr/bin/firefox**
7.  Spara undan en kopia av .mozilla katalogen i din hemkatalog om något går fel  
    **cp -R ~/.mozilla ~/.mozilla-stable**

Nu är det klar, starta om Firefox och betan bör öppnas. Då det fortfarande är en beta så är chansen stor att något inte funkar som det ska på ditt system, så nu kommer hur du tar bort betan och återställer.

**Ta bort betan**

1.  Ta bort länken till betan  
    **sudo rm /usr/bin/firefox**
2.  Återställ ubuntus binär  
    **sudo dpkg-divert --rename --remove /usr/bin/firefox**
3.  Ta bort de installerade filerna  
    *Hoppa över det här om du lätt vill kunna ominstallera betan, börja i så fall direkt på steg 5* när du installerar.  
    **sudo rm -r /opt/firefox**
4.  Eventuellt återställa .mozilla, om du inte har sparat några bokmärken eller andra personliga inställningar i betan så rekommenderar jag att du återställer. Annars kan du prova om det funkar först.  
    **mv ~/.mozilla ~/.mozilla-beta  
    mv ~/.mozilla-stable ~/.mozilla  
    **Beta-versionen:s .mozilla sparas som .mozilla-beta ifall du behöver den senare.

**Ett skript för att hoppa mellan betan och ubuntus firefox**

Det finns säker ett sätt för att kunna köra betan och Firefox samtidigt, men jag kunde inte lista ut hur. Vad jag där i mot visste var hur jag hoppade fram och tillbaka mellan de olika versionerna med ett par kommandon, då det är obekvämt så skrev jag ett litet skript som automatiserade det.

[ff_sw.sh][2]

Ladda ner det någon stans, t.ex. till din hemkatalog. Sätt rättigheter på filen så den går att köra genom att skriva:

*   **chmod +x ff_sw.sh**

Nu kan du köra filen genom att skriva

*   **./ff_sw.sh**

Om du kör den utan parametrar (om jag skrev ovan) så kommer du få en utskrift med de olika alternativen, just nu är de: *check*, *beta* och *stable*. Jag rekommenderar att du kör check först, den kommer kolla att allt står rätt till. Men först ska du förbereda.

Döp den .mozilla-katalogen som används till betan till **.mozilla-beta** och den för ubuntus stabila version till **.mozilla-stable**, har du installerat betan med min guide ovan så har du redan .mozilla-stable så det räcker det med att köra:

*   **mv ~/.mozilla  ~/.mozilla-beta**

Har du ingen gammal (eller ny) .mozilla-katalog så kan du göra en kopia. Nu skapar du en länk, låt oss anta att du just nu kör betan, skriv då:

*   **ln -s ~/.mozilla-beta ~/.mozilla**

Kör du stable så skriv i stället

*   **ln -s ~/.mozilla-stable ~/.mozilla**

Nu är alla förberedelserna klara och du kan köra *check* för att kolla att allt ser bra ut

*   **./ff_sw.sh check**

Sedan kan du köra

*   **./ff_sw.sh stable**

respektive

*   **./ff_sw.sh beta**

för att byta till aktuell version.

Så där, det här var ett långt och krångligt, men lärorikt! sätt att installera och hantera betan på en ubuntu-installation.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/beta' rel='tag' target='_self'>beta</a>, <a class='technorati-link' href='http://bloggar.se/om/firefox' rel='tag' target='_self'>firefox</a>, <a class='technorati-link' href='http://bloggar.se/om/firefox+beta' rel='tag' target='_self'>firefox beta</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>

 [1]: https://nsg.cc/post/2009/mozilla-weave-synkronisera-din-data/
 [2]: /images/2009/03/ff_sw.sh
