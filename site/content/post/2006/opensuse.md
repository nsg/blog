+++
date = "2006-07-27T12:17:03+00:00"
title = "OpenSUSE &#8211; SUSE Linux 10.1"
+++

**SUSE Linux 10.1**

Jag städade ren min 120G hårdisk igår och installerade OpenSUSE på den, mest för att testa lite hur det går för den. Jag har kört det en gång tidigare för ca 3 år sedan i skolan under en period på några veckor då vi höll på med administration av en unix/linux dator och SUSE var deras val.

Jag hade itne så stor koll på vart jag skulle bege mig för att ladda ner suse, jag gick till [suse.org][1] som verkarde logiskt, blev redictad till [novell.com/linux][2] och började leta, men i sann företragsanda så hamnade man bara på deras köpalternativ hela tiden, smart men irriterande :) 

Efter en omgång i google fattade jag att dom hade gjort på samma vis som med redhat/fendora och att det var [opensuse.org][3] som gällde.

Jag var inte på humör att ladda ner 5, 5! FEM! skivor då jag har en snabb uppkoppling och borde kunna ladda ner allt under installationen, att ta ner dvd:n i stället var inte heller något val då jag inte har en dvd-brännare. Jag såg rätt fort att det fanns en &#8220;net-install&#8221; men att hitta iso:n för den var inte lätt, sidan är en wiki så det är möjligt att läken hade försvunnit eller något, men lagom irriterande, men efter ett tag kom jag fram till vad jag skulle ha.

**Installation**

Jag bootade upp skivan och hamnade i ett gui, ett medelande kom upp att den inte kunde hitta nägra installationfiler och jag blev dumpat i ett ncurses-gui. Här fanns möjligheten att välja net-install, men det fanns ingen inbyggd böjlighet att få välja källor inne ifrån gui:et utan den ville kort och gott bara ha ett ip-nummer. Jo, den var anpassad framförallt för att köra innom ett eget nät för företag och det märks att dom riktar sig mot det.

Jag slog igång min laptop och rotade fram en bra spegel, pingade den för att få ip:t och skrev in det, sedan kom det jobbiga, att skriva av en 3-mil lång sökväg till filerna, jag kan som vanligt inte stava så efter 3 misslyckade försök kom jag tillslut vidare. (Den backade till böran av val av källa varje gång jag skrev fel, men tack och lov mindes den de gamla uppgifterna).

Efter ett tag kom installationprogrammet upp (YaST2), upplägget var helt ok, ska inte direkt klaga på något men det fanns en störande sak, som genomsyrar YaST2, dom är väldigt dåliga på och visa att något händer, t.ex. i början av installationen stod det något i stil med &#8220;Bygger katalog&#8221;, ok, jag väntade, väntade, och funderade seriöst att trycka på reset många gånger, men det var inget fel, det tog bara tid (minuter), när det startar en process som tar sådan lång tid så är det VIKTIGT att man meddelar det på något vis. Samma ska hände när jag tyckte på &#8220;Finish&#8221;, den bara stod där och gjorde något kul i 15-20 sek innen den gick vidare.

Den var duktig på att fatta vart den skulle ligga, partionera o.s.v. jag behövde bara göra en mindre ändrig för att det skulle bli som jag ville.  
Den hade en liten &#8220;feature&#8221; som öppnade en ruta där det stod något i stil med &#8220;Hårdvarukoll efter nätvarkskort kommer nu ske&#8221; med svå knappar \[kolla\] \[kolla inte\], mjo, säkert en bra tanke om man inte vill slösa tid på att kolla efter sådant man inte har, men den stora naktdelen är att man måste sitta klistrad vid datorn och vänta och klicka, vänta och klicka, mer irritation är nytta enligt mig.

Ett val mellan [Gnome][4] och [KDE][5] kom även upp, jag valde Gnome.

**Bootad och klar**

<img id="image90" src="/images/2006/07/suse-blandat.png" alt="suse-blandat.png" />

*Här kör jag gnome-terminal, YaST, Nautilus och Firefox.*

Den startar fint och ger ifrån sig ett konsoll-beep vid inloggningsprompten, GAAA! hatar sådant. Annars verkar allt vara i sin ordning, allt är installerat och då menar jag verkligen ALLT. Hade jag inte bara testat systemet så skulle jag avinstallera massor av program, känns onödigt och ha saker som man uppdaterar, tar ner patchar till o.s.v. och så använder man alldrig det.

Jag klickade på updateringsmanagern som lös upp nere vid klockan, den visade att det var en himmla massa paket att uppdatera, men misslyckades med det p.g.a. av något paket som krävde något som var trasigt. Jaha, jag startade YaST updater som uppdaterade något, jag provade igen och fick följande roliga meddelande.

<img id="image91" src="/images/2006/07/suse-bugg.png" alt="suse-bugg.png" />

Kul nu krachade hela programmet instället, jag gick tillbaka till YaST och lät den uppdatera instället, men all sin seghet och allt som jag nämde tidigare :) 

<img id="image92" src="/images/2006/07/YaST2-update.png" alt="YaST2-update.png" />

En intressant sak var att det som standard bara var ett skrivbord inställt, användarvänligt men lite udda då det enligt min mening är en trivial del av linux då vissa apps blir jobbga och köra om man inte har ett eget skrivbord för dem (tänk The Gimp).

**Slutsats**

Suse märks att den är anpassad till företag, iallfall till mycket större del än Ubuntu var, [Ubuntu][6] är hittils min rekommandation om du inte kan så mycket om linux. Kan du mycket, kör [Gentoo][7]!

:: Linux, SUSE, OpenSUSE, YaST, YaST2, Novell

<small></small>

 [1]: http://www.suse.org
 [2]: http://www.novell.com/linux/
 [3]: http://www.opensuse.org
 [4]: http://www.gnome.org
 [5]: http://www.kde.org
 [6]: http://www.ubuntu.com
 [7]: http://www.gentoo.org
