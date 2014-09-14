/*
 Title: Problem med r8169, Linux och att du inte få en länk?
 Author: nsg
 Template: post
 Permalink: /2011/03/24/problem-med-r8169-linux-och-att-du-inte-fa-en-lank/
 Date: 2011-03-24T18:25:07+00:00
 Categories: Linux, Teknik
 Tags: Linux, r8169, ubuntu
*/
*Chansen är liten att ni har det här problemet, ärlig talat skriver jag ner det mest för mig själv för framtida bruk men om någon där ute har problemet så kan jag dela med mig lite.*

Har du ett nätverkskort på din dator av typ r8169 och kör Linux, du har problem med att du inte får en länk så är lösningen ganska enkel.

Problemet uppenbarar sig med att du regelbundet tappar kontakten med nätet i några sekunder, du hittar även en mängd med &#8220;link up&#8221; i /var/log/messages.

I mitt fall är problemet att jag har även Windows installerat, när man stänger av Windows så stänger Windows av kortet för att slå av funktionen Wake-On-Lan. I Windows funkar det bra då drivrutinen slår på kortet när man startar Windows, men drivrutinen i Linux kan inte göra det.

I väntan på att någon förbättrar drivrutinen i Linux så löses problemet enklast med att slå på &#8220;Wake-on-lan after shutdown&#8221; i Windows, då lämnas kortet i fred och allt funkar.

Har du inte Windows installerat längre, eller vill du inte starta det i onödan så kan du manuellt återställa kortet genom att stänga av datorn och dra ut sladden och lämna det så 10-15 sekunder.

[Mer information på Ubuntus forum][1]

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/r8169' rel='tag' target='_self'>r8169</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>

 [1]: http://ubuntuforums.org/showthread.php?t=538448