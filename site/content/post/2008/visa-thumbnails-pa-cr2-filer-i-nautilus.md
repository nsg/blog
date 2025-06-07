+++
date = "2008-02-03T20:14:32+00:00"
title = "Visa thumbnails på CR2-filer i Nautilus"
[taxonomies]
tags = ["nautilus", "linux", "canon", "eos 400d", "raw", "gnome"]
+++

<img src="/images/2008/02/cr2.png" title="cr2.png" alt="cr2.png" align="left" />Har du en digital systemkamera, och kör Gnome. Då vill du nog att Nautilus ska generera thumbnails även för dina raw-bilder. Det är jobbigt och onödigt att behöva använde ett program för att kunna bläddra igenom dem när du letar efter en bild.

Jag kör ubuntu 7.10 (Gutsy), den identifierar minna raw-bilder (från en Canon EOS 400d) korrekt som *image/x-canon-cr2*. Dubbelklickar jag på den så öppnas F-Spot View som visar bilden, helt ok. Men det blir ingen tumnagel.

Två saker saknas, ett program för att göra en tumnagel och en koppling så att Nautilus vet vad den ska göra.

Vi börjar med programmet, programmet heter *dcraw* och installeras enklast med att skriva:

> sudo apt-get install dcraw

&#8230; i en konsol. Kanske har du redan det installerat.

Nu behöver du ett litet skript som beter sig på rätt sätt, du kan ladda ner det [här][1] (vissa kameramodeller kräver [det här][2] i stället, ger bättre kvalité men är långsammare). Lägg det i din PATH någon stans, t.ex. /usr/bin.

Kommandon för att göra ovanstående:

> cd /usr/bin/  
> sudo wget http://ftp.penguin.cz/pub/users/utx/gnome-dcraw/dcraw-thumbnailer  
> sudo chmod +x dcraw-thumbnailer
> 
> *(Det är 3 rader, rad 2 och 3 börjar med sudo) *

Nu är det bara en sak kvar, att få Nautilus att använda dcraw-thumbnailer.

Du kan ladda ner en schema-fil [här][3] som du lägger vart du vill, t.ex. i din hemkatalog, sedan importerar du den i Gnomes Configuration Editor.

För att göra ovanstående:

> cd  
> wget http://junkpile.se/~s/inpub/cr2.schemas  
> sudo gconf-schemas --register /home/**användare**/cr2.schemas
> 
> (där **användare** är ditt användarnamn)

Du ska allt vara klart, logga ut och in, eller kör *killall nautilus* från en konsoll för att starta om Nautilus, nu bör du ha fina tumnaglar.

**Notis**  
Jag förutsätter att du har samma kamera som jag, och att du kör ubuntu 7.10. Om du inte har det så är det ingen garanti att minna instruktioner kommer funka. Om din kamera t.ex. inte bäddar in tumnaglar i raw-filen som min gör så behöver du det alternativa skriptet. Kanske inte dina bilder är identifierade som image/x-canon-cr2 (högerklicka och välj Properties på en bild), ändra i så fall i cr2.schemas så att det stämmer mot din kamera.

Guiden är baserad på instruktionerna på https://web.archive.org/web/20080509044527/http://www.penguin.cz/~utx/gnome-dcraw jag har hoppat över stora delar av hans guide då de inte var nödvändiga för vad jag ville göra, och så gjorde jag mig egen schema-fil då hans lösning var onödig då Nautilus redan hade identifierat minna bilder korrekt.



<small></small>

 [1]: https://web.archive.org/web/20080929162118/https://web.archive.org/web/20080929162118/http://ftp.penguin.cz/pub/users/utx/gnome-dcraw/dcraw-thumbnailer
 [2]: https://web.archive.org/web/20080929162113/http://ftp.penguin.cz/pub/users/utx/gnome-dcraw/alternative_thumbnailer/dcraw-thumbnailer
 [3]: http://junkpile.se/~s/inpub/cr2.schemas
