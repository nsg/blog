+++
date = "2008-05-31T16:33:27+00:00"
title = "Facebook Chat i Pidgin"
[taxonomies]
tags = ["facebook", "chat", "pidgin", "plugin"]
+++

<img src="/images/2008/05/screenshot19.png" title="screenshot19.png" alt="screenshot19.png" align="left" />Det har funnits i [Adium][1] nu ett tag så nu är det [Pidgins][2] tur att stödja [Facebook][3]

Jag pratar inte (ännu) om något som funkar direkt genom att ha senaste versionen, nej du måste ladda ner och installera ett pluggin själv. Men det är enkelt, tog mig bara en minut.

Du ska dock tänka på att Facebook använder sitt eget hemmabyggda protokoll så räkna med problem. Men ger vi det tillräckligt med tid så kommer nog en stabil version komma som byggs in i Pidgin direkt tillsammans med ICQ, MSN, Google Talk, &#8230;

Ett alternativ (som vore bättre) var om Facebook tog förnuftet till vetta och satte upp en [XMPP][4]-server, det är en trevlig öppen standard som Pidgin redan stödjer och det är orsken varför Google Talk funkar så fint i Pidgin (Ja, Google kör XMPP).

[Här kommer länken][5]

Det finns bra instruktioner hur det installeras på sidan men drar de lite snabbt här hur du kan göra det i Ubuntu:

**Ändrat 2008-06-14  
Utvecklingen går snabbt, lättare installation finns, för mer information se längre ner.**

*   Ladda ner facebook_icons.zip och libfacebook-1.9.so (Välj &#8220;libfacebook64-1.9&#8243; om du kör 64-bit, finns det en nyare version än 1.9, välj då den.)
*   Flytta facebook_icons.zip till /usr/share/pixmaps/pidgin/protocols, t.ex. &#8220;**sudo mv ~/Desktop/facebook_icons.zip /usr/share/pixmaps/pidgin/protocols**&#8221; gå sedan till katalogen &#8220;**cd  /usr/share/pixmaps/pidgin/protocols**&#8221; och packa upp filen &#8220;**sudo unzip** **facebook_icons.zip**&#8220;, klart nu städar vi upp lite efter oss med &#8220;**sudo rm facebook_icons.zip**&#8220;
*   Flytta libfacebook till ~/.purple/plugins/, börja med att skapa katalogen (om den inte redan finns) med &#8220;**mkdir -p ~/.purple/plugins/**&#8220;och flytta sedan in filen dit med t.ex. &#8220;**mv ~/****Desktop/libfacebook-1.9.so ~/.purple/plugins/**&#8220;, nu gör den körbar med t.ex. &#8220;**chmod +x ~/.purple/plugins/libfacebook-1.9.so**&#8220;
*   Klart, nu bör Facebook finnas med som ett alternativ under kontohanteringen i Pidgin, bara att lägga till och fylla i dinna uppgifter.

Hur bra funkar det nu, sådär. Jag har åkt ut några gånger nu, det verkar som att jag tappar kontakten efter 10-15 minuter, så det är någon bugg som behöver fixas. Sedan kollar den inte så ofta när folk loggar in/ut men på den punkten är inte Facebooks egen chat så mycket bättre.

Jag ska experimentera lite nu och se vad som händer om jag loggar in på facebook under tiden. Återkommer om jag hittar något intressant.

**Ändrat 2008-06-14**  
Som jag skrev så testade jag det lite, det var ganska jobbigt att jag tappade kontakten hela tiden men det som fick mig att sluta använda det var att Pidgin kraschade lite då och då. Sedan kan jag passa på att påpeka att facebook (webbsidan) kunde man ibland bli lite spontant utloggad ifrån.

Jag kollade i dag och såg att version 1.15 fanns, och nu även som en .deb så det är nu superlätt och installera. Jag ska prova den senaste versionen nu i dag så får vi se om den är användbar nu.



<small></small>

 [1]: http://www.adiumx.com/
 [2]: http://pidgin.im/
 [3]: http://www.facebook.com
 [4]: http://en.wikipedia.org/wiki/XMPP
 [5]: http://code.google.com/p/pidgin-facebookchat/
