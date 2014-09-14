/*
 Title: Det är inte alltid bäst att köra paketen från dist.
 Author: nsg
 Template: post
 Permalink: /2011/07/10/det-ar-inte-alltid-bast-att-kora-paketen-fran-dist/
 Date: 2011-07-10T00:41:06+00:00
 Categories: Bloggar, Bloggen, Personligt, Teknik
 Tags: debian, ubuntu, wordpress
*/
Suck &#8230; jag installerade WordPress med hjälp av pakethanteringsverktyget, jag trodde det skulle vara en bra idé då det skulle vara smidigt att sätta upp och få det att funka, samt det skulle vara enkelt att uppdatera då bloggen uppdaterades tillsammans med resten av systemet.

Så var INTE fallet, till och börja med fick jag en gammal version som var tråkigt. Den var rätt krånglig att sätta upp, jag importerade inläggen från gamla installationen med WordPress eget verktyg och nu funkade inte bilderna, krävde en del manuellt pill.

Vid det här laget hade jag inte gett upp än, det kändes fortfarande som en god idé att lösa mina problem för att sedan en installation som var lätt och uppdatera.

Sedan hände det, jag började skriva ett inlägg och noterade att jag inte kunde lägga till bilder. Efter en del sökande kom jag fram till att det berodde på att Debian folket hade bestämt att spara plats genom att länka in tillägg från separat installerade paket i stället för de som kommer med WordPress. Det verkar bra i teorin men i det här fallet så råkade vi ut för någon inkompatibilitet. Det var droppen, även om jag fixade den här buggen så visste jag inte hur många fler som fanns, och om det kommer uppstå nya i framtiden.

Du kör jag senaste WordPress i stället, manuellt installerat och upp konfigurerat. Allt funkar som det ska, inga problem alls.

Något att tänka på, om det är nu så rekommenderar jag INTE WordPress paketet som finns i Debian/Ubuntu.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/debian' rel='tag' target='_self'>debian</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>, <a class='technorati-link' href='http://bloggar.se/om/wordpress' rel='tag' target='_self'>wordpress</a>
</p></small>