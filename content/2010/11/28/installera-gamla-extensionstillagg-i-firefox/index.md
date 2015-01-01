/*
 Title: Installera gamla extensions/tillägg i Firefox
 Author: nsg
 Template: post
 Permalink: /2010/11/28/installera-gamla-extensionstillagg-i-firefox/
 Date: 2010-11-28T17:07:23+00:00
 Categories: Linux, Teknik
 Tags: firefox, firefox 4, firefox beta, mozilla firefox
*/
Jag sitter nu för tiden med en betaversion av firefox 4, det finns i dag många extensions om har anpassats för betan men ligger lite efter, t.ex. jag ville installera ett tillägg som hade stödj för beta 5, men då jag kör beta 7 på den här datorn så gick det inte att installera. Det är dock mycket enkelt att själv uppdatera tillägget. Här är hur du enklast gör det i Ubuntu/Gnome men iden är den samma i andra system och kan lätt anpassas.

### Ladda ner xpi-filen

Steg ett är att ladda ner tillägget, det ligger i en xpi-fil. Enklast är att högerklicka på knappen &#8220;Install Anyway&#8221; och spara filen till valfritt ställe.

<p style="text-align: center;">
  <a href="http://nsg.cc/wp-content/uploads/2010/11/ff-ext1.png"><img class="size-full wp-image-940 aligncenter" title="Spara xpi-filen" src="http://nsg.cc/wp-content/uploads/2010/11/ff-ext1.png" alt="" width="385" height="326" /></a>
</p>

### Uppdatera paketet

<img class="size-full wp-image-939 alignright" title="Öppna xpi-filen" src="http://nsg.cc/wp-content/uploads/2010/11/ff-ext2.png" alt="" width="352" height="137" />

Nästa steg är att öppna filen, xpi-filen är egentligen en zip-fil så du kan använda valfritt program för syftet. Jag dubbelklickade bara på filen så öppnade &#8220;File Roller/Archive Manager&#8221; filen. Du kan även högerklicka på filen som synes på bilden om vill vara säker på vad som händer, första valet är det som kommer hända när du dubbelklickar.  
Filen du vill redigera heter &#8220;install.rdf&#8221;, det är bara att dubbeklicka  på den för att öppna filen i &#8220;gedit/Text Editor&#8221;. Leta upp raden &#8220;<!-- Firefox -->&#8221;, några rader under står det <em:maxVersion>version</em:maxVersion>, byt ut version mot din version eller en större. Nu är det bara att spara filen, dialogen under kommer dyka upp. Det är bara att klicka på uppdatera. gedit kommer nu förmodligen att du vill spara filen igen, det kommer inte gå då den inte existerar längre. Stäng bara programmet samt File Roller.[<img class="aligncenter size-full wp-image-937" title="Spara ändringen i xpi-filen" src="http://nsg.cc/wp-content/uploads/2010/11/ff-ext4.png" alt="" width="378" height="235" />][1]

### Klart

Nu ska det vara klar, du kan öppna filen i webbläsaren mha. File > Open File men enklast är det att helt enkelt dra filen och släppa den i webbläsarfönstret. Nu kommer det gå att installera tillägget, att det funkar är dock ingen garanti då det kanske fanns en orsak att din version inte var uppskriven. I mitt fall chansade jag på att utvecklaren bara inte hade hunnit uppdaterat sitt paket och så var fallet.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/firefox' rel='tag' target='_self'>firefox</a>, <a class='technorati-link' href='http://bloggar.se/om/firefox+4' rel='tag' target='_self'>firefox 4</a>, <a class='technorati-link' href='http://bloggar.se/om/firefox+beta' rel='tag' target='_self'>firefox beta</a>, <a class='technorati-link' href='http://bloggar.se/om/mozilla+firefox' rel='tag' target='_self'>mozilla firefox</a>
</p></small>

 [1]: http://nsg.cc/wp-content/uploads/2010/11/ff-ext4.png