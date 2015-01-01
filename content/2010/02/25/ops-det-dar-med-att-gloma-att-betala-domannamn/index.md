/*
 Title: Ops, det där med att glöma att betala domännamn.
 Author: nsg
 Template: post
 Permalink: /2010/02/25/ops-det-dar-med-att-gloma-att-betala-domannamn/
 Date: 2010-02-25T12:52:05+00:00
 Categories: Bloggen, Personligt, Teknik, Webben
 Tags: domännamn, nsg.cc
*/
Jag har just gjort något riktigt klantigt, jag har glömt bort att förnya mitt domännamn.

Först så hade jag inte pengar på kontot och när jag väl hade det så glömde jag bort det, i måndags kom jag på det på kvällen men tänkte &#8220;äh, jag tar det i morgon&#8221;. Det skulle jag inte ha gjort för måndag var sista dagen att betala och nu ligger nsg.cc i karantän. Den ligger i karantän i mellan 30-60 dagar innan den blir ledig att registrera igen, och om jag vill &#8220;låsa upp&#8221; den innan det så kostar det mig 1000 kr. Orsaken till pengarna är för klarat som:

> Det är möjligt för vår registrar att återaktivera domännamnet åt er, men det  
> innebär en kostnad på 1000 kr plus moms. Detta på grund av att en  
> återställning innebär en avgift från respektive registry för de olika  
> toppdomänerna, samt en hel del manuellt arbete.

Att de inte avslöjar exakt när domänen släpps igen måste vara för att motivera mig som kund att betala de där 1000 kr. Jag har nu satt upp ett litet skript som skickar mig ett mail så fort den inte längre ligger i karantän, jag tvivlar även på att någon annan person kommer köpa upp domänen direkt när den blir ledig, innan jag hinner göra det. Dock den större risken är de som handlar med domäner, det är inte ovanligt att de köper domäner som är på väg ut för att prova dem och se hur mycket trafik dom de har och de använder automatiska program som köper domäner. De har goda chanser att hinna före mig. Jag tror dock att chansen att de skulle köpa min cc-domän är mycket låg.

Så frågan är snarare, klarar jag mig utan nsg.cc i upp till två månader, är det värt och betala 1000 kr? Vad kan jag köpa för de 1000 kr? Jag får väga de mot varandra lite ett tag fram över och se vad jag kommer fram till.

Kort och gott, gör inte som jag &#8230; betala domännamnen och om du inte kan betala direkt skriv upp utgångsdatumet i kalendern så du inte missar.

**Uppdatering **(2010-04-05)**  
**

I går köpte jag domänen igen, den blev ledig redan den 1:a men då jag var på landet så hade jag inte så god koll så det dröjde ett litet tag. Så det blev bara ca 5 veckor innan den försvann. För att hålla koll på domänen så skrev jag ett litet skript som skickade mig ett mail när domänen blev ledig, här kommer det om du är intresserad.

*   [check-redemption-period][1]
*   [check-pending-delete][2]

Det första (check-redemption-period) gör en whois regelbundet och skickar ett mail när frasen &#8220;Status: REDEMPTION-PERIOD&#8221; inte längre finns med, efter det gjorde jag en kopia och gjorde samma sak med PENDING-DELETE. Utskriften på en whois skiljer sig en del mellan domäner så skriptet kommer nog inte funka för dig men du kan använda det som inspiration om du vill ha något liknande. Skriptet bör funka på alla unix och unixliknande system, som t.ex. Linux och OSX. Eventuellt med mindre ändringar.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/dom%C3%A4nnamn' rel='tag' target='_self'>domännamn</a>, <a class='technorati-link' href='http://bloggar.se/om/nsg.cc' rel='tag' target='_self'>nsg.cc</a>
</p></small>

 [1]: http://nsg.cc/wp-content/uploads/2010/02/check-redemption-period
 [2]: http://nsg.cc/wp-content/uploads/2010/02/check-pending-delete