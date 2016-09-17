+++
date = "2007-03-24T05:01:20+00:00"
title = "Ny hårdvara och vista"
+++

**Inledning**  
Så, nu (05:13) är jag &#8220;klar&#8221; med installation av Windows Vista Business, dock tuvärr bara 32-bitars och inte 64-bitarsverionen. Men det kanse var lika bra det då jag har hört att det ska vara problem med drivrutiner.

Som jag nämde så är kl. över 5 nu, det innebär att det har gått 11 timmar sedan jag gick ner till posten för att hämta minna delar:

* AMD Athlon 64 X2 4000+ 2.1GHz  
* Passande morderkort  
* 2G RAM  
* Seagate Barracuda 7200.10 320GB SATA2  
* GeForce 7600GT 2xDVI  
* Antec Sonata II Miditower

Föutom det så har jag mitt Creative Audigy 2 som ljudkort, min PATA*-Bännare + en PATA-HD, det är meningen att jag ska ha min 200G PATA-disk i men just nu hänger (ja) min 120G PATA-HD i som en fullösning, det ska snart ur dock.

** Notera: PATA = Paralell ATA som är den gammla standarden, benäms oftast kort och gått ATA*

**Hårdvara**  
Så vad har hänt? Jo jag började plocka ihopp delarna och spenderade säkert 4-5 timmar på det, det tog sådan tid då jag var mycket noggran med att allt skulle sitta korrekt, inga fullösningar. Jag fick i alla sladdar förutom ljudutgångarna på framsidan då mitt Audigy-kort inte hade rätt kontakt (vad jag vet), jag hade kunnat kopplat in det på ljudkortet på moderkortet men det hade varit helt meingslöst då det är inaktiverat då jag kör med mitt andra kort.  
Annars verkar allt funka som det ska, bortsätt från att HDD LED verkar sitta fel, kanse vände den tvärt om eller nått.

Lådan var riktigt trevlig, och datorn är mycket tyst, nu har jag inte belastat den så mycket ännu så jag vet inte hur den kommer låta när alla fläktar drar igång, men jag kan säga att jag känner mig mycket nöjd.

**Mjukvara**  
Planen är att köra Linux på datorn, precis som jag gjorde innan men en windowsinstallation vill jag ha, för att spela lite spel och kanse använda något specifikt program. Då jag har tillgång till vista så bestämde jag mig för att välja den då jag har varit mycket nyfiken på det och nu har jag äntligen hårdvara för att testa.

Problemet var att jag satt med en image på installations-dvd:n, ingen dvd brännare, då slog tanken mig, ja, jag installerar XP och installerar Vista ifrån det (ej uppgradera, ny installation). Dock så blev jag påmind om hur gammal XP är då den inte hade stödj för SATA, jag löste det genom att koppla in en gammal PATA-disk som hänger lite halft utanför datorn nu och var det inte helt slut hör för den ville inte installera sig så länge min SATA-disk satt som primary master då den ville skriva i MBR där, fanns det val och hoppa över det? nej, skriva bootsektorn på annan disk? nej, jag var tvungen och &#8220;lura&#8221; den genom att stänga av hela SATA-kontrollen (så att SATA-disken &#8220;försvann&#8221;) under installationen.  
Nästa steg var att installera stödj för SATA i XP, installera Demon Tools och mounta avbilden som en CD-enhet. Äntligen var jag på väg, trodde jag, jag var tydligen tvungen och skapa en partition och formatera den först för att Vistas installationsprogram skulle &#8220;se&#8221; disken. Men nu var jag påväg.

**Installation av Vista**  
Första delen av installationen var sjukt lätt, jag valde bara vart den skulle installera och det var allt, den började med det klassiska att flytta över filerna till disken, skriva sönder MBR (och oftast paja alla andra OS:s MBR), starta om, packa upp och greja, starta om, och sedan, närmde jag starta om? Ja, nu kommer man in, nej, nu kommer alla frågorna som man vanligtivs blev ställd i början av en installation, dock i mycket trevligare format, omstart, sedan var det nog klart, eller var det en omstart till, jo, det var det nog, GA!

Så nu efter yttligare 3 omstarter till (installerade lite drivrutiner) så är det igång här och jag sitter och skriver i IE7.

En intressant sak var att den gick igång helt ok grafik själv, DirectX-skrivbordet flöt perfekt men jag installerade senaste nvidias drivrutiner ändå då man vill ha det senaste. Dock så lyckades den inte få igång mitt ljudkort, det var jag förvånad över då Linux har klarat det fint riktigt länge men det kan ju vara så att Creative inte tillät dem att skicka med det.

**Sammanfattning**  
Jag ber om ursäkt för alla eventuella felstavningar och dåliga meniguppbyggnad med jag är mycket trött nu och ser fram i mot ca 2 timmars sjönhetssömn innan jag ska gå upp (det kommer bli en seg dag) och åka ut till landet över helgen, så nu får datorn vila och jag får ta och prova igenom vista ordentligt nästa vecka, för att sedan installera linux och leka med Xen.

*PS. Jag har även tagit bilder, men det blir en anna dag DS.*

:: Vista, Dator, Hårdvara, SATA

<small></small>
