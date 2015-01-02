/*
 Title: Använd din android/HTC magic som modem
 Author: nsg
 Template: post
 Permalink: /2009/07/22/anvand-din-androidhtc-magic-som-modem/
 Date: 2009-07-22T00:08:44+00:00
 Categories: Android, Internet, Linux, Teknik
 Tags: Android, htc magic, openvpn, ubuntu
*/
Som jag [skrev i förra inlägget][1] så tänkte jag låta min telefon ersätta mitt mobila bredband, och nu när den har kommit så kommer en guide hur man gör för att komma igång under Ubuntu Linux.

> *Det kräver att du har lite koll på datorer och Linux för att kunna följa med, har du frågor så skriv en kommentar så hjälper jag till.*

Jag har en HTC Magic som är köpt i Sverige, något som de nordiska telefonerna har gemensamt är att HTC har varit och ändrar lite på koden i Android. Vissa förbättringar, och vissa försämringar. En av de sämre är att dom har tagit bort stöd för att kunna använda iptables. Iptables är det som används i Linux för att begränsa och skicka vidare trafik, precis vad en vanlig router gör. Tyvärr innebär det att du inte har lika mycket <img class="alignright size-medium wp-image-717" title="htc-magic-2" src="http://cdn.junkpile.se/2009/07/htc-magic-2-300x284.jpg" alt="htc-magic-2" width="300" height="284" />möjligheter, det finns dock en lösning och den heter AziLink och kräver att du har USB-sladden i.

*Har du en icke-nordisk Magic eller någon annan modell så kanske du har stödj för iptables, i så fall rekommenderar jag att du kollar upp andra alternativ då du med dem kan använda wlan:et eller blåtand för att koppla ihop telefonen med din dator. Den nordiska Magic identifieras med att det står &#8220;HTC&#8221; på baksidan (inte Google).*

### Förbereda

Innan du börjar måste du installera lite saker på datorn, så glöm inte att förbereda det först innan kopplar bort din vanlig uppkoppling för att prova.

*   Ladda ner *Android SDK* från <http://developer.android.com/sdk/> och packa upp det på valfritt ställe, lägg det t.ex. i din hemkatalog.
*   Ladda ner och installera OpenVPN med:  
    *sudo apt-get install network-manager-openvpn openvpn*
*   Ladda ner filen azilink.ovpn från <http://code.google.com/p/azilink/downloads/list> och lägg på valfritt ställe.
*   Ladda ner azilink.apk från <http://lfx.org/azilink/azilink.apk> och lägg på valfritt ställe.

### Konfigurera

Nu har du laddat ner allt du behöver, börja med att gå in i telefonen under **Settings > Applications > Unknown sources** och välj den så att du kan installera azilink.apk på din telefon. På nästan samma ställe under **Settings > Applications > Development > USB debugging** slår du på den.

Öppna nu en terminal om du inte redan har en öppen.

Nu behöver du skapa en fil för att Linux ska hantera telefonen på rätt sätt, döp filen till **51-android.rules** och lägg den i **/etc/udev/rules.d/**, för att göra det med ett kommando skriv:

> *gksudo gedit */etc/udev/rules.d/51-android.rules

Filen ska innehålla:

> <small>SUBSYSTEM==&#8221;usb&#8221;,SYSFS{idVendor}==&#8221;0bb4&#8243;,ATTR{idProduct}==&#8221;0c02&#8243;,SYMLINK+=&#8221;android_adb&#8221;,MODE=&#8221;0666&#8243;,OWNER=&#8221;USERNAME&#8221;<br /> SUBSYSTEM==&#8221;usb&#8221;,SYSFS{idVendor}==&#8221;0bb4&#8243;,ATTR{idProduct}==&#8221;0c01&#8243;,SYMLINK+=&#8221;android_fastboot&#8221;,MODE=&#8221;0666&#8243;,OWNER=&#8221;USERNAME&#8221;</small>
> 
> (Notera USERNAME, byt ut det mot ditt användarnamn)

Ändra filen /etc/resolv.conf med:

> gksudo gedit /etc/resolv.conf

Den ska innehålla

> domain lan  
> search lan  
> nameserver 192.168.56.1

Stoppa nu in USB-kabeln till telefonen (sitter den redan i, ta ur den och sätt i den igen).

Gå nu in i katalogen tools med en terminal, du hittar katalogen i Androids SDK som du packade upp tidigare. I den ligger ett program som heter adb som vi kommer använda (eventuellt går det att kopiera adb och ta bort resten av SDK:n, inget jag provat själv).

Prova nu om adb hittar din telefon med **./adb devices**, du bör få tillbaka en träff som liknar &#8220;*HT85FKF11362  device*&#8220;.

### Installera

För att installera azilink.apk på din telefon skriv **./adb install sökväg\_till\_apk_fil**, t.ex. om filen ligger i tools-katalogen:

> *./adb install azilink.apk*

Om allt har gått bra så är nu AziLink installerad på din telefon, starta nu programmet på telefonen och välj &#8220;Service Active&#8221;. Du kan hålla ett öga på status i programmet längre fram om du vill.

### Anslut

Då jag inte använder NetworkManager så stäng av den med:

> sudo /etc/init.d/NetworkManager stop

För att ansluta börja med att skapa en anslutning mellan telefonen och din dator med:

> ./adb forward tcp:41927 tcp:41927

För att sedan starta OpenVPN med konfigurationsfilen du laddade ner tidigare. **sudo openvpn --config sökväg\_till\_azilink.ovpn**, t.ex om azilink.ovpn ligger i tools:

> sudo openvpn --config azilink.ovpn

Massa text kommer komma upp, efter ett tag bör du se &#8220;Initialization Sequence Completed&#8221; och det bör stå &#8220;Connected to host&#8221; under status på telefonen. Prova nu att surfa på nätet.

### Avbryt och återanslut

För att avbryta, tryck control-c i terminalen. För att sedan ansluta vid ett senare tillfälle så så måste du köra följande kommandon:

*   sudo /etc/init.d/NetworkManager stop (bara om du har startat den igen, eller startat om datorn)
*   Aktivera AziLink på telefonen (om den inte är aktiverad längre).
*   ./adb forward tcp:41927 tcp:41927 (bara om du har loggat ut eller startat om datorn)
*   sudo openvpn --config azilink.ovpn

### Återställ NetworkManager

Vill du få tillbaka NetworkManager igen så skriv bara:

> sudo /etc/init.d/NetworkManager start
> 
> (eller starta om datorn)

### **Slutsats**

När jag fick ner alla steg på svart och vitt så insåg jag att det blev ett par steg, eventuellt kan jag hacka ihop några skript för att förenkla installationen och hanteringen längre fram. Någon som känner att dom har nytta av det så säg till. Jag kommer nog dock för min egen skull skiva nått som gör det enklare (automatiskt) att använda när saker redan är konfigurerade.

<small> <p class='technorati-tags'>
  Bloggar om: <a class='technorati-link' href='http://bloggar.se/om/Android' rel='tag' target='_self'>Android</a>, <a class='technorati-link' href='http://bloggar.se/om/htc+magic' rel='tag' target='_self'>htc magic</a>, <a class='technorati-link' href='http://bloggar.se/om/openvpn' rel='tag' target='_self'>openvpn</a>, <a class='technorati-link' href='http://bloggar.se/om/ubuntu' rel='tag' target='_self'>ubuntu</a>
</p></small>

 [1]: http://nsg.cc/2009/07/20/tankar-och-skillnader-om-htcs-android-telefoner/