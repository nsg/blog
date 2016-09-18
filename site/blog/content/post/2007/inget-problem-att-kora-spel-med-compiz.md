+++
date = "2007-07-25T17:39:46+00:00"
title = "Inget problem att köra spel med compiz"
+++

För ca en månad sedan så bestämde jag mig för att börja spela spelet [Eve Online][1], jag hade spelat det för något år sedan med slutade till huvudsak att jag oftast tyckte det var jobbigt att behöva starta om datorn för att starta Windows för att kunna spela det. Jag spelade det mindre och mindre och tyckte tillslut att det inte var värt och betala för längre.

För en månad sedan så bestämde jag mig för att göra ett försök igen, men nu med [Cedega][2]. Cedega är en kommersiell vidareutveckling av delar av programmet [Wine][3] som är en implementation av delar av windows så man kan köra en del windowsprogram under Unix (Linux, *BSD, OSX, &#8230;), det funkar sådär då det är långt från klart och då microsoft lägger till nya saker i sin ända så tvivlar jag på att dom någonsin kommer ikapp, men det är mycket användbart på en del program som funkar bra.

[<img src="/images/2007/07/expo.thumbnail.png" title="expo.png" alt="expo.png" align="left" height="128" width="160" />][4]Cedega har skrivit några egna delar som dom säljer, skillnaden mot Wine är att mycket mer program funkar, framför allt spel och då dom tar betalt så har dom resurser och arbeta på populära spel. Jag bestämde mig för att prova att köra Eve Online under Cedega och det funkade perfekt, jag har bara haft två problem, det kraschar när jag byter upplösning i spelet men då man gör det en gång och den kraschar efter att den sparade ändringen så är det egentligen inget problem. Nästa var att ljudet var lite raspigt, men det gick och lösa med att byta från ALSA till OSS. Inget problem heller. Så nu är det bara och starta som vilket spel som helst.

Ni som följt bloggen en del vet säkert att jag kör [Gentoo Linux][5], men den senaste tiden har jag känt att jag inte har ork och hålla på och kompilera, konfigurera och stöta på lite problem då och då. Egentligen gillar jag Gentoo, jag gillar att hålla på och peta och det första jag öppnar i ett nytt program är inställningarna och läser igenom allt. Men då jag inte har haft ork så bestämde jag mig för att prova [Ubuntu][6] ett tag istället. Då jag har gott om ledig plats på en hårddisk så installerade jag Ubuntu där så om jag ångrar mig så tar det bara några sekunder och byta tillbaka.

Under Gentoo körde jag inte längre [Beryl/Compiz][7] även om jag nu har ett nvidia-kort och det skulle fungera perfekt, men Compiz hängde sig bara när jag startade det och då jag som jag nämnde tidigare inte hade ork och hålla på strula så fick det va.

<img src="/images/2007/07/cpu-graph.thumbnail.png" title="cpu-graph.png" alt="cpu-graph.png" align="right" height="23" width="102" />Under Ubuntu så är det en barnlek och få i gång, så självklar så kör jag Compiz(-fusion) nu, det funkar perfekt och har inte märkt några större problem, men i dag kom det riktig testet, skulle Eve Online funka och köra tillsammans med Compiz. Antingen skulle det inte funka alls, eller kanske Compiz skulle bli jätteseg, nej, inget av de hände, visst lite segare är det att snurra på kuben då grafikkortet är upptagen med spelet, men det är helt användbart.

[<img src="/images/2007/07/scale.thumbnail.png" title="scale.png" alt="scale.png" align="right" height="128" width="160" />][8]Dock så märkte jag en sak, att köra igång ett OpenGL program samtidigt som Eve Online var startat var igen bra ide, Compix började att blanda ihopp program och muspekaren levde sitt eget liv, var tvungen att starta om Xorg (ctrl-alt-backspace). Det finns en del buggar kvar, inte att glömma bort att Compiz är fortfarande inte helt klart.

Jag tog tre skärmbilder, en på min cpu där du ser minna två kärnor, man ser tydligt hur spelet belastar en åt gången, jag undrar om det hade funkat lika bra om jag bara hade haft en kärna, svårt och veta. Slutligen två där man ser spelet hur det körs tydligt på ett skrivbord.

Slutligen spelade jag även in en video, den flimrar lite men det är programmet som jag spelade in meds fel, på skärmen flöt och såg det perfekt ut.

  
:: Linux, Compiz, Gentoo, Ubuntu, Cedega, Wine, Eve, Eve Online, Spel

<small></small>

 [1]: http://eve-online.com
 [2]: http://www.cedega.com/
 [3]: http://www.winehq.org/
 [4]: /images/2007/07/expo.png "Direct link to file"
 [5]: http://www.gentoo.org
 [6]: http://www.ubuntu.com
 [7]: http://junkpile.se/~s/wp/2006/12/beryl/
 [8]: /images/2007/07/scale.png "Direct link to file"
