+++
date = "2006-11-11T04:52:00+00:00"
title = "Picasa"
+++

Jag upptäckte idag att [Picasa][1] fanns för Linux ([här][2]). Då jag inte kör windows aktivt så är det ett av många program som jag aldrig hade provat.

Programmet körs inte &#8220;native&#8221; utan emuleras via [wine][3] men det verkar funka bra, vissa saker som t.ex. att bränna cd-skrivor finns inte med, men skulle man vilja ha det ändå?

Jag vet inte ännu om jag kommer börja använda det eller inte, det har sina fördelar men man är väldigt begränsad, den envisas med att aldrig ändra orginalbilden, om man ber den att spara så skapar den en bakup, mjo, kan vara bra men arkivet jag arbetar med nu är på 2.4Gb, och det är inte allt, om den ska göra massa bakuper på alla filer jag petar lite på, då blir jag tokig.

En fullösning vore att skriva ett shell-script som rensar upp :) Men det hade varit bättre om det fanns en sådan inställning.

An annan lustig sak är att enligt hjälpen så ska det finnas flera olika alternativ för att spara.

> Save -- Select &#8220;Save&#8221; from the right-click menu when you want to save changes for an individual picture (or a group of selected photos).
> 
> Save Changes -- The “Save Changes” button appears for folders with edited photos. Clicking “Save Changes” will save all the edits for a particular folder.
> 
> Save a Copy -- This is the quickest way to create a copy of a photo. The copy will have the same filename with a “-1” at the end.
> 
> Save As -- Click &#8220;File&#8221; > &#8220;Save as &#8221; when you want to create a copy with a different file name or save your copy to a different location.

<img id="image134" src="http://cdn.junkpile.se/2006/11/picasa1.png" alt="picasa1.png" align="left" />  
Men det enda jag har hittat är &#8220;Save a Copy&#8221; som är det minst attraktiva alternativet.  
&#8220;Save&#8221; och &#8220;Save Changes&#8221; hade varit trevligt och kunna använda, bara och ta bort säkerhetskopian med ovan nämda shell-script sedan för att rensa upp. Men då jag inte hittar det så&#8230; hmpf.

En tanke var att det var en skillnad mellan windows och linuxversionen, men enligt deras egen lista så framgår det inte att så är fallet, har inte provat och installera under windows ännu.

Jag får undersöka det närmare med windowsversionen.

För övrigt vet jag inte om jag gillar sorteringen på metadata eller inte, visst det är mycket trevligt sätt och visa på men det kan även bli lite rörigt.

När jag var med i mottagningen i skolan så var vi flera som fotograferade den, vi hade en filstruktur som såg ut som följande.

*ÅÅMMDD-Händelse/Andvändarnamn/*

Men när jag lär picasa visa den strukturen så blev det en himla röra, då slutkatalogen slutade på ett användarnamn så blev resultatet i stil med.

*   Användare 1
*   Användare 1
*   Användare 1
*   Användare 2
*   Användare 3
*   Användare 1
*   Användare 2
*   Användare 2
*   Användare 1

Hurra!, eller inte.

För övrigt ville jag flytta en katalog, men det hittade jag inte heller något sätt och göra, bah, öppnar väl en terminal och göra det istället då tänkte jag och fann en sak till jag saknar, det framgår inte vart på hårddisken jag är, det enda sättet jag hittade var att högerklicka på en bild och välja &#8220;Properties&#8221;, lite omständigt då det finns gott om skärmyta för att visa aktuell sökväg.

En sak som kan vara viktigt och notera, om man ändrar i en bild så skrivs den inte över, utan en ini-fil skapas och hamnar i samma katalog så att andringarna appliceras igen varje gång bilden visas.

Som jag började med och säga är det ett trevligt program, om man har planer och fortsätta och använda det så funkar det bra, men kan ha bilderna i en himla röra på hårddisken men välsorterat i picasa. Mörka bilder är tillfixade, men inte sparade utan en ini-fil som beskriver ändringen.

Allt frid och fröjd tills du ska andvända något annat program, alla filerna ligger överallt på hårddisken, alla ser ut i orginal och du måste börja som med att vrida, fixa ljus &#8230;

Nej, tack, där kommer min förklaring varför jag vill skriva över bilderna. Rotera, visst. Fixa ljus/färg, om det blev bättre, ja, jag kommer inte ångra mig.

Det känns som hela inlägget klankar ner på picasa men det är min spontana känsla efter att ha kört det ett tag.

Edit:

[Intressant][4], han tar upp många saker som jag glömde eller inte tog upp då det kändes som att jag har klagat enog :) 

:: Picasa, Bilder, Linux, Wine

<small></small>

 [1]: http://picasa.google.com/
 [2]: http://picasa.google.com/linux/index.html
 [3]: http://www.winehq.com/
 [4]: http://www.theinquirer.net/default.aspx?article=32088
