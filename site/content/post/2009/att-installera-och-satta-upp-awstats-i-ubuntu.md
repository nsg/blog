+++
date = "2009-06-27T21:48:22+00:00"
title = "Att installera och sätta upp AWStats i Ubuntu"
[taxonomies]
tags = ["Apache", "awstats", "cron", "Debian", "Linux", "Loggar", "Statistik", "Ubuntu"]
+++

<img class="alignright size-full wp-image-691" title="awstats" src="/images/2009/06/awstats_logo4.png" alt="awstats" width="111" height="51" />Jag har just spenderat några timmar med att installera och sätta upp AWStats på en av mina servrar. Jag tänkte dokumentera hur jag gjorde.

AWStats är ett utmärkt program för att få statistik för din webbplats. AWStats har även stödj för andra typer av statistik som t.ex. ftp-servrar men det kommer jag inte ta upp här. Vill du veta mer kan du läsa på den officiella hemsidan eller kolla på ett demo.

[AWStats official web site][1]  
[Demo av AWStats][2]

Vad ska jag med AWStats till kanske du undrar, jag har redan ett bra webbaserade statistikverktyg som t.ex. Google Analytics. Jo, saken är den att webbaserade statistikverktyg fångar inte all trafik, t.ex. om du har en blogg så får du ingen information om hur många som läser bloggen via din feed, du missar även besökare som har javascript avstängt eller har installerat något som blockerar t.ex. Google Analytics. Allt det för att de webbaserade verktygen baserar sin statistik på ett litet javascript, eller liknande teknik som finns på din hemsida.

AWStats använder din webbservers loggar som källa för att bygga sin statistik, det gör att den får med allt som finns där. Nu sparas inte all information i loggarna så vill du ha bra koll på dina besökare så kör flera statistikverktyg, t.ex. AWStats + Google Analytics. Det skadar aldrig att hålla koll på besökarna.

Jag föresätter att du kör en debian-baserat system (t.ex. Ubuntu), och att du känner dig bekväm med kommandoraden och att du kör webbservern Apache.

**Installera**

> sudo apt-get install awstats

**Konfigurera AWStats**

AWStats har sin konfiguration i /etc/awstats. Det finns en fil där som heter awstats.conf, utgå från den för att skapa en ny fil som heter awstats.example.com.conf där example.com är ditt domännamn. Öppna den och ändra följande inställningar:

> LogFile -- Sökvägen till din access.log för din site.  
> SiteDomain -- Ditt domännamn, t.ex. example.com  
> HostAliases -- Lägg till ditt domännamn först där, t.ex. &#8220;example.com localhost 127.0.0.1&#8243;

Det är det minsta du behöver för att få igång AWStats.

**Konfigurera Apache och generera statistik  
**

Nu behöver du sätta upp apache så att du kan se din statistik, skapa en fil i /etc/apache2/conf.d, jag döpte den till awstats.conf. Alla filer i conf.d kommer laddas när apache startar. I den har jag:

> Alias /awstatsclasses &#8220;/usr/share/awstats/lib/&#8221;  
> Alias /awstats-icon/ &#8220;/usr/share/awstats/icon/&#8221;  
> Alias /awstatscss &#8220;/usr/share/doc/awstats/examples/css&#8221;  
> ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/  
> ScriptAlias /awstats/ /usr/lib/cgi-bin/  
> Options ExecCGI -MultiViews +SymLinksIfOwnerMatch

Det räcker för att AWStats ska laddas när du går till example.com/awstats/awstats.pl. Men innan du gör det så måste du generera någon statistik att kolla på, det gör du genom att köra följande kommando:

> sudo /usr/lib/cgi-bin/awstats.pl -config=example.com -update

Det kommer skrivas ut den del information, första gången kommandot körs så kan det ta lång tid att köra. När det är klart så bör du hitta statistiken på example.com/awstats/awstats.pl så fort apache har laddats om med:

> sudo /etc/init.d/apache2 reload

(Är servern viktig så kan du kolla filerna efter syntaxfel först innan du kör reload med kommandot &#8220;apache2ctl -t&#8221;)

**Kräv inloggning och lite enklare adress**

Nu är det inte bra att ha statistik som din webbplats öppen för alla så en inloggning vore en idé, börja med att ändra variabeln AllowAccessFromWebToAuthenticatedUsersOnly till 1, nu kräver AWStats att du måste vara inloggad. Nu måste du se till att det går att logga in, det gör du genom att ändra lite i apaches konfiguration.

Lägg till följande i din apache-konfiguration  i din vhost. Första 2 raderna gör så att det räcker med att skriva example.com/awstats för att komma till statistiken och är valfria.

> RewriteEngine On  
> RewriteRule ^/awstats/?$ http://%{HTTP_HOST}/awstats/awstats.pl  [R,L]

> <Directory /usr/lib/cgi-bin/>  
> <IfModule mod\_authn\_file.c>  
> AuthType Basic  
> AuthName &#8220;AWStats Login&#8221;  
> AuthUserFile /etc/awstats/htpasswd  
> </IfModule>  
> Require valid-user  
> </Directory>

Skapa filen htpasswd i /etc/awstats med:

> sudo htpasswd -c /etc/awstats/htpasswd *användare*

(för att lägga till fler användare, kör samma rad igen men utan flaggan -c)

Ladda om servern:

> sudo /etc/init.d/apache2 reload

Nu bör du få en fråga om att logga in när du försöker nå AWStats, prova gärna med att logga in med fel (och tomma) uppgifter så att saker är korrekt uppsatta.

**Håll statistiken uppdaterad med cron**

Tidigare körde vi awstats.pl för att generera statistik, för att slippa göra det manuellt så ber vi programmer cron att köra kommandot med regelbundna intervall. För att editera cronjobben skriv:

> sudo crontab -e

Är det första gången blir du tillfrågad om vilken editor du vill använda, välj din favorit. Syntaxen i cron är:

> [MINUTER]   [TIMMAR]   [DAGAR PÅ MÅNADEN]   [MÅNADEN]   [DAG PÅ ÅRET]   [KOMMANDO]

Ett cronjobb skrivs på en rad, och är separerat med ett mellanrum. Du skriver en \* för att beskriva &#8220;alltid&#8221;, du kan även ange datum och tider som 12-15 eller 1,2,3 eller \*/10. Du kan läsa på mer om cron [här][3].

Exempel där jag uppdaterar statistiken kl. 00:00, 06:00, 12:00 och 18:00:

> 0 0,6,12,18 \* \* * /usr/lib/cgi-bin/awstats.pl -config=example.com -update > /dev/null

1 gång i timman (xx:00):

> 0 \* \* \* \* /usr/lib/cgi-bin/awstats.pl -config=example.com -update > /dev/null

1 gång om dagen (midnatt):

> \* 0 \* \* \* /usr/lib/cgi-bin/awstats.pl -config=example.com -update > /dev/null

**Har du flera olika domännamn på servern?**

Har du flera olika domännamn på servern så räcker det med att skapa en till konfigurationsfil för AWStats, sätta upp vhost:en så att det går att logga in, eventuellt skapa en till användare och sätta upp en rad till i cron så att statistiken för den nya siten genereras. Ett tipps är att inte köra båda händelserna exakt samtidigt, speciellt inte om dina loggar är stora.

Det finns en del små förbättringar du kan göra så du slipper ha samma typ av information på flera olika ställen. Du kan flytta ut konfiguration från vhost:en till en separat fil, jag har kallat den awstats.conf och lagt den i en katalog som heter inc under /etc/apache2, d.v.s. /etc/apache2/inc/awstats.conf (inte att blanda ihop med /etc/apache2/conf.d/awstats.conf). Sedan räcker det med att inkludera den från de olika vhost:s jag har med:

> Include inc/awstats.conf

Fördelen är att du nu har konfigurationen på ett ställe, och om du behöver ändra något så är det bara i inc/awstats.conf du behöver ändra i.

Samma teknik kan användas för konfigurationen till AWStats, jag har skapat en fil som heter *awstats.model.conf* som ligger i /etc/awstats. Den innehåller alla gemensamma inställningar som gäller alla sidor jag har. De inställningarna som är unika för en sida har jag flyttat in i sidans konfigurationsfil. Filen slutar sedan med att jag inkluderar de generella inställningarna:

> Include &#8220;/etc/awstats/awstats.model.conf&#8221;

Det blir mycket renare och enklare att ha översikt, och risken att du glömmer att ändra någon inställningen på en av sidorna minskar.

Jag hoppas att det här kan hjälpa någon, är det något som inte funkar, eller har jag missat något. Låt mig veta.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/apache' rel='tag' target='_self'>apache</a>, <a class='technorati-link' href='http://bloggar.se/om/awstats' rel='tag' target='_self'>awstats</a>, <a class='technorati-link' href='http://bloggar.se/om/cron' rel='tag' target='_self'>cron</a>, <a class='technorati-link' href='http://bloggar.se/om/debian' rel='tag' target='_self'>debian</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/loggar' rel='tag' target='_self'>loggar</a>, <a class='technorati-link' href='http://bloggar.se/om/statistik' rel='tag' target='_self'>statistik</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>

 [1]: http://awstats.sourceforge.net/
 [2]: http://www.nltechno.com/awstats/awstats.pl?config=destailleur.fr
 [3]: https://help.ubuntu.com/community/CronHowto
