+++
date = "2009-08-02T02:01:43+00:00"
title = "Anslut automatiskt med AziLink och Android"
tags = ["Android", "azid", "Google Calendar", "Linux", "snotify"]
+++

<img class="alignright size-medium wp-image-731" title="android-shot" src="http://cdn.junkpile.se/2009/08/android-shot-300x92.png" alt="android-shot" width="300" height="92" />I mitt förra inlägg &#8220;[Använd din android/HTC magic som modem][1]&#8221; skrev jag hur du konfigurerade och satte upp en lösning för att använda en skandinavisk android-telefon som modem, jag sa att jag skulle bygga en lösning för att förenkla saker, och här kommer det.

Jag har skrivit ett par små skript som heter Azid, de reagerar när du kopplar in telefonen och gör att nödvändigt för att du ska bli uppkopplad (föresatt att AziLink körs på telefonen). Skripten har ingen ting med installationen att göra utan är för att förenkla vardagen när du väl har konfigurerar upp saker.

### SNotify

Som du ser på bilden så använder jag mig av notifikationssystemet för att meddela händelser, då skriptet bitvis körs av systemet som root så har jag skrivit att litet hjälpskript som heter snotify för att arbeta mig runt lite problem, azid använder det mycket så du behöver ha det installerat. Du kan ladda ner det här: [snotif][2], jag föresätter att det ligger i katalogen  /opt/snotify men det går att placera på andra ställen, du kan dock behöva ändra lite sökvägar.

För att göra ovanstående, skriv:

> sudo mkdir /opt/snotify  
> sudo wget http://cdn.junkpile.se/2009/08/snotify -O /opt/snotify/snotify  
> sudo chmod +x /opt/snotify/snotify

SNotify behöver även en konfgurationsfil, den ligger under /etc och kan laddas ner här: [snotif][3] och ska heta snotify.

För att göra ovanstående, skriv:

> sudo wget http://cdn.junkpile.se/2009/08/snotify1 -O /etc/snotify

Konfigurationsfilen föresätter att du kör Gnome och att du är den enda användaren som är inloggad grafiskt. Med största sannolikhet är du det, och övriga inställningar behöver du förmodligen inte ändra.

För att skriptet ovan ska funka behöver du installera ett litet program som heter libnotify-bin

> sudo apt-get install libnotify-bin

### Azid

Nu är det dax att installera Azid, tekniken är den samma som med SNotify. Skillnaden är att det är flera filer i /opt/azid så jag har packat ihop dem i ett paket, du kan ladda ner det här: [azid.tar][4].  
Konfigurationsfilen finns här: [azid][5]

För att göra ovanstående, skriv:

> wget http://cdn.junkpile.se/2009/08/azid.tar  
> sudo tar xf azid.tar -C /  
> sudo chmod +x /opt/azid/azi  
> sudo chmod +x /opt/azid/azid  
> sudo wget http://cdn.junkpile.se/2009/08/azid -O /etc/azid

Du kan kolla i konfigurationsfilen (/etc/azid) om det är några inställningar du behöver göra, inställningarna som de är bör funka fint. Två saker som du kanske vill ändra på är DNS\_TYPE, nu är opendns satt då jag tyckte att operatörens DNS:er var långsamma, för att köra de vanliga ändra den till default. Den andra är START\_AZID, när azid inte får kontakt med telefonen så varnar den 1 gång/minut. Det är så jag vill ha det, irriterar det dig så stäng av det genom att sätta den till false.

### Få allt att köras

Nu är det bara att få saker att köras automatiskt när du stoppar in telefonen kvar, det gör du genom att ändra lite på udev-regeln vi skriv i mitt tidigare inlägg, ändra den till:

> <small>SUBSYSTEM==&#8221;usb&#8221;,SYSFS{idVendor}==&#8221;0bb4&#8243;,ATTR{idProduct}==&#8221;0c02&#8243;,SYMLINK+=&#8221;android_adb&#8221;,MODE=&#8221;0666&#8243;,RUN+=&#8221;/opt/azid/azi&#8221;</small>  
> <small>SUBSYSTEM==&#8221;usb&#8221;,SYSFS{idVendor}==&#8221;0bb4&#8243;,ATTR{idProduct}==&#8221;0c01&#8243;,SYMLINK+=&#8221;android_fastboot&#8221;,MODE=&#8221;0666&#8243;</small>

Skillnaden är *,RUN+=&#8221;/opt/azid/azi&#8221;* i slutet på första raden.

### Slutligen

### [<img class="alignright size-medium wp-image-730" title="azilink-shot" src="http://cdn.junkpile.se/2009/08/azilink-shot-300x93.png" alt="azilink-shot" width="300" height="93" />][6]

Nu bör saker köras när du stoppar in telefonen, du bör se första bilden nästan direkt när du stoppat in sladden och efter några sekunder en bild liknande den här bredvid (dock inte samma text, jag har ändrat den).

Funkar det inte så hör av dig, chansen är ganska stor att något fel har smugit sig ner då koden inte är så testad. Glöm inte att stätta på AziLink på telefonen först innan du börjar.

Jag har märkt att ibland hakar saker upp sig, det är inget jag har kontroll över från datorn utan felet ligger i android eller AziLink, du kan prova att dra ut och sätta in USB-kabeln igen, och/eller starta om AziLink. Oftast räcker det med kabeln.

Även om det är ganska smidigt som det är nu så vill jag mycket hellre dela med mig av uppkopplingen via det trådlösa nätverket, [i det här inlägget på xda-developers][7] så har en haft kontakt med HTC, enligt dem skulle deras modifierade kärna vara ute vid slutet av månaden (i förrgår), så kanske snart så :) 

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Android' rel='tag' target='_self'>Android</a>, <a class='technorati-link' href='http://bloggar.se/om/azid' rel='tag' target='_self'>azid</a>, <a class='technorati-link' href='http://bloggar.se/om/google+calendar' rel='tag' target='_self'>google calendar</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/snotify' rel='tag' target='_self'>snotify</a>
</p></small>

 [1]: http://nsg.cc/2009/07/22/anvand-din-androidhtc-magic-som-modem/
 [2]: http://cdn.junkpile.se/2009/08/snotify
 [3]: http://cdn.junkpile.se/2009/08/snotify1
 [4]: http://cdn.junkpile.se/2009/08/azid.tar
 [5]: http://cdn.junkpile.se/2009/08/azid
 [6]: http://cdn.junkpile.se/2009/08/azilink-shot.png
 [7]: http://forum.xda-developers.com/showpost.php?p=4210093&postcount=52
