/*
 Title: ff2
 Author: nsg
 Template: post
 Permalink: /2006/10/27/ff2/
 Date: 2006-10-27T01:08:30+00:00
 Categories: Internet
*/
**v2.0**  
Om du är en firefox-användare och inte har uppfattat att version 2.0 är släppt så rekommenderar jag dig att uppdatera, dom har implementerat rättstavning direkt i webbläsaren, helt underbart, speciellt för mig som stavar fel på varannat ord :) 

För övrigt är det väll inte så mycket nytt som jag har upptäckt som jag inte redan hade plugins för, men det är skönt att det ligger i firefox nu så man slipper hundratusen plugins.

Nu när jag ändå pratar firefox så kan jag rekommendera två plugins jag hittade i går.

[**Link Alert**][1]  
Kort och gott så ändrar den muspekarens bild beroende vad länken pekar på, bild, pdf eller om det är en javascript-länk, öppna nytt fönster &#8230; helt underbart, brukar alltid bli tokig när jag trycker på de himmla mailto-länkarna, nu är problemet löst, för en förvarning om vad som kommer hända när jag trycker.  
<img id="image122" src="http://cdn.junkpile.se/2006/10/link_alert-2.jpg" alt="Visar link alert i action" />

[**JSView**][2]  
Kolla på (x)html-källkoden? Lätt, kolla på extern js eller css fil, lite bökigare, problemet är läst med detta plugin då du får en &#8220;View external &#8230;&#8221;-alternativ. Underbart.

**Edit**: Ska kanske notera att jag upptäckte en naktdel med scriptet, den tog och laddade ner sidan igen när den visade källan, det skapade mer problem och nytta, låt mig ge ett ex.

Jag är på index.php som har tagit i mot variabeln *page* med *http_post*, scriptet laddade bara index.php och fick källkoden på en helt annan sida.

Slutsatsen är nog att det inte var så bra ändå, men tanken var god.

:: Firefox, Linka Alert, JSView

<small></small>

 [1]: https://addons.mozilla.org/firefox/3199/
 [2]: https://addons.mozilla.org/firefox/2076/
