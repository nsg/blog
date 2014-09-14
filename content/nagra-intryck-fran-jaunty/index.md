/*
 Title: Några intryck från Jaunty
 Author: nsg
 Template: post
 Permalink: /2009/04/25/nagra-intryck-fran-jaunty/
 Date: 2009-04-24T22:36:09+00:00
 Categories: Personligt, Teknik
 Tags: gnome, jaunty jackalope, Linux, notifyosd, ubuntu
*/
<p style="text-align: center;">
  <a href="http://nsg.cc/wp-content/uploads/2009/04/desktop.png"></a><a href="http://nsg.cc/wp-content/uploads/2009/04/desktop1.png"><img class="aligncenter size-full wp-image-110" title="desktop1" src="http://nsg.cc/wp-content/uploads/2009/04/desktop1.png" alt="desktop1" width="700" height="118" /></a>
</p>

Sådär, det är en del kvar att göra innan jag känner mig nöjd med Jaunty, men det känns bra, har inte haft några större problem och den enda irritationen löste jag just (efter att ha suttit och läst på ubuntus bugtracker i ca ~30 minuter).

Problemet som jag hade var att det nya notifikationssystemet som används för att visa information som t.ex. volymändringar, anslutningar, meddelanden m.m. hamnade på fel skärm, på min sekundärskärm. För det första är det inte så vanligt med två skärmar, för det andra om man nu har en extraskärm så placerar man oftast den till höger. Jag har satt min högra skärm som huvudskärm i inställningarna men alla program lyssnar inte på det, och så blir det fel.

Det fanns dock en lösning, man kunde sätta en nyckel till *focus-follow* som gör just vad namnet antyder, den kommar upp på den skärm du för tillfället arbetar. En enkel, och perfekt lösning. Så hur ställde jag in det?

Öppna en terminal och skriv:

*gconftool-2 -s -t string /apps/notify-osd/multihead_mode focus-follow*

Det bör räcka, eventuellt måste du logga ut/in för att ändringen ska börja gälla. Det kommer förmodligen komma upp som en inställning längre fram, eller vara påslagen som standard. Men jag är glad att inställningen fanns, även om inte helt självklar.

<p style="text-align: left;">
  För övrigt, jag måste säga att jag gillar det nya temat som följer med (New Wave), lätt modifierat och med blå bakgrund så det det riktigt bra ut. <span style="text-decoration: line-through;">Jag har dock bytt ut fönsterkanterna mot en som heter Correcamins som jag använt sedan tidigare då jag inte gillade de som följde med New Wave.</span> (Använder New Waves fönsterkanter igen, det såg mer enhetligt ut.)<span style="text-decoration: line-through;"><br /> </span>
</p>

<p style="text-align: center;">
  <a href="http://nsg.cc/wp-content/uploads/2009/04/new-wave.png"><img class="aligncenter size-full wp-image-109" title="new-wave" src="http://nsg.cc/wp-content/uploads/2009/04/new-wave.png" alt="new-wave" width="287" height="220" /></a>
</p>

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/gnome' rel='tag' target='_self'>gnome</a>, <a class='technorati-link' href='http://bloggar.se/om/jaunty+jackalope' rel='tag' target='_self'>jaunty jackalope</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/notifyosd' rel='tag' target='_self'>notifyosd</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>