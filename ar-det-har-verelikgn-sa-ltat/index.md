/*
 Title: Är det här verelikgn så ltät…?
 Author: nsg
 Template: post
 Permalink: /2007/10/08/ar-det-har-verelikgn-sa-ltat/
 Date: 2007-10-08T10:42:41+00:00
 Categories: Tankar, Teknik
*/
Du har säkert hört talats som att det går och läsa text även om man blandar om bokstäverna i ett ord, så länge den första och sista bokstaven sitter på rätt plats. Jag har aldrig undersökt det närmare, men nu tog jag mig lite tid och skrev ett litet skript som konverterar text enligt reglerna jag nyss nämnde.

Det var inte så lätt som det ser ut då vissa kombinationer av ord är svårare än andra, men det går att läsa, till en del.

> Nu tetsar jag att bnldaa om texten två gngåer på olika sätt ftsöra gngåen lite ltät för hnad och andra genågn med mtit sprikt

> Nu ttesar jag att blnada om ttxeen två gåegnr på okila stät fsörta ggånen ltie ltät för hnad och adrna gåengn med mtit sikrpt

Läsbart ja, till en viss del. Jag provade att läsa en artikel från DN, men det var inte lätt <img src="http://nsg.cc/wp-includes/images/smilies/icon_smile.gif" alt=":)" class="wp-smiley" /> 

Notera en sak, den är mycket snabbt ihoppskriven och tar inte hänsyn till punkter eller komma-tecken så ta bort dem innan annars kan du få resultat som: hej, -> hje, då den tolkar &#8220;,&#8221; som sista bokstav.

[Skriptet jag pratar om][1]

**Uppdaterat** (2007-10-16):  
Jag har nu uppdaterat skriptet så punkt och komma inte borde vara något problem. Här kommer en artikel från [DN.se][2]

> Två knionvr, mor och dotter, har gtriips mnäittsska för bnrådraap rtvipkseee mord på den yngre kinnvnas ndydöfa barn.
> 
> Den yngre knniavn är i 4sder0råål-n och den ädrle i 6å-eråsdl0rn. De gpers vid lnhitcud på tsdaeign av Geoälrssglvebpion.  
> Vid 1edi6t-n hdae ännu iegnt dött bran pfåtfaätrs.  
> Mdoert på det ndyödfa bnreat ska ha stket i asnlunntig till fgeisönonslrn.  
> - Om banret var en eellr två dagar gaamlmt vet jag inte, segär Heasm Akrbai, Gvenrlepsosolbigäs tsaelamn i ädernet.  
> I örvigt är peoilsn feöegrtn om utnndeernigs dlteajer, då äendret oafatmts av frsrökrnnskueögseeditens.  
> Udner etrmedidagfen idneleds fröhör med de bdåa kinrnonva.  
> Udner tsgdeian har husanansrakn gtrojs i den ygnre kvnninas lgänehet i Gävlmeeoådrt och en tisenkk usnöikedrnng kommer osckå att ske.

:: Språk, Text, Hjärnan

<small></small>

 [1]: http://junkpile.se/~s/public/scr/
 [2]: http://www.dn.se/DNet/jsp/polopoly.jsp?d=147&a=705108