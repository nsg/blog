+++
date = "2007-10-05T19:35:00+00:00"
title = "Att installera 3:s mobila bredband i Ubuntu"
[taxonomies]
tags = ["bredband", "internet", "tre"]
+++

<p style="padding-left: 30px; border: 1px solid black; background: #C3FFC8">
  <strong>Det här är ett gammalt inlägg från 2007, i dag räcker det med att stoppa in sladden. En dialog kommer upp och ber dig välja vilken operatör du har. Nu är det klart. För att ansluta/konfigurera använd <a href="http://en.wikipedia.org/wiki/Network_Manager">Network Manager</a>.</strong>
</p>

Tidigare skrev [jag ett inlägg][1] där jag visade hur du anslöt ett Huawei E200-modem i linux, men då nästan allt skedde i konsol då kommer nu ett mera grafiskt sätt och göra det samma, får du problem så kolla på de andra inlägget då det innehåller lite mer information.

Guiden är skriven utifrån att du kör Ubuntu 7.04 (Feisty Fawn), har du en äldre version så kommer det inte funka lika smärtfritt, googla för mer info. Det borde gå utan något problem i andra linux-distributioner men mindre skillnader kan förekomma.

> Uppdaterat 2007-11-09  
> Notera att du kan behöva installera ett program för att få det att funka, eventuellt  ändra i configurationsfilen /etc/wvdial.conf, se i min mer [avancerade &#8220;text-guide&#8221;][1] för mer information.

<img title="screenshot3.png" src="/images/2007/10/screenshot3.png" alt="screenshot3.png" align="left" />Det första du vill göra är att plocka bort pin-koden från sim-kortet, det går att ha kvar den men det blir mycket enklare utan den. Du tar enklast bort den genom att installera modemet i en windows-installation och med hjälp av programmet stänga av kollen. Har du inte windows tillgängligt så kan du stoppa in simkortet i en mobiltelefon och göra samma sak där.

Något är fel som gör att modemet bara funkar om det redan är i datorn när den startar, jag hoppas att det kommer vara fixat i nästa version av ubuntu som nu snart kommer.

Jag ansluter nu med GNOME PPP (gnome-ppp) som gör samma sak som wvdial i förra inlägget, tyvärr så verkar det inte följa med ubuntu så om du sitter utan uppkoppling så får du klara dig med wvdial första gången tills du laddat ner gnome-ppp.

När du startar gnome-ppp så möter du ett fönster som frågar efter användarnamn, lösenord och telefonnummer. Skriv vad du vill som användarnamn och lösenord med telefonnumret ska vara **\*99\***1#**, klicka nu på Setup och fyll enligt bilden här under. Resten behöver du inte ändra. Klicka nu bara på Close och sedan Connect.

Funkar allt som det ska så borde du efter ett tag vara uppkopplad, funkar det inte första gången så försök några gånger till för att vara säker att det inte funkar. För lite felsökning gå till förra inlägget, annars få du googla själv.

![screenshot4.png][2]



<small></small>

 [1]: http://junkpile.se/~s/wp/2007/10/huawei-e2200-hsdpa/
 [2]: /images/2007/10/screenshot4.png "screenshot4.png"
