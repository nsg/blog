+++
date = "2007-02-18T17:28:18+00:00"
title = "Mount"
[taxonomies]
tags = ["linux", "ubuntu", "mount"]
+++

Jag provade Ubuntu för snart ett år sedan på min bärbara, det har kommit en del ingooglingar sedan det, söktermer har varit i stil med &#8220;**ubuntu mount**&#8220;, så här kommer lite hjälp.

1. Jag kör inte Ubuntu Linux, dock Gentoo Linux.  
2. Det var snart ett år sedan jag körde det sist, så något nytt kan ha tillkommit.

När jag körde det så kunde man mounta (ansluta) en partition (t.ex. hårddisk, eller del av hårddisk) till en katalog (mapp) med något grafiskt verktyg, mins inte vad det hette, men jag tror att det var något som hörde till Gnome.

Men jag hittade inget sätt och få inställningen att &#8220;sitta kvar&#8221;, så partitionen blev mountad igen vid nästa start. Så jag gjorde det &#8220;the old way&#8221; som jag är van och göra det i Gentoo. Det är möjligt att det är så man ska göra det i Ubuntu, eller så missade jag något.

Med &#8220;the old way&#8221; så menar jag att direkt editera konfigurationsfilen /etc/fstab som innehåller information om vilka partitioner som finns, och hur dom ska hanteras.

Det är en kort fil, dock kan det vara en del kommentarer i filen, och i Ubuntu är det säkert mycket kommentarer :) men syntaxen är som följande:

`/dev/hdb3               /home           reiserfs        noatime         0 0`

*Alla kommandon syftar jag på att du skriver i en terminal.*

Först är sökvägen till partitionen, den börjar med */dev/&#8221;typ av enhet&#8221; &#8220;nr på enheten&#8221; &#8220;nr på partition&#8221;*.  
T.ex. /dev/hdb3  
hd: Vanlig klassisk hårddisk, eller CD/DVD&#8230; (Parallell ATA), eller sd för nyare SATA-Diskar.  
b: Alfabetet, hårddisk/enhet två.  
3: Partition nr. 3

Du kan hitta information om vad som är vad i filen **/proc/partitions**, skriv:  
`cat /proc/partitions`

Nästa kolumn är till viken katalog den ska bli mountad till, om den inte är en del i systemet så brukar man skapa en katalog under /mnt/ som man mountar den till. T.ex.  
`sudo mkdir /mnt/katalognamn`  
&#8230; och sedan skriva in det i fstab.  
**Notera**: *Om jag minns korrekt så kör Ubuntu med katalogen /media istället för /mnt, det är en fråga om smak.*

Nästa fält är vilken typ av filsystem det är, i mitt fall är det **reiserfs**. Det vanligaste filsystemet är **ext2** el. **ext3** under Linux. Även **vfat** (fat32) eller **ntfs** (windows standard-filsystem) funkar, dock måste stödj för det finnas, men i ett system som Ubuntu så brukar allt finnas med som standard, oavsett om man behöver det eller ej. Är du osäker, prova **auto**.

Nästa är parametrar som man kan skicka med, det används om man vill ändra inställningarna. T.ex. här så har jag flaggan noatime som stänger av en sak som jag inte täcker ta upp nu, av prestandaskäl. Några exempel är **ro** för read only, **rw** för read write, **user** om en användare ska kunna mounta det. Det finns mängder av val, och beror på vilken typ av filsystem det är. Är du osäker prova **defaults**. Separera flera val med ett komma.

De två sista kan du ignorera, skriv bara 0 på dem.

Öppna filen **/etc/fstab** med&#8230;  
`sudo gedit /etc/fstab`  
&#8230;och skriv in nödvändig information.

För att sedan få partitionen mountad skriv:  
`sudo mount /mnt/katalognamn`  
*/mnt/katalognamn* är sökvägen som du valt tidigare.  
Eller så kan du starta om datorn, men det vill man väll inte göra? :) 

Ett exempel:

Du har en partition på /dev/hda1 som windows ligger installerat på, det är av typen ntfs. Nu vill ha det mountat under /mnt/windows. Det då skriver du in följande i /etc/fstab.

`/dev/hda1               /mnt/windows    ntfs            ro               0 0`

**Notera**: *ro, jag mountar ntfs-system som read only då sist jag hörde något så var stödet rätt svajigt då Microsoft ej har släppt information om hur ntfs funkar. Så det är svårt och skriva fungerande kod mot det. Onödigt och ta risker som man inte behöver skriva till det (inget kan ju hända om det är skrivskyddat).*

Förklaringen blev mer rörig än jag trodde, men det få duga som det är nu, behöver någon hjälp så låt mig veta.



<small></small>
