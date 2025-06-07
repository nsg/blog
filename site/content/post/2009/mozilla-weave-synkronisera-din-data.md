+++
date = "2009-03-20T16:28:59+00:00"
title = "Mozilla Weave &#8211; Synkronisera din data"
[taxonomies]
tags = ["Extensions", "Firefox", "Mozilla", "Mozilla Firefox", "Mozilla Weave", "Synkronisera", "Weave"]
+++

Ett av flera projekt som finns i Mozilla Labs är Weave. Weave är en extension för att synkronisera dina personliga inställningar du har i en webbläsare med en server och sedan med de andra webbläsarna på andra datorer som du använder.

Jag använder t.ex. [min Eee][1] mycket i skolan men sitter nästan uteslutande vid min stationära hemma. Det gör att jag ofta kommer på att jag har satt ett bokmärke i fel webbläsare, eller va hette den där sidan som jag har öppen i en flik hemma? Alla de problemen försvinner med weave då saker som history, flikar, lösenord, m.m. automatiskt synkroniseras.

Nu kanske du reagerade med misstänksamhet när du såg att att den även synkroniserade lösenord, det var vad jag gjorde så jag läste på lite först hur den sparade och överförde informationen till/på servern. Allt är krypterat och inte ens serverns ägare kan läsa informationen så dina personliga uppgifter (som t.ex. lösenord) är säkra. Enda chansen för någon att få tag dem är att hitta en fel i krypteringsalgoritmen OCH hacka serven, eller sno dina kontouppgifter från din dator. Känner du fortfarande inte för att lita på någon annan att hantera din data så är det mycket lätt att sätta upp en egen weave-server då den bara är en vanlig webDAV-server. Folket på Mozilla har gjort ett mycket enkelt och bra system, men det förväntar man sig nästan från ett projekt som är öppen källkod i den här klassen som Mozilla är.

Om du känner för att prova weave så finns det ett hinder, du behöver senaste utvecklingsversionen av Firefox, just nu heter den Firefox 3.1 Beta 3 och kan laddas ner här:

> <https://web.archive.org/web/20090306020535/http://www.mozilla.com/en-US/firefox/all-beta.html>

Längre fram när betan är klartestad och Firefox släpps i en stabil version så tror jag att den kommer få heta Firefox 3.5, så om du kör Firefox 3.5 eller senare så funkar den versionen du har.

Nu behöver du installera weave, du hittar weave här:

> <https://web.archive.org/web/20090326200246/http://labs.mozilla.com/projects/weave/>

Inte heller weave är i dagsläget helt klar, då du behöver förfråga efter en beta-nyckel för att få ett konto men det skedde helt automatiskt och jag hade en nyckel efter bara 10 minuter efter att jag hade skickat en förfrågan. Planerar du dessutom att sätta upp en egen server så finns det ingen poäng att skapa ett konto hos Mozilla, men jag rekommenderar det då det är mycket enklare.

Vill du läsa på hur weave fungerar på har du här ett intressant (och tekniskt) blogginlägg som tar upp hur säkerheten funkar och hur saker sparas på servern.

> [Mozilla Weave: A Bird’s-eye View][2]

Är du intresserad att sätta upp din egen server i stället så har du ett inlägg här som tar upp det, tänk dock på att i exemplet som han ger först så sätter du bara upp en vanlig http-anslutning, d.v.s. en icke krypterad anslutning och det är mycket mer osäkert än det som Mozilla erbjuder. Han tar dock upp hur du sätter upp en krypterad anslutning längre ner, och om du sätter upp en egen server så är det du vill använda.

> [Create your own Mozilla Weave server][3]

<p style="text-align: left;">
  Här kommer den bild från en sida av weaves konfiguration
</p>

<p style="text-align: left;">
  <img class="size-full wp-image-78 aligncenter" title="screenshot-firefox-weave" src="/images/2009/03/screenshot-firefox-weave.png" alt="screenshot-firefox-weave" width="572" height="561" />
</p>

<p style="text-align: left;">
  Som du ser så finns det mycket som inte går att välja i dag men som kommer komma i framtiden, speciellt extensions är något jag väntar på då jag alltid installerar något smart på en av minna datorer men inte riktigt orkar installera det på den andra.
</p>

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/extensions' rel='tag' target='_self'>extensions</a>, <a class='technorati-link' href='http://bloggar.se/om/firefox' rel='tag' target='_self'>firefox</a>, <a class='technorati-link' href='http://bloggar.se/om/mozilla' rel='tag' target='_self'>mozilla</a>, <a class='technorati-link' href='http://bloggar.se/om/mozilla+firefox' rel='tag' target='_self'>mozilla firefox</a>, <a class='technorati-link' href='http://bloggar.se/om/mozilla+weave' rel='tag' target='_self'>mozilla weave</a>, <a class='technorati-link' href='http://bloggar.se/om/synkronisera' rel='tag' target='_self'>synkronisera</a>, <a class='technorati-link' href='http://bloggar.se/om/weave' rel='tag' target='_self'>weave</a>
</p></small>

 [1]: https://nsg.cc/post/2008/god-jul-till-mig-sjalv/
 [2]: http://www.toolness.com/wp/?p=41
 [3]: https://web.archive.org/web/20090217223008/http://remcobressers.nl/2008/07/create-your-own-mozilla-weave-server/
