/*
 Title: Android, Cyanogenmod och öppen källkod
 Author: nsg
 Template: post
 Permalink: /2009/09/27/android-cyanogenmod-och-oppen-kallkod/
 Date: 2009-09-27T12:19:18+00:00
 Categories: Android, Linux, Teknik
 Tags: Android, Cyanogen, cyanogenmod, google, Linux
*/
<img class="aligncenter size-full wp-image-752" title="cyanogenlogo" src="http://cdn.junkpile.se/2009/09/cyanogenlogo.png" alt="cyanogenlogo" width="450" height="65" />

Som du kanske redan vet är Android öppen källkod, men vad du kanske inte vet är exakt vad som är det, och mer viktigt vad som inte är det.

För nu två dagar sedan så fick Steve Kondik, mer känd som cyanogen som utvecklar [cyanogenmod][1] som är en variant av Android (som jag använder) ett brev från Googles juridiska avdelning. Dom krävde att han skulle ta bort mjukvara som Google äger och han inte hade rätten att publicera. Mjukvaran i fråga är saker som Gmail, Maps, Gtalk, Market och nästan &#8220;allt google&#8221;. Ett dåligt drag för Google, och ett tråkigt drag för oss användare.

Åt ena sidan förstår jag Google, det är deras program som dom har rätten att göra vad som vill med och jag kan förstår att dom vill ha kvar kontrollen över dem, över vilka versioner som installeras var, och när. Men samtidigt är det ett mycket dåligt drag av Google för på sikt kommer det bara motivera folk att utveckla alternativa lösningar (program). Det här kommer bara motivera utvecklandet av öppna program men nu i glappet kan det bli lite jobbigt.<img class="alignright size-full wp-image-753" title="android logo bot" src="http://cdn.junkpile.se/2009/09/android-logo-bot.jpg" alt="android logo bot" width="187" height="223" />

Gmail, Maps, GTalk, YouTube&#8230; är alla program som går att byta ut, det finns publika API:er från Google som man kan använda för att få samma, eller nästan samma funktionalitet. Problemet är dock Market, då market är en betallösning och förmodligen innehåller en del DRM så gissar jag på att det kommer bli svårt (om ens lagligt) ett skriva ett program som ansluter till samma databas. Alternativet är att utveckla en helt egen separat lösning. Det är dock inget som är bra för plattformen programmen kommer spridas ut över de olika marknadsplatserna, ingen utvecklare kommer orka publicera sin applikation på alla och ingen användare kommer orka leta på alla. Sedan det där med betalningar, jag litar på att Google hanterar mitt kreditkort korrekt men något litet okänt företag? Nej.

Cyanogen har sagt att han har varit i kontakt med Google och tagit reda på vad exakt som måste bort, det ser ut som att vi kommer ha ett system som startar och går att använda som en telefon (samtal, sms, m.m.) efter att han har tagit bort Googles applikationer. Dock blir det ingen rolig telefon längre så han tänker utveckla en lösning. Programmen som du hade på din telefon när du köpte den har du rätten till, så vad han kommer göra är ett program för att göra en kopia av dem för att sedan återställa dem efter att du har installerat cyanogenmod. Ingen jättebra lösning då vi förlorar framtida uppdateringar på de programmen men vi får åtminstone tills vidare en telefon i det skicket vi vill ha den.

Det ser ut att bli lite mer pyssel i framtiden för att lagligt installera en alternativ ROM på en Android-telefon.

För den intresserade så är en lista [publicerad på pastebin][2] över vad som ska bort.

> system/lib/lib**gtalk**_jni.so  
> system/lib/lib**loc**_api.so  
> system/lib/lib**pdf**reader.so  
> system/lib/libt9.so  
> system/framework/com.google.android.**gtalk**service.jar  
> system/framework/com.google.android.**maps**.jar  
> system/framework/com.htc.framework.jar  
> system/framework/com.htc.resources.apk  
> system/etc/permissions/com.google.android.**gtalk**service.xml  
> system/etc/permissions/com.google.android.**maps**.xml  
> system/app/BugReport.apk  
> system/app/Clicker.apk  
> system/app/com.amazon.mp3.apk  
> system/app/FilePicker.apk  
> system/app/**Gmail**.apk  
> system/app/**Gmail**Provider.apk  
> system/app/GoogleApps.apk  
> system/app/**GoogleCheckin**.apk  
> system/app/GoogleSettingsProvider.apk  
> system/app/**gtalk**service.apk  
> system/app/ImProvider.apk  
> system/app/Mail.apk  
> system/app/**Maps**.apk  
> system/app/**MarketUpdater**.apk  
> system/app/MediaUploader.apk  
> system/app/**NetworkLocation**.apk  
> system/app/**PDFViewer**.apk  
> system/app/SetupWizard.apk  
> system/app/**Street**.apk  
> system/app/**Talk**.apk  
> system/app/TmoImPlugin.apk  
> system/app/Vending.apk  
> system/app/**VoiceSearch**.apk  
> system/app/**YouTube**.apk  
> data/app/HTC_IME.apk  
> data/app/teeter.apk

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Android' rel='tag' target='_self'>Android</a>, <a class='technorati-link' href='http://bloggar.se/om/Cyanogen' rel='tag' target='_self'>Cyanogen</a>, <a class='technorati-link' href='http://bloggar.se/om/cyanogenmod' rel='tag' target='_self'>cyanogenmod</a>, <a class='technorati-link' href='http://bloggar.se/om/google' rel='tag' target='_self'>google</a>, <a class='technorati-link' href='http://bloggar.se/om/Linux' rel='tag' target='_self'>Linux</a>
</p></small>

 [1]: http://www.cyanogenmod.com
 [2]: http://pastebin.com/m1ca395b2