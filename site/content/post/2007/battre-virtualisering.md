+++
date = "2007-08-10T22:11:31+00:00"
title = "Bättre virtualisering"
[taxonomies]
tags = ["dell", "bios", "virtualisering", "hypervisor"]
+++

<a href="/images/2007/08/os-hyper.png" onclick="return false;" title="Direct link to file"><img src="/images/2007/08/os-hyper.thumbnail.png" title="os-hyper.png" alt="os-hyper.png" align="left" height="128" width="128" /></a>Jag har läge gått och tänkt på att det kommer bli trevligt när man kan köra två operativsystem (OS) samtidigt på datorn utan massa mjukvara, helt enkelt att datorn är designad för det, och med datorn så tänker jag på moderkortet för att vara exakt.

[Såg idag att enligt rykten][1] ([via][2]) så ska Dell göra en lösning som ser lovande ut. Normalt sätt så startas de andra operativsystemen från ett operativsystem som redan körs (OS 0 i bilden till vänster), i många fall kan det vara en bra lösning men det blir inte lika bra och framför allt inte lika bekvämt som om moderkortet<a href="/images/2007/08/bios-hyper.png" onclick="return false;" title="Direct link to file"><img src="/images/2007/08/bios-hyper.thumbnail.png" title="bios-hyper.png" alt="bios-hyper.png" align="right" height="128" width="160" /></a> hade tagit hand om det från början. Vad Dell planerar att göra är att flytta in det grundläggande från OS:et och hypervisorn in i ett flashminne på moderkortet som sedan står för hela virtualiseringen. Hypervisorn kommer säker även ha en helt annan kontroll över datorn då den vet vad som sitter på moderkortet och jag gissar på att vi även kommer se en prestandaökning inne i de virtuella maskinerna. Se bilden till höger hur det är tänkt.

Det återstår att se vad som kommer i handeln i framtiden, virtualisering är en intressant teknik att hålla ögonen på, speciellt när man kör ett operativsystem och vill köra något program som bara finns till ett annat OS.



<small></small>

 [1]: http://arstechnica.com/news.ars/post/20070808-dell-virtualization-on-motherboards.html
 [2]: http://pc.feber.se//feber/art/26247/virtualisering_direkt_p_moderk/
