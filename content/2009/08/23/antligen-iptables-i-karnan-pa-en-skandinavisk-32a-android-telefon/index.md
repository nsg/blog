/*
 Title: Äntligen iptables i kärnan på en skandinavisk 32A android-telefon
 Author: nsg
 Template: post
 Permalink: /2009/08/23/antligen-iptables-i-karnan-pa-en-skandinavisk-32a-android-telefon/
 Date: 2009-08-23T15:49:59+00:00
 Categories: Android, Linux, Teknik
 Tags: Android, Cyanogen, htc, htc magic, Linux, magic
*/
En av orsakerna att köpa min telefon var att jag skulle kunna ersätta mitt mobila bredband, jag har kört med Azilink hittils för att uppfylla det och det har funkat även om det har varit lite buggigt. I bland har den kopplat ifrån och jag har varit tvungen att starta om azilink, och så har telefonen förvandlats till en sladdtelefon när jag kom hem (då den satt fast i datorn med USB-kabeln).

Du kan läsa minna två tidigare inlägg om ämnet:  
[Använd din android/HTC magic som modem][1]  
[Anslut automatiskt med AziLink och Android][2]

Jag har länge väntat på att HTC ska släppa sin modifierade kärnas källkod så folk själv kunde kompilera egna kärnor som bootade på våra 32A-telefoner. Källkoden som kommer från Google, d.v.s. ren Android hänger sig när man försöker boota den på en 32A. Har man dock en 32B som säljs i USA, stora delar av Europa och övriga världen så var det inget problem då den körde ren Android utan problem.

Det som hände i stället var att [en person på forumet xda-developers][3] listade ut vad skillnaden var och byggde en kärna som bootade. Koden har nu börjat spridas och hemmabyggda ROM:ar (installationer av Android) har börjat dyka upp. Jag provade en ROM som heter [Cyanogen][4] som innehåll mycket intressant, förutom den nya kärnan så har den massa förbättringar som kommer från Donut, d.v.s. nästa version av Android som inte är släppt än.

Vill du prova Cyanogen på en telefon av typen 32A, gå till den här länken:  
<http://www.swedroid.se/forum/showthread.php?t=1414>

Där hittar du en fil som heter signed-cyanm-4.0.1_gbo-32a.zip, notera &#8220;gbo&#8221;. Det är den som innehåller den nya kärnan.

Vill du prova? Du hittar bra guider på [Swedroids wiki][5], notera att du INTE behöver röra SPL:en för att lägga in den här ROM:en då den är signerad.

För ett tag sedan provade jag den nya kärnan med [android-wifi-tether][6], allt funkade perfekt. Ett trådlöst nätverk skapades som det bara var att ansluta till, det kan inte vara enklare. Nu kan jag använda min telefon som modem så länge den är i lägenheten, jag kan svara, går runt med den och prata, sitta och leka med den utan att sladden är i vägen o.s.v. &#8230; en enorm förbättring. Att det sedan inte kräver någon konfiguration på datorn gör att man enkelt kan starta ett wlan någon annan stans och dela med sig till någon kompis om man skulle vilja.

Nu väntar jag bara på skype, en bra twitterklient (inte hittat någon som funkar som jag vill) och en bra facebook-applikation (som funkar som jag vill) så är jag nöjd (ett litet tag) :) 

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Android' rel='tag' target='_self'>Android</a>, <a class='technorati-link' href='http://bloggar.se/om/Cyanogen' rel='tag' target='_self'>Cyanogen</a>, <a class='technorati-link' href='http://bloggar.se/om/htc' rel='tag' target='_self'>htc</a>, <a class='technorati-link' href='http://bloggar.se/om/htc+magic' rel='tag' target='_self'>htc magic</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/magic' rel='tag' target='_self'>magic</a>
</p></small>

 [1]: ../2009/07/22/anvand-din-androidhtc-magic-som-modem/
 [2]: ../2009/08/02/anslut-automatiskt-med-azilink-och-android/
 [3]: http://forum.xda-developers.com/showthread.php?t=548061
 [4]: http://forum.xda-developers.com/showthread.php?t=537204
 [5]: http://www.swedroid.se/wiki/index.php/Huvudsida
 [6]: http://code.google.com/p/android-wifi-tether/