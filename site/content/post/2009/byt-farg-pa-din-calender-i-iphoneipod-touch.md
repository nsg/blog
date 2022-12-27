+++
date = "2009-02-10T16:09:51+00:00"
title = "Byt färg på din calender i iPhone/iPod touch"
tags = ["Google", "Google Calendar", "iphone", "ipod", "ipod touch", "Nuevasync", "Touch"]
+++

Jag är en glömsk person och utan min kalender hade jag glömt bort de flesta sakerna jag skulle på. För nu snart ett år sedan så köpte jag en iPod touch, till en början var kalendern på den ganska meningslös, då det inte fanns något sätt att synkronisera den med min Google Calendar men efter att jag hittade tjänsten [Nuevasync][1] så har det inte varit ett problem längre. För inte så länge sedan så fick dom stöd för att visa de olika kalendrarna i olika färger, innan visades de som en kalender. Bra, dock ett problem &#8230; färgerna stämde inte alls med de jag var van vid i Google Calendar.

Jag satte mig ner och Googlade lite, jag hittade ett [blogginlägg][2] som tog upp två sätt för att lösa det, båda krävde dock att jag hade tillgång till saker jag inte har, mobile me eller iTunes  (ja, jag har tillgång till det, men det ligger i en virtuell maskin på min dator som jag ogärna startar). Lösningen hittade jag i en kommentar på inlägget.

Du behöver en jailbreak:ad enhet, med en ssh-server på så du kan ssh:a in till den. Det är ingen lösning som är enkel för en som inte är så insatt, så jag utgår från att du kan det grundläggande. Vill du ha en bättre förklaring så skriv en kommentar.

Som mycket annat på enheten så finns saker sparade i en SQLite-databas, även kalenderinformationen som innehåller färgerna. Databasen heter **Calendar.sqlitedb** och ligger i **/var/mobile/Library/Calendar**. Bara att kopiera till din dator och editera, eller gör det direkt på din enhet om du har &#8220;sqlite3&#8243; installerat på den.

> sqlite3 Calendar.sqlitedb

Du kan göra följade fråga för att se vad som finns:

> select title, color\_r, color\_g, color_b from calendar;

Färgerna är sparade i RGB, du hittar ett sätt att konvenera från hex [här][3].  
Nu är det bara och uppdatera färgerna med en fråga

> update Calendar set color\_r=226, color\_g=0, color_b=118 where title=&#8217;Kongl. Datasektionen*&#8217;;

Sådär, nu har jag en fin cerise kalender precis som i min Google Calendar, nu är det bara att kopiera tillbaka filen (om du inte gjorde ändringen på enheten), se även till så att mobile äger den.

Klart, nu ska jag spendera en 10-15 minuter och uppdatera minna andra kalendrar till rätt färg.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/google' rel='tag' target='_self'>google</a>, <a class='technorati-link' href='http://bloggar.se/om/google+calendar' rel='tag' target='_self'>google calendar</a>, <a class='technorati-link' href='http://bloggar.se/om/iphone' rel='tag' target='_self'>iphone</a>, <a class='technorati-link' href='http://bloggar.se/om/ipod' rel='tag' target='_self'>ipod</a>, <a class='technorati-link' href='http://bloggar.se/om/ipod+touch' rel='tag' target='_self'>ipod touch</a>, <a class='technorati-link' href='http://bloggar.se/om/Nuevasync' rel='tag' target='_self'>Nuevasync</a>, <a class='technorati-link' href='http://bloggar.se/om/touch' rel='tag' target='_self'>touch</a>
</p></small>

 [1]: http://www.nuevasync.com/
 [2]: http://www.touchtip.com/iphone-and-ipod-touch/quick-tip-calendar-color-fix-for-iphone-and-ipod-touch/
 [3]: http://www.javascripter.net/faq/hextorgb.htm
