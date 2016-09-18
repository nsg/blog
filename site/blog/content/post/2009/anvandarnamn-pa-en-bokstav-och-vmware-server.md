+++
date = "2009-03-20T14:26:17+00:00"
title = "Användarnamn på en bokstav och vmware server"
tags = ["Användarnamn", "Linux", "VMware", "VMware server"]
+++

Jag har så länge jag kan minnas kört med ett användarnamn som består av endast en bokstav på mina linux-system, och en del servrar (med mycket få undantag). Det är en kompis som introducerade mig till idén med en bokstav och jag har kört vidare med det då det är praktiskt, och så är jag nu van vid det.

För några dagar sedan hade jag sagt att det bara hade ställt till med problem en gång, men nu måste jag säga två gånger. Jag stötte på ett problem när jag installerade vmware server på en av mina servrar, en på ett steg av installationen så bad den mig att skriva in vilken användare som skulle vara administratör. Gick det, nej &#8230; installationsskriptet validerade inte användarnamn på en bokstav.

Nu är man glad att installationsskriptet var ett skript och inte att program så det var inte så svårt och redigera det så det gick att installera. Här kommer en patch om du har samma problem: [vmware-configplfix_username][1].

Om du undrar vad det första problemet med mitt användarnamn var så var det en gång för ca 2 år sedan då jag provade att installera SUSE Linux och installationsprogrammet vägrade låta mig välja ett så pass kort användarnamn. Jag löste det genom att skapa ett temporärt för att sedan manuellt byta när installationen var klar, lite jobb men värt det!

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/anv%C3%A4ndarnamn' rel='tag' target='_self'>användarnamn</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/vmware' rel='tag' target='_self'>vmware</a>, <a class='technorati-link' href='http://bloggar.se/om/vmware+server' rel='tag' target='_self'>vmware server</a>
</p></small>

 [1]: /images/2009/03/vmware-configplfix_username.patch
