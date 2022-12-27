+++
date = "2011-11-12T11:26:09+00:00"
title = "Tid för mig att röja upp bland min lagring"
tags = ["Linux", "LVM", "MD", "mdadm", "parted", "RAID", "RAID5", "Ubuntu"]
+++

Åter igen har jag lyckats med att producera ett lite väl långt inlägg, jag satt och skrev på det här under tiden jag höll på under tre dagar, fredag, lördag och söndag förra helgen. Det innehåller mycket text av varierande kvalité, allt är nog inte helt hur man kanske ska göra det, men det var i alla fall så här jag gjorde det. Det här är inte tänkt som en guide eller nått utan som en informativ läsning om hur jag gjorde för att få en liten genomgång om hur en del av sakerna funkar.

### Inledning

Så nu sitter jag med totalt tre 2T diskar, två nya och en som sitter i datorn. Tanken är att bygga en RAID5 av diskarna för att få lite mer säkrare lagring. (I en RAID5 så förlorar jag utrymmet från en disk, men jag vinner att valfri disk kan gå sönder utan att jag förlorar någon data).

### Först lite bakgrund

Det skönt att ha lite extra utrymme på hårddisken så det inte tar slut så jag har köpt en ny disk till datorn lite då och då under många år. Efter det har jag regelbundet köpt nya diskar i den storlek som var mest prisvärt. 20G, 120G, 200G, 250G, 500G, 1T, 1,5T och slutligen 2T. I början kostade en 20G nästan 3000 kr, för en vecka sedan kostade 2T 600kr.

Den uppmärksamme noterade att jag skrev &#8220;för en vecka sedan&#8221; och inte &#8220;i dag&#8221;. Orsaken till det är att priset har ökat kraftigt senaste tiden på disk, så pass mycket att det är värt att nämnas. [Dustin][1] har just nu rabatt på en disk på 2T, den kostar &#8220;bara&#8221; 1990 kr. Det är långt över dubbla priset. Hur kommer det sig? Det har varit mycket översvämningar i Thailand, fabriker, leverantörer och vägar står/är stilla/nere/förstörda och det kommer mycket få leveranser av diskar till omvärlden. Det har skapat ett underskott av hårddiskar på marknaden och inte förvånande så stiger priserna.

<div id="attachment_1066" style="width: 576px" class="wp-caption aligncenter">
  <a href="/images/2011/11/2tfor1900sek.png"><img class="size-full wp-image-1066" title="2tfor1900sek" src="http://cdn.junkpile.se/2011/11/2tfor1900sek.png" alt="" width="566" height="251" /></a><p class="wp-caption-text">
    I början av november så kostade hårddiskarna "lite" mer än de brukade. För en vecka sedan köpte jag två identiska för 668 kr styck. Dagen efter kostade de ca 1800 kr.
  </p>
</div>

<h3 style="text-align: left;">
  Så här ser det ut nu
</h3>

Jag började leka med RAID för något år sedan på min dator hemma mellan två av mina diskar, för ett halvår sedan köpte jag en ny dator och slog till på en del bra saker så som en Sandy Bridge i7 2600K, 16G RAM, 2 st SSD:er på 60G samt lite saker runt det som moderkort, låda m.m. Tanken var att installera om och bygga upp saker ordentligt.

Orsaken att det blev två SSD:er på 60G i stället för en på 120G som jag från början tänkte köpa var att det var extrapris på de mindre, jag har sedan slagit ihop de med en RAID0 (stripe) och fått samma storlek men betydligt snabbare disk. Ja, jag gjorde det mest för att det var kul, inte för att jag behövde det.

Mitt system ligger på den RAID:en och den funkar bra och gör vad den ska, jag vet att det är långt från datasäkert då det räcker med att en av SSD:erna ska sluta funka för att allt ska försvinna men de sakerna som jag har i mitt system som jag är rädd om och inte kan återskapa ligger på andra diskar eller är regelbundet säkerhetskopierade.

Problemet är de andra diskarna, alla är olika stora. Just nu sitter det tre vanliga diskar i min dator. 320G, 500G och 2T. 320 disken är en disk som Windows får använda för att installera stora saker på vid behov, startar sällan Windows så den gör inte mycket nu för tiden. Tanken var sedan att bygga en RAID1 (spegel) mellan min 500G-disk och en partition på 500G på min 2T disk. Det skulle ge mig 500G av speglad säker lagring, och 1,5T osäker lagring. Tyvärr blev det inte så då min spegel råkade bli lite större än 500G och jag hade inte tid och ork att fixa det så nu ser det ut så här.

<div id="attachment_1078" style="width: 582px" class="wp-caption aligncenter">
  <a href="/images/2011/11/Disklayout-before1.png"><img class="size-full wp-image-1078   " title="Disklayout-before(1)" src="http://cdn.junkpile.se/2011/11/Disklayout-before1.png" alt="" width="572" height="324" /></a><p class="wp-caption-text">
    Tycker du att det ser rörigt ut? Det gör jag med. Jag har tre LVM:er, en för snabb disk (SSD), en för säker disk (RAID1) och slutligen en för resten. Det är som jag ville ha det, dock är allt under riktigt rörigt, speciellt med "lvm i raid i lvm" och det skulle bli jobbigt om någon disk dog då det skulle bli en del jobb att få ihop allt igen.
  </p>
</div>

<h3 style="text-align: left;">
  Nu räddningen
</h3>

När jag är klar så tänker jag bli av med den gamla 320G disken, Windows får 500G disken att leka med i stället och kvar för Linux blir två SSD:er och tre 2T-diskar. Här kommer en bild på hur det ska se ut när jag är klar.

<div id="attachment_1084" style="width: 618px" class="wp-caption aligncenter">
  <a href="/images/2011/11/Disklayout-after.png"><img class="size-full wp-image-1084   " title="Disklayout-after" src="http://cdn.junkpile.se/2011/11/Disklayout-after.png" alt="" width="608" height="343" /></a><p class="wp-caption-text">
    Mycket renare, bort med den icke-RAID:ade lvm:en och in med massor av säker lagring.
  </p>
</div>

<h3 style="text-align: left;">
  Nu det jobbiga (men roliga)
</h3>

Som du säkert förstår så är det mycket saker som kommer behövas flyttas, jag kommer flytta datan med LVM, det kommer ta tid att få över all data så det här är ett projekt som förmodligen ta hela helgen innan jag är klar. Det vackra är att jag kommer kunna använda datorn som vanligt under nästan hela helgen.

Jag vill flytta data på ett säkert sätt, d.v.s jag vill inte riskera att förlora någon data under tiden jag håller på. Jag börjar med att kolla att min spegel mår bra.

> $ cat /proc/mdstat  
> Personalities : \[linear\] \[multipath\] \[raid0\] \[raid1\] \[raid6\] \[raid5\] \[raid4\] \[raid10\]  
> md127 : active raid1 dm-6\[1\] sdd1\[0\]  
> 591786304 blocks \[2/2\] \[UU\]
> 
> md3 : active raid0 sdc2\[1\] sda4\[0\]  
> 62868480 blocks super 1.2 512k chunks
> 
> unused devices: \<none\>

md3 är SSD:erna och ska ej röras, spegeln heter md127. Allt ser bra ut, både 600G-partitionen på min 2T disk, samt raid-i-lvm-hacket ska innehålla samma data. Jag kommer börja med att ta ut både 320 och 500G diskarna för att få bort dem. De innehåller tillsammans spegeln och jag vill vara säker att jag har en backup som jag inte kan råka förstöra, jag behöver även platsen som de sitter på i lådan.

Efter det stoppar jag in mina två nya 2T diskar och bootar dator igen och nu bör det se ut så här:

<div id="attachment_1090" style="width: 692px" class="wp-caption aligncenter">
  <a href="/images/2011/11/CopyofDisklayout-before.png"><img class="size-full wp-image-1090" title="CopyofDisklayout-before" src="http://cdn.junkpile.se/2011/11/CopyofDisklayout-before.png" alt="" width="682" height="386" /></a><p class="wp-caption-text">
    Min "säkra" lvm som ligger i spegeln är inte säker längre då hälften av spegeln är borta. Men all data går att nå och skulle disken gå sönder nu så kan jag koppla tillbaka de andra diskarna och nå min data.
  </p>
</div>

<p style="text-align: left;">
  Nu stänger jag av datorn, öppnar lådan och flyttar om disk.
</p>

<p style="text-align: left;">
  Nu är jag tillbaka och allt är enligt plan, den speglade disken ville ej komma upp automatisk. Något som var väntat. En RAID kan användas för att få mer prestanda, för att slå samman flera diskar, för att få datasäkerhet och/eller för att göra systemet robust. Linux tar det säkra före det osäkra, som standard så startar den ej RAID:s där en eller flera diskar saknas utan det är något användaren manuellt måste göra. Vill man ändra det beteendet så går det så klart att göra.
</p>

> <p style="text-align: left;">
>   $ cat /proc/mdstat<br /> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]<br /> md127 : inactive sdd1[0](S)<br /> 591786304 blocks
> </p>
> 
> md3 : active raid0 sdc2\[1\] sda4\[0\]  
> 62868480 blocks super 1.2 512k chunks
> 
> unused devices: \<none\>

<p style="text-align: left;">
  Som synes så saknas det en disk på md127. Samt man ser att den är stoppad (S). Då det är en spegel så finna all data på sdd1 så det är bara en fråga om att tvinga igång den. Du kan använda det trevliga inbyggda programmet &#8220;Disk Utility&#8221; för att göra det, men för sakens skulle gör jag det från skalet.
</p>

> <p style="text-align: left;">
>   $ sudo mdadm --run /dev/md127<br /> mdadm: started /dev/md127
> </p>
> 
> <p style="text-align: left;">
>   $ cat /proc/mdstat<br /> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]<br /> md127 : active raid1 sdd1[0]<br /> 591786304 blocks [2/1] [U_]
> </p>
> 
> md3 : active raid0 sdc2\[1\] sda4[0]  
> 62868480 blocks super 1.2 512k chunks
> 
> unused devices: \<none\>

<p style="text-align: left;">
  Som synes körs md127 nu, på en disk. Jag har ett par partitioner som ligger på den spegeln som inte blev anslutna vid start, för att montera dem så räcker det med att skriva:
</p>

> <p style="text-align: left;">
>   $ sudo mount -a
> </p>

<p style="text-align: left;">
  Det ska vara allt för nu. Nu har jag tillgång till all min data och kan börja kolla på mina nya diskar. Men innan jag börjar göra det så kan det vara en god idé att kolla igenom dem. Nästan alla diskar har något som heter SMART, det är mjukvara på disken för att hålla reda på hur den mår. Den kör regelbundna tester men det går att manuellt trigga lite mer utförliga texter och det är något jag tänkte göra nu. Kommandot för att kontrollera diskar heter <em>smartctl</em> men den här gången tänkte jag använda mig av &#8220;Disk Utility&#8221;.
</p>

<div id="attachment_1096" style="width: 607px" class="wp-caption aligncenter">
  <a href="/images/2011/11/disk-utility.png"><img class="size-large wp-image-1096  " title="disk utility" src="http://cdn.junkpile.se/2011/11/disk-utility-1024x200.png" alt="" width="597" height="117" /></a><p class="wp-caption-text">
    Du får en bra översikt av din disk, vilka partitioner den har, om SMART har raporterat något fel m.m. Jag tycker om Disk Utility då man får en bra översikt. Sedan att det är enklare skadar inte heller.
  </p>
</div>

Jag ser tre diskar som heter &#8220;2.0 TB Hard Disk&#8221;, det är lätta att se vilka diskar som är nya då de är helt tomma. Jag klickade på SMART Data-knappen och valde att köra ett &#8220;extended test&#8221;. Det kommer ta lång tid men jag har ingen broska utan kan använda datorn som vanligt.

<div id="attachment_1095" style="width: 642px" class="wp-caption aligncenter">
  <a href="/images/2011/11/smarttest.png"><img class="size-full wp-image-1095" title="smarttest" src="http://cdn.junkpile.se/2011/11/smarttest.png" alt="" width="632" height="531" /></a><p class="wp-caption-text">
    Inte en av de nya diskarna, det här är en av mina SSD:er men här ser du i alla fall ut det ser ut innan man startar testet samt hur det kan se ut efter att ha använt disken ett tag.
  </p>
</div>

<div id="attachment_1094" style="width: 652px" class="wp-caption aligncenter">
  <a href="/images/2011/11/smarttestrunning.png"><img class="size-full wp-image-1094" title="smarttestrunning" src="http://cdn.junkpile.se/2011/11/smarttestrunning.png" alt="" width="642" height="530" /></a><p class="wp-caption-text">
    Här är en av de nya diskarna, det går bra att stänga ner alla fönster om du vill då testet pågår internt i disken. Stäng inte av datorn bara (eller starta om).
  </p>
</div>

<p style="text-align: left;">
  Det går bra att stänga fönstret om du så vill, lät datorn stå eller använd den för fullt. Lämna bara de nya diskarna i fred. Själv blir det nog lite film eller <a href="http://www.minecraft.net/">minecraft</a> medan jag väntar.
</p>

<p style="text-align: left;">
  <em>cirka sex timmar senare&#8230;</em>
</p>

<p style="text-align: left;">
  Jag passar på att köra lite benchmark på diskarna, alltid kul och veta vad de klarar av. Efter det är det tid för att skapa RAID5:an.
</p>

<p style="text-align: left;">
  Vänta nu kanske du säger, behöver jag inte tre diskar för det? Jo, tre diskar är minimun för en RAID5 med full redundans, det är dock möjligt att temporärt köra den med två diskar, den extra disken innehåller bara redundant data.
</p>

<div id="attachment_1113" style="width: 690px" class="wp-caption aligncenter">
  <a href="/images/2011/11/Screenshot-2.0-TB-Hard-Disk-ATA-ST2000DL003-9VT166-%E2%80%93-Benchmark.png"><img class="size-full wp-image-1113" title="Screenshot-2.0 TB Hard Disk (ATA ST2000DL003-9VT166) – Benchmark" src="http://cdn.junkpile.se/2011/11/Screenshot-2.0-TB-Hard-Disk-ATA-ST2000DL003-9VT166-%E2%80%93-Benchmark.png" alt="" width="680" height="542" /></a><p class="wp-caption-text">
    Här ser man att det spelar roll vart på disken som datan ligger.
  </p>
</div>

<p style="text-align: left;">
  <a href="/images/2011/11/Screenshot-2.0-TB-Hard-Disk-ATA-ST2000DL003-9VT166-%E2%80%93-Benchmark-1.png"><br /> </a><a href="http://cdn.junkpile.se/2011/11/Screenshot-2.0-TB-Hard-Disk-ATA-ST2000DL003-9VT166-%E2%80%93-Benchmark-1.png"><br /> </a>Jag väljer åter igen att använda mig av kommandoraden för att arbeta med min RAID, tycker det känns som man har mer kontroll. Men det går att arbeta med den från Disk Utility med om du föredrar.
</p>

<p style="text-align: left;">
  Det finns olika sätt man kan bygga RAID:en på, du kan använda rådisken rakt av, eller en partition på den. Jag rekommenderar att du använder en partition av två orsaker.
</p>

1.  Om du någon gång behöver kunna boota från disken så behöver du de där 512 byten i början av disken, om du partitionerar disken så är de reserverade.
2.  Alla tre diskar på 2T är på 2000398934016 bytes, låt säga att en av diskarna behöver bytas. Låt säga att utbytesdisken är på 2T den med men den är lite mindre, låt säga 2000397885440 bytes (1 MB mindre). Den kommer ej gå att använda då den är för liten. Min rekommendation är att du lämnar &#8220;lagom mycket&#8221; på slutet av disken för att undvika att sånt här händer.

Jag dog till med ett runt och fint värde på 1998 och lämnar lämnar strax över 2G på slutet. Jag hade kunnat lämna lite mindre men 2G duger fint och lämnar bra marginal. Som synes lämnade jag även lite plats i början av disken (1 räcker förmodligen) för att ge parted möjlighet att aligna partitionen efter diskens fysiska block.

Skapa en partitionstabell på diskarna, jag valde gamla klassiska msdos men GPT bör funka lika bra om du föredrar det.

> $ sudo parted /dev/sdb mktable msdos  
> $ sudo parted /dev/sde mktable msdos

Nu skapar jag partitionerna

> $ sudo parted /dev/sdb mkpart p 4 1998G  
> $ sudo parted /dev/sde mkpart p 4 1998G

Nu skapar vi vår nya RAID5 på två diskar, och en disk som saknas:

> $ sudo mdadm --create /dev/md4 --level=raid5 --raid-devices=3 /dev/sdb1 /dev/sde1 missing

Nu ser det ut så här

> $ cat /proc/mdstat Personalities : \[linear\] \[multipath\] \[raid0\] \[raid1\] \[raid6\] \[raid5\] \[raid4\] \[raid10\]  
> md4 : active raid5 sde1[1] sdb1[0]  
> 3902331904 blocks super 1.2 level 5, 512k chunk, algorithm 2 \[3/2\] \[UU_\]
> 
> md127 : active raid1 sdd1[0]  
> 591786304 blocks \[2/1\] \[U_\]
> 
> md3 : active raid0 sdc2\[1\] sda4[0]  
> 62868480 blocks super 1.2 512k chunks
> 
> unused devices: \<none\>

Som synes är md4 uppe och kör, även om den saknar en disk. Nu är det tid att börja flytta över LVM till den nya disken.

Jag formaterade vår nya raid för LVM, nu verkar LVM vara duktig på just att aligna i 4k block men det skadar inte att vara lite petig och ange några parametrar.

> $ sudo pvcreate --dataalignment 4096 /dev/md4

Jag har sedan tidigare följande volymgrupper i LVM

> $ sudo vgs  
> VG        #PV #LV #SN Attr   VSize   VFree  
> RD_mirror   1   2   0 wz--n- 564.37g 380.00m  
> RD_pool     1   6   0 wz--n-   1.27t 190.58g  
> SSD         1   2   0 wz--n-  59.95g  22.70g

RD\_mirror är den gamla spegeln, RD\_pool är den stora poolen av data som inte var RAID:ad samt SSD är föga förvånande mina SSD:s. Tanken är att flytta alla volymer över från RD\_mirror till vår nya raid. Jag tänker göra det genom att utöka RD\_mirror så den innefattar vår nya RAID för att sedan ta bort den gamla disken från volymgruppen. Det kommer ta ett tag men när det är gjort bör all data i RD_mirror bara ligga på vår nya RAID.

Så här ser det ut nu, vår volymgrupp är på ca 564G och ligger bara på den gamla speglade RAID:en.

> $ sudo vgdisplay RD_mirror | grep Size  
> VG Size               564.37 GiB  
> PE Size               4.00 MiB  
> Alloc PE / Size       144384 / 564.00 GiB  
> Free  PE / Size       95 / 380.00 MiB

Jag stoppar in den nya stora RAID5-raiden i volymgruppen

> $ sudo lvextend RD_mirror /dev/md4

Vi har nu ca 3,6T att leka med, nu ligger volymgruppen över både gamla och nya RAID:en.

> $ sudo vgdisplay RD_mirror | grep Size  
> VG Size               4.19 TiB  
> PE Size               4.00 MiB  
> Alloc PE / Size       144384 / 564.00 GiB  
> Free  PE / Size       952811 / 3.63 TiB

Nu vill vi få bort datan från den gamla spegeln och in i vår nya fina RAID. Om man kör pvmove på bara en måldisk så utryms den på alla volymer, i det här fallet så kommer allt åka över till md4.

> $ sudo pvmove /dev/md127

Det här kommer ta lång tid, som ni ser har jag 564.37G att kopiera. Passande nog så är jag ganska trött och klockan är mycket så nu går jag och lägger mig. En sista sak först, pvmove är en destruktiv handling, om något går fel så får du dataförlust, även om det inte är troligt så är det bra att ha en backup först. Jag har redan en backup (de två diskarna som nu ligger på mitt skrivbord).

Nu har jag vaknat och allt har gått bra, nu plockar jag bort spegeln från volymgruppen.

> $ sudo vgreduce RD_mirror /dev/md127

Som synes har vi nu &#8220;bara&#8221; ca 3T, allt ligger nu på /dev/md4

> $ sudo vgdisplay RD_mirror | grep Size  
> VG Size               3.63 TiB  
> PE Size               4.00 MiB  
> Alloc PE / Size       144384 / 564.00 GiB  
> Free  PE / Size       808332 / 3.08 TiB

Jag tycker inte att namnet RD\_mirror passar så bra länge så jag döper om den till RD\_raid

> $ sudo vgrename RD\_mirror RD\_raid

Glöm inte bort att om du har monteringar som använde RD_mirror så kan det vara en bra idé att uppdatera sökvägarna.

Nu är det tid för volymerna i RD\_pool att flyttas över till RD\_raid, för det så gör jag så här:

Jag kommer använda mig av vgmerge, för att det ska funka så måste extents i volymgruppen vara lika stora, i mitt fall är dom det. Funkar inte det så kan du alltid ta en snapshot (eller avmontera volymen och kopiera direkt från den), skapa en lika stor volym där du vill ha den och dd:a över datan. Lösningen med dd har jag gjort förr och den funkar bra men den här gången blir det vgmerge för mig.

Vi behöver stänga av RD\_pool innan vi kan slå samman den med RD\_raid

> $ sudo vgchange -a n RD_pool

Här slår vi samman RD\_pool med RD\_raid

> $ sudo vgmerge RD\_raid RD\_pool

Som synes finns ej RD\_pool längre utan allt ligger i RD\_raid

> $ sudo vgs  
> VG      #PV #LV #SN Attr   VSize  VFree  
> RD_raid   2   8   0 wz--n-  4.90t  3.27t  
> SSD       1   2   0 wz--n- 59.95g 22.70g

Nu börjar vi närma oss, även om datan ligger i rätt volymgrupp så ligger den fortfarande kvar på samma fysiska disk.

> $ sudo pvs  
> PV         VG      Fmt  Attr PSize   PFree  
> /dev/md127         lvm2 a-   564.37g 564.37g  
> /dev/md3   SSD     lvm2 a-    59.95g  22.70g  
> /dev/md4   RD_raid lvm2 a-     3.63t   3.08t  
> /dev/sdd5  RD_raid lvm2 a-     1.27t 190.58g

Vi applicerar samma teknik som innan:

> $ sudo pvmove /dev/sdd5

Förra gången flyttade jag bara 564G, den här gången är det 1,1T så det kommer ta strax över dubbelt så lång tid, vilken tur att jag har planer för dagen. Det blir en tur för mig till tekniska för att se på NASA utställningen.

<div id="attachment_1130" style="width: 498px" class="wp-caption aligncenter">
  <a href="/images/2011/11/145r.jpg"><img class="size-full wp-image-1130" title="145r" src="http://cdn.junkpile.se/2011/11/145r.jpg" alt="" width="488" height="364" /></a><p class="wp-caption-text">
    Några timmar efter ha kollar på modeller och replica av raketer och kapslar, samt en och annan äkta del. Gått hem, ätit mat och fastnat i långa diskussioner, hamnat framför datorn och spelat minecraft så är det fortfarande 20% kvar. Tror nog inte jag kommer vidare i kväll då klockan redan är efter midnatt. Ang. bilden så är det en liten souvenir som jag köpte i kiosken.
  </p>
</div>

<p style="text-align: left;">
  Wow, förvirringen nästan ett dygn senare, men det står 100% på min högra skärm så det är klart. Det blev nog klart för 7-8 timmar sedan tror jag men då sov jag. Nu blir det lite kaffe och några minuter för att samla tankarna vart jag var och vad jag ska göra nu (så bra att jag har skrivit ner det).
</p>

<p style="text-align: left;">
  Jag tar bort sdd5 from RD_raid:
</p>

> <p style="text-align: left;">
>   $ sudo vgreduce RD_raid /dev/sdd5
> </p>

<p style="text-align: left;">
  Så, nu är omflyttningen kvar. Det som återstår är att stoppa in den sista 2T disken i RAID:en (md4). Men innan det så vill jag vara lite ordentlig och kolla att att viktig data funkar. Det i min värld enklaste sätter för att vara 100 000% säker att jag kan läsa datan från de nya diskarna och RAID:en är helt enkelt att stänga av datorn och dra ut den gamla disken och ser om saker startar om om jag kan nå all min data.
</p>

<p style="text-align: left;">
  Det finns även en fil /etc/mdadm/mdadm.conf, under Debian måste man manuellt uppdatera den, jag väljer att inte göra det nu då jag vill se om Ubuntu gör nått själv med den. Kan vara intressant och se.
</p>

<p style="text-align: left;">
  Återkommer efter att ha dragit ut lite sladdar och testat.
</p>

<p style="text-align: left;">
  Nope, var tvungen att updatera mdadm.conf, det görs enklast med att bli root och köra:
</p>

> <p style="text-align: left;">
>   mdadm --examine --scan >> /etc/mdadm/mdadm.conf
> </p>

<p style="text-align: left;">
  Nu har du sparat information om alla dina RAID:s i slutet på filen, redigera den nu och ta bort dubbletter samt gamla RAID:s som du inte längre vill ha kvar (md127 i mitt fall).
</p>

<p style="text-align: left;">
  Efter två ombooter (drog ut fel disk först) så funkar allt fint, jag uppdaterade /etc/fstab så att de pekar på de nya sökvägarna (jag bytte namn på mina volymgrupper) samt körde:
</p>

> <p style="text-align: left;">
>   $ sudo mount -a<br /> $ sudo swapon -a
> </p>

<p style="text-align: left;">
  Voilá, jag allt funkar fint, den nya raiden heter dock md127 i stället för md4. Ska jag vara ärlig så vet jag inte exakt vad som får den att namnge den 127, det verkar som att den använder 127, 126, o.s.v. som namn när något inte är helt 100. I mitt fall så döpte den om sig själv tillbaka till md4 efter att jag var klar. Men annars ska logiken vara att göra en --stop, följt av en --remove och slutligen --assemble på allt igen. Det funkar dock oberoende vad den heter.
</p>

<p style="text-align: left;">
  Nu sätter jag in sista disken, tar bort partitionerna och partitionerar den på nytt på samma sätt som på de andra två, jag bygger sedan ut RAID:en över den och testar att allt funkar. Rundar av med att starta om datorn för att verifiera att allt kommer upp rätt.
</p>

> <p style="text-align: left;">
>   $ sudo parted /dev/sdd mkpart p 4 1998G<br /> $ sudo mdadm --add /dev/md127 /dev/sdd1
> </p>

<p style="text-align: left;">
  Nu är RAID:en komplett, det kommer trigga en synkronisering, något du kan se här:
</p>

> <p style="text-align: left;">
>   $ cat /proc/mdstat<br /> Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]<br /> md3 : active raid0 sdc2[1] sda4[0]<br /> 62868480 blocks super 1.2 512k chunks
> </p>
> 
> md127 : active raid5 sdd1[3] sdb1[0] sde1\[1\]  
> 3902331904 blocks super 1.2 level 5, 512k chunk, algorithm 2 \[3/2\] \[UU_\]  
> [>....................]  recovery =  0.0% (182400/1951165952) finish=534.7min speed=60800K/sec
> 
> unused devices: \<none\>

<p style="text-align: left;">
  Synkroniseringen är något som sker transparent i bakgrunden, det är inget problem att göra vad du vill, inklusive starta om datorn då den kommer fortsätta snällt i bakgrunden. Tänk dock på att du har ingen fullt komplett RAID5:a med redundans förrän den är klar.
</p>

<p style="text-align: left;">
  Det var allt, några timmar senare var allt klar och jag passade på att uppdatera datorn till 10.11.
</p>

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>, <a class='technorati-link' href='http://bloggar.se/om/lvm' rel='tag' target='_self'>lvm</a>, <a class='technorati-link' href='http://bloggar.se/om/md' rel='tag' target='_self'>md</a>, <a class='technorati-link' href='http://bloggar.se/om/mdadm' rel='tag' target='_self'>mdadm</a>, <a class='technorati-link' href='http://bloggar.se/om/parted' rel='tag' target='_self'>parted</a>, <a class='technorati-link' href='http://bloggar.se/om/raid' rel='tag' target='_self'>raid</a>, <a class='technorati-link' href='http://bloggar.se/om/raid5' rel='tag' target='_self'>raid5</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>

 [1]: http://www.dustinhome.se/
