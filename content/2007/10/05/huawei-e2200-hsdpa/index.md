/*
 Title: Huawei E2200 HSDPA
 Author: nsg
 Template: post
 Permalink: /2007/10/05/huawei-e2200-hsdpa/
 Date: 2007-10-05T09:10:59+00:00
 Categories: Internet, Linux, Personligt, Teknik
*/
> <p align="left">
>   Uppdaterad 2007-11-09 med mer information.<br /> Jag satt några timmar i dag och försökte få igång modemet på min bärbara dator, nu funkar det äntligen och jag uppdaterar nu informationen här under.
> </p>

Jag beställde i tisdags ett abonnemang från 3, mobilt &#8220;bredband&#8221; för 199kr/mån, bekvämt då jag kan ta met mig den när jag flyttar och ett plus är att jag kan springa runt med modemet i väskan och använda till min bärbara dator.

Modemet är ett Huawei E2200 HSDP, jag hade kollat runt lite på webben innan att det inte skulle vara helt omöjligt att få igång i linux. Så jag beställde det.

I går kom det och jag starta windows för att prova det så att allt funkade som det skulle, det var bara och plugga in det i Vista och det låtsades vara en cd-spelare där installationsprogrammet autostartar från för att sedan när det är klart gömma &#8220;cd-spelaren&#8221;. Det funkade fint.

I linux så var det dock inte lika lätt då [ubuntu i mitt fall] blev förvirrad av den virtuella cd-spelaren, i tidigare versioner av ubuntu så var en lösning att plocka bort stödjet för det och på så vis lura fram modem-delen. Men jag såg att 7.04 (Feisty Fawn) som jag kör klarade av det genom att helt enkelt ignorera cd-spelaren. Men det var inte frid och fröjd för ett problem kvarstod. Det funkade inte, vad jag kunde utläsa så svarade inte modemet.

Efter att ha googlat runt lite mer så såg jag att jag skulle få tre devices och inte en som jag hade, så här ska det se ut:

> s@Narsil ~ $ ls -l /dev/ttyUSB*  
> crw-rw&#8212;- 1 root dialout 188, 0 2007-10-05 09:25 /dev/ttyUSB0  
> crw-rw&#8212;- 1 root dialout 188, 1 2007-10-05 09:21 /dev/ttyUSB1  
> crw-rw&#8212;- 1 root dialout 188, 2 2007-10-05 09:21 /dev/ttyUSB2

Jag försökte olika trix med att ladda ut/in moduler, m.m. men inget verkade hjälpa, slutligen hittade jag en lösning, inte snygg, rätt jobbig men den duger tills vidare. Om jag startar datorn med modemet i så funkar det :) 

> Uppdaterat  
> Notera att det jag trode här var inte hela sanningen, jag hade tidigare installerat ett program gjort för vodafone men för samma modem. När jag försökte få modemet att funka på min bärbara dator (7,10, Gutsy Gibbon) så ville det inte funka förän programmet var installerat.  
> Jag hade helt glömt bort att jag hade det installerat när jag skrev här tidigare, men det kanske är då att det funkar utan på 7.04, kan inte kolla det nu då alla minna system nu kör 7.10. Men jag gissar på att det behövs.  
> Kort och gott, om du bara hittar ttyUSB0 så installera programmet.
> 
> Programmet jag pratar om är:
> 
> https://forge.vodafonebetavine.net/projects/vodafonemobilec/
> 
> Du kan behöva installera lite bibliotek innan men det tar installern hand om.
> 
> Det kan bli lite lustigt om modemet är din enda väg ut på internet då installern vill ladda ner saker, en lösning är kommandorna:
> 
> gdebi --apt-line namnet\_på\_paketet.deb  
> sudo apt-get install --print-uris lång lista på paket
> 
> Som ger dig vilka paket som behöver laddas ner, resp. adressen till paketen för att ladda ner dom manuellt på en annan dator. Sedan är det bara att kopiera in dom till rätt ställe i systemet:
> 
> sudo cp /sökväg/*.deb /var/cache/apt/archives/

> Uppdaterat (igen)  
> Tidigare i dag så fick jag igång modemet  från en Live-skiva, det enda jag behövde göra var att kopiera min **wvdial.conf** till skivans /etc och köra **wvdial **i en terminal, klart.
> 
> Det lite lustiga är att jag fick inte det att funka på min bärbara dator som var installerad från samma skiva utan behövde drivrutinen som jag nämner ovan.
> 
> Skivan är en &#8220;ubuntu 7.10&#8243;-skiva.

Självklart måste jag undersöka hur jag ska kunna få igång det utan att starta (om) datorn, men tills vidare är jag nöjd.

> Problemet försvann i Gutsy Gibbon.

&#8212;

Om någon har hittat hit och behöver hjälp att få igång sitt modem så gör följande.

1.  Stoppa in simkortet i en mobil och stäng av pin-koden, koden kan även avaktiveras från en windows-installation (mitt val). Det går att ha kvar pin-koden men det krånglar bara till det.
2.  Starta datorn med modemet i, har du en nyare version än 7.04 så <strike>kanske</strike> behöver du inte <strike>behöver</strike> det.
3.  Kör **ls -l /dev/ttyUSB*** i konsol, du bör få tre resultat, se ovan. Om inte, installera programmet, se ovan.
4.  Editera **/etc/wvdial.conf** med din favoriteditor, t.ex. **sudo gedit /etc/wvdial.conf**
5.  Skriv in följande i filen:

> [Dialer Defaults]  
> Phone = \*99\***1#  
> Username = skrivvadsomhalst  
> Password = skrivvadsomhalst  
> Stupid Mode = 1  
> New PPPD = yes  
> Dial Command = ATDT
> 
> Modem = /dev/ttyUSB0  
> Baud = 460800  
> Init2 = ATZ  
> Init3 = ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0  
> Modem Type = Analog Modem

Sedan för att ansluta, skriv **sudo wvdial**

> Funkar det inte prova med att lägga till:
> 
> connection = 3GPREF  
> wvdial\_profile\_name = PAP  
> apn = data.tre.se

Självklart finns det grafiska sätt att göra <strike>allt</strike> delar av det, men det tar jag någon annan gång, nu är jag bara nöjd att det funkar.

Jag skrev om det grafiska sättet [här][1], men där utgår jag från att allt bara funkar direkt, jag rekommenderar att du provar i konsoll först.

:: Tre, Linux, Internet, Bredband

<small></small>

 [1]: http://junkpile.se/~s/wp/2007/10/att-installera-3s-mobila-bredband-i-ubuntu/