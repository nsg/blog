/*
 Title: ST2000DL003-9VT166 och CC3C
 Author: nsg
 Template: post
 Permalink: /2012/10/25/st2000dl003-9vt166-och-cc3c/
 Date: 2012-10-25T10:42:25+00:00
 Categories: Linux, Teknik, Uncategorized
 Tags: Hårddisk, raid, Seagate
*/
Jag kan dela med mig av ett fynd om jag hittade tidigare i veckan. Men först lite bakgrund.

Jag har en en RAID på min dator ([du kan läsa mer om det här][1]) som jag har haft problem med en tid. I bland när jag läste och skrev mycket från disk så ramlade först en disk, och sedan en till bort från RAID:en.

Jag trodde länge att det berode på min SATA-controller men efter att ha satt in en separat kontroller och flyttat diskarna som ingår i RAID:en till den så kunde jag utesluta det. Jag provade även att driva dem med en separat strömförsörjning för att utesluta det. Inget hjälpte och jag började misstänka dålig firmware.  
Det tog ett tag men jag hittade tillslut den här tråden på forumet för ReadyNAS:

<http://www.readynas.com/forum/viewtopic.php?f=24&#038;t=63698>

Symtomen stämde exakt med det som jag råkade ut för, diskarna slutade helt att svara. Linux kastade ut dem (block-devicen försvann) och det fick så klart MD att kasta disken. De kom inte heller tillbaka efter en reboot utan jag var tvungen att bryta strömmen.

Det var alltid samma två diskar som jag hade problem med, de var de två nya diskarna som jag köpte när jag byggde om min RAID. De heter `ST2000DL003-9VT166` och har firmware version `CC3C`. Enligt Seagates hemsida så är `CC32` senaste versionen trots att mina diskar har en senare version. Gissningsvis så blev `CC3C` så buggig så de låssas som att den inte finns.

Tydligen är det problem med både `CC32` och `CC3C` men det finns bara en fix ute för `CC3C`. Gissningsvis tycker Seagate att `CC32` är för gamla för att bry sig om.

Du hittar den uppdaterade firmwaren här under, den är bara för `CC3C` och gör bara uppdateringen om du verkligen behöver det och har problem. För mig gick det bra och jag tappade ingen data på diskarna när jag uppdaterade men ta det säkra före det osäkra och gör en backup först. Slutligen, jag har ingen aning om garantin gäller efter det här.

<https://apps1.seagate.com/downloads/certificate.html?key=156192206224>

Filen heter `BarracudaGreen-ALL-BGCC3D.zip` och har `md5: dbdc90a8c0685a1b4a62fb8b5898d5e2`  
I den ligger det en ISO (`BarracudaGreen-ALL-BGCC3D.ISO` `md5: 40ea52b5f4212c92f507297b85c85817`.

Bara att bränna ut, rycka ut alla diskar förutom den du vill uppdatera, boota och följa instruktioner på skärmen.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/H%C3%A5rddisk' rel='tag' target='_self'>Hårddisk</a>, <a class='technorati-link' href='http://bloggar.se/om/raid' rel='tag' target='_self'>raid</a>, <a class='technorati-link' href='http://bloggar.se/om/Seagate' rel='tag' target='_self'>Seagate</a>
</p></small>

 [1]: http://nsg.cc/2011/11/12/tid-for-mig-att-roja-upp-bland-min-lagring/